#include "build_profiles.hpp"

#define NOMINMAX
#include <windows.h>

#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <cstring>
#include <iostream>
#include <fstream>
#include <iterator>
#include <string>
#include <vector>

using namespace reverse_assist::compatibility;

#define CHECK(condition)                                                        \
    do                                                                          \
    {                                                                           \
        if (!(condition))                                                       \
        {                                                                       \
            std::cerr << "CHECK failed at line " << __LINE__ << ": "           \
                      << #condition << '\n';                                    \
            return 1;                                                           \
        }                                                                       \
    } while (false)

bool file_signature_matches(const std::vector<std::uint8_t> &file,
                            std::uintptr_t rva,
                            const std::uint8_t *signature,
                            std::size_t signature_size)
{
    if (file.size() < sizeof(IMAGE_DOS_HEADER)) return false;
    const auto *dos = reinterpret_cast<const IMAGE_DOS_HEADER *>(file.data());
    if (dos->e_magic != IMAGE_DOS_SIGNATURE || dos->e_lfanew <= 0 ||
        static_cast<std::size_t>(dos->e_lfanew) >
            file.size() - sizeof(IMAGE_NT_HEADERS64))
        return false;
    const auto *nt = reinterpret_cast<const IMAGE_NT_HEADERS64 *>(
        file.data() + dos->e_lfanew);
    if (nt->Signature != IMAGE_NT_SIGNATURE ||
        nt->OptionalHeader.Magic != IMAGE_NT_OPTIONAL_HDR64_MAGIC)
        return false;
    const auto *section = IMAGE_FIRST_SECTION(nt);
    for (unsigned index = 0; index < nt->FileHeader.NumberOfSections;
         ++index, ++section)
    {
        const auto start = static_cast<std::uintptr_t>(section->VirtualAddress);
        const auto span = static_cast<std::uintptr_t>(
            std::max(section->Misc.VirtualSize, section->SizeOfRawData));
        if (rva < start || rva - start > span ||
            signature_size > span - (rva - start))
            continue;
        const auto offset = static_cast<std::size_t>(section->PointerToRawData) +
                            static_cast<std::size_t>(rva - start);
        return offset <= file.size() && signature_size <= file.size() - offset &&
               std::memcmp(file.data() + offset, signature, signature_size) == 0;
    }
    return false;
}

int main(int argc, char **argv)
{
    constexpr std::size_t image_size = 0x02000000;
    std::vector<std::uint8_t> image(image_size, 0xcc);
    for (const auto &hook : verified_ats_160_1_8_hooks)
        std::copy(hook.signature.begin(), hook.signature.end(),
                  image.begin() + hook.rva);

    const auto reader = [&](std::uintptr_t rva, const std::uint8_t *bytes,
                            std::size_t size) {
        return rva <= image.size() && size <= image.size() - rva &&
               std::memcmp(image.data() + rva, bytes, size) == 0;
    };

    bool exact = false;
    std::size_t failed = 99;
    const auto *public_build = select_build_profile(
        build_profiles[0].executable_sha256, reader, &exact, &failed);
    CHECK(public_build == &build_profiles[0]);
    CHECK(exact);

    // A second binary digest is supported by the separately declared
    // signature-compatible profile when all enabled hooks remain verified.
    const auto *compatible_build = select_build_profile(
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
        reader, &exact, &failed);
    CHECK(compatible_build == &build_profiles[4]);
    CHECK(!exact);

    // Bytes at an old, inactive lifecycle helper are intentionally irrelevant.
    image[0x015288d0] ^= 0xff;
    compatible_build = select_build_profile("SECOND-BUILD", reader, &exact, &failed);
    CHECK(compatible_build == &build_profiles[4]);

    // Any mismatch in an actually enabled hook causes safe rejection.
    const auto &required = verified_ats_160_1_8_hooks[2];
    image[required.rva] ^= 0xff;
    CHECK(select_build_profile("UNSUPPORTED", reader, &exact, &failed) == nullptr);
    CHECK(failed == 2);

    std::vector<std::uint8_t> image161(image_size, 0xcc);
    for (const auto &hook : verified_ats_161_1_1_hooks)
        std::copy(hook.signature.begin(), hook.signature.end(),
                  image161.begin() + hook.rva);
    for (const auto &runtime : verified_ats_161_1_1_runtime_signatures)
        std::copy(runtime.signature.begin(), runtime.signature.end(),
                  image161.begin() + runtime.rva);
    const auto reader161 = [&](std::uintptr_t rva,
                               const std::uint8_t *bytes,
                               std::size_t size) {
        return rva <= image161.size() && size <= image161.size() - rva &&
               std::memcmp(image161.data() + rva, bytes, size) == 0;
    };
    const auto *profile161 = select_build_profile(
        build_profiles[1].executable_sha256, reader161, &exact, &failed);
    CHECK(profile161 == &build_profiles[1] && exact);
    CHECK(select_build_profile("UNSUPPORTED-1.61", reader161,
                               &exact, &failed) == nullptr);

    // A mismatched 1.61 entity helper must fail closed even with the exact
    // executable digest, because every runtime call address is version-bound.
    image161[verified_ats_161_1_1_runtime_signatures[3].rva] ^= 0xff;
    CHECK(select_build_profile(build_profiles[1].executable_sha256,
                                reader161, &exact, &failed) == nullptr);
    CHECK(failed == verified_ats_161_1_1_hooks.size() + 3);

    std::vector<std::uint8_t> image1612(image_size, 0xcc);
    for (const auto &hook : verified_ats_161_2_0_hooks)
        std::copy(hook.signature.begin(), hook.signature.end(),
                  image1612.begin() + hook.rva);
    for (const auto &runtime : verified_ats_161_2_0_runtime_signatures)
        std::copy(runtime.signature.begin(), runtime.signature.end(),
                  image1612.begin() + runtime.rva);
    const auto reader1612 = [&](std::uintptr_t rva,
                                const std::uint8_t *bytes,
                                std::size_t size) {
        return rva <= image1612.size() && size <= image1612.size() - rva &&
               std::memcmp(image1612.data() + rva, bytes, size) == 0;
    };
    const auto *profile1612 = select_build_profile(
        build_profiles[2].executable_sha256, reader1612, &exact, &failed);
    CHECK(profile1612 == &build_profiles[2] && exact);
    CHECK(select_build_profile("UNSUPPORTED-1.61.2", reader1612,
                               &exact, &failed) == nullptr);

    image1612[verified_ats_161_2_0_runtime_signatures[3].rva] ^= 0xff;
    CHECK(select_build_profile(build_profiles[2].executable_sha256,
                                reader1612, &exact, &failed) == nullptr);
    CHECK(failed == verified_ats_161_2_0_hooks.size() + 3);

    std::vector<std::uint8_t> image1613(image_size, 0xcc);
    const auto &current = build_profiles[3];
    for (const auto &hook : current.enabled_hooks)
        std::copy(hook.signature.begin(), hook.signature.end(), image1613.begin() + hook.rva);
    for (const auto &helper : current.runtime_signatures)
        std::copy(helper.signature.begin(), helper.signature.end(), image1613.begin() + helper.rva);
    const auto reader1613 = [&](std::uintptr_t rva, const std::uint8_t *bytes, std::size_t size) {
        return rva <= image1613.size() && size <= image1613.size() - rva &&
            std::memcmp(image1613.data() + rva, bytes, size) == 0;
    };
    CHECK(select_build_profile(current.executable_sha256, reader1613, &exact, &failed) == &current && exact);
    CHECK(select_build_profile("UNKNOWN-1.61.3", reader1613, &exact, &failed) == nullptr);
    for (const auto &hook : current.enabled_hooks) {
        image1613[hook.rva] ^= 0xff;
        CHECK(select_build_profile(current.executable_sha256, reader1613, &exact, &failed) == nullptr);
        image1613[hook.rva] ^= 0xff;
    }
    for (const auto &helper : current.runtime_signatures) {
        image1613[helper.rva] ^= 0xff;
        CHECK(select_build_profile(current.executable_sha256, reader1613, &exact, &failed) == nullptr);
        image1613[helper.rva] ^= 0xff;
    }

    std::vector<std::uint8_t> image161318(image_size, 0xcc);
    const auto &current161318 = build_profiles[5];
    for (const auto &hook : current161318.enabled_hooks)
        std::copy(hook.signature.begin(), hook.signature.end(),
                  image161318.begin() + hook.rva);
    for (const auto &helper : current161318.runtime_signatures)
        std::copy(helper.signature.begin(), helper.signature.end(),
                  image161318.begin() + helper.rva);
    const auto reader161318 = [&](std::uintptr_t rva,
                                  const std::uint8_t *bytes,
                                  std::size_t size) {
        return rva <= image161318.size() &&
            size <= image161318.size() - rva &&
            std::memcmp(image161318.data() + rva, bytes, size) == 0;
    };
    CHECK(select_build_profile(current161318.executable_sha256,
                               reader161318, &exact, &failed) ==
          &current161318 && exact);
    CHECK(select_build_profile("UNKNOWN-1.61.3.18", reader161318,
                               &exact, &failed) == nullptr);
    for (const auto &hook : current161318.enabled_hooks) {
        image161318[hook.rva] ^= 0xff;
        CHECK(select_build_profile(current161318.executable_sha256,
                                   reader161318, &exact, &failed) == nullptr);
        image161318[hook.rva] ^= 0xff;
    }
    for (const auto &helper : current161318.runtime_signatures) {
        image161318[helper.rva] ^= 0xff;
        CHECK(select_build_profile(current161318.executable_sha256,
                                   reader161318, &exact, &failed) == nullptr);
        image161318[helper.rva] ^= 0xff;
    }

    std::cout << "ATS build profile tests passed: exact 1.60/1.61.1/1.61.2/1.61.3 profiles, including executable file version 1.61.3.18; "
                 "1.60 compatible fallback; required hook/helper mismatch rejected\n";

    if (argc == 3)
    {
        std::ifstream stream(argv[1], std::ios::binary);
        CHECK(stream.good());
        std::vector<std::uint8_t> executable(
            (std::istreambuf_iterator<char>(stream)),
            std::istreambuf_iterator<char>());
        const auto file_reader =
            [&](std::uintptr_t rva, const std::uint8_t *bytes,
                std::size_t size) {
                return file_signature_matches(executable, rva, bytes, size);
            };
        const auto *exact_file = select_build_profile(
            argv[2], file_reader, &exact, &failed);
        CHECK(exact_file != nullptr && exact);
        const auto *alternate_digest = select_build_profile(
            "OFFLINE-SECOND-DIGEST", file_reader, &exact, &failed);
        CHECK(alternate_digest == nullptr && !exact);
        std::cout << "installed executable verified: " << argv[1]
                  << "; exact=" << exact_file->id
                  << "; enabled-hooks=" << exact_file->enabled_hooks.size()
                  << "; runtime-helper-checks="
                  << exact_file->runtime_signatures.size() << '\n';
    }
    return 0;
}

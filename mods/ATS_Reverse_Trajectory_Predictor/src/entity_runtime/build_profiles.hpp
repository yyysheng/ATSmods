#pragma once

#include <array>
#include <cstddef>
#include <cstdint>
#include <string_view>

namespace reverse_assist::compatibility
{
enum class HookId
{
    model_load,
    vehicle_render_dispatch,
    trailer_visual_update,
    trailer_render,
};

struct HookSpec
{
    HookId id;
    std::string_view name;
    std::uintptr_t rva;
    std::array<std::uint8_t, 16> signature;
};

struct RuntimeRvas
{
    std::uintptr_t model_activate;
    std::uintptr_t model_transfer;
    std::uintptr_t model_parameter_init;
    std::uintptr_t vehicle_accessory_collect;
    std::uintptr_t vehicle_addon_finalize;
    std::uintptr_t render_entry_populate;
    std::uintptr_t final_base_model_create;
    std::uintptr_t final_base_model_create_return;
    std::uintptr_t final_model_create;
    std::uintptr_t final_model_create_return;
    std::uintptr_t final_accessory_insert;
    std::uintptr_t final_accessory_insert_return;
    std::uintptr_t set_parent;
    std::uintptr_t set_transform;
};

struct RuntimeSignatureSpec
{
    std::string_view name;
    std::uintptr_t rva;
    std::array<std::uint8_t, 16> signature;
};

struct BuildProfile
{
    std::string_view id;
    std::string_view game_version;
    std::string_view executable_sha256;
    bool signature_compatible_fallback;
    std::array<HookSpec, 4> enabled_hooks;
    RuntimeRvas runtime;
    std::array<RuntimeSignatureSpec, 4> runtime_signatures;
};

constexpr std::array<RuntimeSignatureSpec, 4> no_runtime_signature_checks{};

constexpr std::array verified_ats_160_1_8_hooks{
    HookSpec{HookId::model_load, "model_load", 0x01518e70,
             {0x40, 0x53, 0x56, 0x41, 0x56, 0x48, 0x83, 0xec,
              0x40, 0x80, 0xbc, 0x24, 0x80, 0x00, 0x00, 0x00}},
    HookSpec{HookId::vehicle_render_dispatch, "vehicle_render_dispatch",
             0x00772aa0,
             {0x40, 0x53, 0x57, 0x48, 0x83, 0xec, 0x28, 0x48,
              0x8b, 0x42, 0x18, 0x48, 0x8b, 0xda, 0x48, 0x8b}},
    HookSpec{HookId::trailer_visual_update, "trailer_visual_update",
             0x00614c10,
             {0x48, 0x8b, 0xc4, 0x48, 0x89, 0x70, 0x10, 0x48,
              0x89, 0x78, 0x18, 0x55, 0x48, 0x8d, 0x68, 0xa1}},
    HookSpec{HookId::trailer_render, "trailer_render", 0x00615370,
             {0x48, 0x89, 0x5c, 0x24, 0x08, 0x48, 0x89, 0x74,
              0x24, 0x10, 0x57, 0x48, 0x83, 0xec, 0x30, 0x49}},
};

constexpr RuntimeRvas verified_ats_160_1_8_runtime{
    0x01529250, // model_activate
    0x0032d970, // model_transfer
    0x0040d650, // model_parameter_init
    0x006490c0, // vehicle_accessory_collect
    0x00649900, // vehicle_addon_finalize
    0x00312560, // render_entry_populate
    0x01517e50, // final_base_model_create
    0x00649cb0, // final_base_model_create_return
    0x01517da0, // final_model_create
    0x0064aa5c, // final_model_create_return
    0x005381c0, // final_accessory_insert
    0x0064b011, // final_accessory_insert_return
    0x01315340, // set_parent
    0x01315400, // set_transform
};

// ATS 1.61.1.1 Steam public executable. Hook RVAs were matched against ETS2
// 1.61 entry points; helper RVAs were matched against the installed ATS image.
// Model activation is intentionally omitted; models are submitted in render.
constexpr std::array verified_ats_161_1_1_hooks{
    HookSpec{HookId::model_load, "model_load", 0x015d9ac0,
             {0x40, 0x53, 0x56, 0x41, 0x56, 0x48, 0x83, 0xec,
              0x40, 0x80, 0xbc, 0x24, 0x80, 0x00, 0x00, 0x00}},
    HookSpec{HookId::vehicle_render_dispatch, "vehicle_render_dispatch",
             0x00799910,
             {0x48, 0x89, 0x74, 0x24, 0x20, 0x57, 0x48, 0x83,
              0xec, 0x20, 0x48, 0x8b, 0x42, 0x18, 0x48, 0x8b}},
    HookSpec{HookId::trailer_visual_update, "trailer_visual_update",
             0x006388d0,
             {0x48, 0x8b, 0xc4, 0x48, 0x89, 0x70, 0x10, 0x48,
              0x89, 0x78, 0x18, 0x55, 0x48, 0x8d, 0x68, 0xa1}},
    HookSpec{HookId::trailer_render, "trailer_render", 0x00639040,
             {0x48, 0x89, 0x5c, 0x24, 0x08, 0x48, 0x89, 0x74,
              0x24, 0x10, 0x57, 0x48, 0x83, 0xec, 0x30, 0x49}},
};

constexpr RuntimeRvas verified_ats_161_1_1_runtime{
    0x00000000, // model_activate intentionally not called on 1.61
    0x0033de40, // model_transfer
    0x0041df50, // model_parameter_init
    0x00649a10, // vehicle_accessory_collect
    0x0064a250, // vehicle_addon_finalize
    0x00312e60, // render_entry_populate
    0x00000000, // final_base_model_create (lifecycle hook disabled)
    0x00000000, // final_base_model_create_return
    0x01517fa0, // final_model_create
    0x00000000, // final_model_create_return (unused)
    0x00000000, // final_accessory_insert (unused)
    0x00000000, // final_accessory_insert_return
    0x013cc820, // set_parent
    0x013cc8e0, // set_transform
};

constexpr std::array verified_ats_161_1_1_runtime_signatures{
    RuntimeSignatureSpec{"model_transfer", 0x0033de40,
                         {0x48, 0x89, 0x5c, 0x24, 0x08, 0x48, 0x89, 0x74,
                          0x24, 0x10, 0x57, 0x48, 0x83, 0xec, 0x20, 0x48}},
    RuntimeSignatureSpec{"model_parameter_init", 0x0041df50,
                         {0x48, 0x89, 0x5c, 0x24, 0x08, 0x48, 0x89, 0x6c,
                          0x24, 0x18, 0x56, 0x57, 0x41, 0x56, 0x48, 0x83}},
    RuntimeSignatureSpec{"set_parent", 0x013cc820,
                         {0x48, 0x83, 0xec, 0x28, 0x4c, 0x8b, 0xc1, 0x4c,
                          0x8b, 0xca, 0x48, 0x8b, 0x49, 0x40, 0x48, 0x3b}},
    RuntimeSignatureSpec{"set_transform", 0x013cc8e0,
                         {0x48, 0x89, 0x5c, 0x24, 0x08, 0x57, 0x48, 0x83,
                          0xec, 0x40, 0x48, 0x8b, 0xd9, 0x48, 0x8b, 0xfa}},
};

// The first profile is the exact ATS Steam public executable verified locally.
// The second profile deliberately has no hash: it admits another ATS 1.60 binary
// only when every enabled hook has the exact verified RVA and bytes. Unused
// lifecycle helpers are not compatibility gates.
constexpr std::array build_profiles{
    BuildProfile{
        "ats-1.60.1.8-steam-public",
        "ATS 1.60.1.8",
        "3C702A9F1CADAA8756EAB68B7BAAC70460F8019434B51B877AFBE0FEAD68C7D2",
        false,
        verified_ats_160_1_8_hooks,
        verified_ats_160_1_8_runtime,
        no_runtime_signature_checks,
    },
    BuildProfile{
        "ats-1.61.1.1-steam-public",
        "ATS 1.61.1.1",
        "7C1A3CF292C1CCEDA28E4BCC1FCD285E04CCCD9A3105CAEE81E233388447CAD1",
        false,
        verified_ats_161_1_1_hooks,
        verified_ats_161_1_1_runtime,
        verified_ats_161_1_1_runtime_signatures,
    },
    BuildProfile{
        "ats-1.60-compatible-hook-layout",
        "ATS 1.60.x signature-compatible",
        "",
        true,
        verified_ats_160_1_8_hooks,
        verified_ats_160_1_8_runtime,
        no_runtime_signature_checks,
    },
};

template <typename SignatureReader>
bool enabled_hook_signatures_match(const BuildProfile &profile,
                                   SignatureReader &&reader,
                                   std::size_t *failed_index = nullptr)
{
    for (std::size_t index = 0; index < profile.enabled_hooks.size(); ++index)
    {
        const auto &hook = profile.enabled_hooks[index];
        if (!reader(hook.rva, hook.signature.data(), hook.signature.size()))
        {
            if (failed_index) *failed_index = index;
            return false;
        }
    }
    return true;
}

template <typename SignatureReader>
bool runtime_signatures_match(const BuildProfile &profile,
                              SignatureReader &&reader,
                              std::size_t *failed_index = nullptr)
{
    for (std::size_t index = 0; index < profile.runtime_signatures.size(); ++index)
    {
        const auto &runtime = profile.runtime_signatures[index];
        if (runtime.name.empty()) continue;
        if (!reader(runtime.rva, runtime.signature.data(),
                    runtime.signature.size()))
        {
            if (failed_index)
                *failed_index = profile.enabled_hooks.size() + index;
            return false;
        }
    }
    return true;
}

template <typename SignatureReader>
bool profile_signatures_match(const BuildProfile &profile,
                              SignatureReader &&reader,
                              std::size_t *failed_index = nullptr)
{
    return enabled_hook_signatures_match(profile, reader, failed_index) &&
           runtime_signatures_match(profile, reader, failed_index);
}

template <typename SignatureReader>
const BuildProfile *select_build_profile(std::string_view executable_sha256,
                                         SignatureReader &&reader,
                                         bool *exact_hash_match = nullptr,
                                         std::size_t *failed_index = nullptr)
{
    if (exact_hash_match) *exact_hash_match = false;
    for (const auto &profile : build_profiles)
    {
        if (profile.executable_sha256.empty() ||
            profile.executable_sha256 != executable_sha256)
            continue;
        if (!profile_signatures_match(profile, reader, failed_index))
            return nullptr;
        if (exact_hash_match) *exact_hash_match = true;
        return &profile;
    }
    for (const auto &profile : build_profiles)
    {
        if (!profile.signature_compatible_fallback) continue;
        if (profile_signatures_match(profile, reader, failed_index))
            return &profile;
    }
    return nullptr;
}

constexpr const HookSpec *find_hook(const BuildProfile &profile, HookId id)
{
    for (const auto &hook : profile.enabled_hooks)
        if (hook.id == id) return &hook;
    return nullptr;
}
}

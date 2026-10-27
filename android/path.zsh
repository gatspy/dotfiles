#!/usr/bin/env zsh

# Android Development Configuration
# NDK prebuilt dir is the same on Intel and Apple Silicon (universal binaries)

# Only set Android paths if SDK directory exists
ANDROID_SDK_ROOT="${HOME}/Applications/android/sdk"
if [[ ! -d "$ANDROID_SDK_ROOT" ]]; then
  # Skip Android configuration if SDK is not installed
  return 0
fi

export ANDROID_HOME=${ANDROID_SDK_ROOT}
export ANDROID_EMULATOR_HOME=${ANDROID_SDK_ROOT}/emulator
export ANDROID_CMD_TOOL=${ANDROID_SDK_ROOT}/cmdline-tools/8.0

# NDK configuration
export ANDROID_NDK_VERSION="27.0.12077973"
export ANDROID_NDK_ROOT="${ANDROID_SDK_ROOT}/ndk/${ANDROID_NDK_VERSION}"
export ANDROID_NDK_HOME="${ANDROID_NDK_ROOT}"

# NDK prebuilt dir: Google ships universal (x86_64 + arm64) mac binaries under
# the legacy darwin-x86_64 dir name (lipo-verified on 27.0/28.2) — same dir on
# both Intel and Apple Silicon hosts, no per-arch mapping needed.
local ndk_arch="darwin-x86_64"

#!/usr/bin/env zsh

# Android Development Configuration
# Uses platform detection for NDK architecture compatibility

# Only set Android paths if SDK directory exists
ANDROID_SDK_ROOT="${HOME}/Applications/android/sdk"
if [[ ! -d "$ANDROID_SDK_ROOT" ]]; then
  # Skip Android configuration if SDK is not installed
  return 0
fi

export ANDROID_HOME=${ANDROID_SDK_ROOT}
export ANDROID_EMULATOR_HOME=${ANDROID_SDK_ROOT}/emulator
export ANDROID_CMD_TOOL=${ANDROID_SDK_ROOT}/cmdline-tools/latest

# NDK configuration
export ANDROID_NDK_VERSION="27.0.12077973"
export ANDROID_NDK_ROOT="${ANDROID_SDK_ROOT}/ndk/${ANDROID_NDK_VERSION}"
export ANDROID_NDK_HOME="${ANDROID_NDK_ROOT}"

# Dynamic architecture detection for NDK
local ndk_arch=${PLATFORM_ARCH:-amd64}
case "$ndk_arch" in
    arm64)  ndk_arch="darwin-arm64" ;;
    amd64)  ndk_arch="darwin-x86_64" ;;
    *)      ndk_arch="darwin-x86_64" ;;  # fallback
esac

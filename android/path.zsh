# config Android
export ANDROID_SDK_ROOT=${HOME}/Applications/android/sdk
export ANDROID_HOME=${HOME}/Applications/android/sdk
export ANDROID_EMULATOR_HOME=${HOME}/Applications/android/sdk/emulator
export ANDROID_CMD_TOOL=${HOME}/Applications/android/sdk/cmdline-tools/latest
#export PATH="$PATH:$ANDROID_EMULATOR_HOME:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_CMD_TOOL/bin"
export PATH="$PATH:$ANDROID_EMULATOR_HOME:$ANDROID_HOME/platform-tools:$ANDROID_CMD_TOOL/bin"

export ANDROID_NDK_VERSION="23.1.7779620"
# export ANDROID_NDK_VERSION="16.1.4479499"
export ANDROID_NDK_ROOT="${HOME}/Applications/android/sdk/ndk/${ANDROID_NDK_VERSION}"
export ANDROID_NDK_HOME="${HOME}/Applications/android/sdk/ndk/${ANDROID_NDK_VERSION}"
export PATH="$PATH:$ANDROID_NDK_ROOT"

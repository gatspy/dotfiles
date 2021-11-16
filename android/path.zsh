# config Android
export ANDROID_SDK_ROOT=${HOME}/App/android/sdk
export ANDROID_HOME=${HOME}/App/android/sdk
export ANDROID_EMULATOR_HOME=${HOME}/App/android/sdk/emulator
export PATH="$PATH:$ANDROID_EMULATOR_HOME:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin"

export ANDROID_NDK_VERSION="22.0.7026061"
# export ANDROID_NDK_VERSION="16.1.4479499"
export ANDROID_NDK_ROOT="${HOME}/App/android/sdk/ndk/${ANDROID_NDK_VERSION}"
export ANDROID_NDK_HOME="${HOME}/App/android/sdk/ndk/${ANDROID_NDK_VERSION}"
export PATH="$PATH:$ANDROID_NDK_ROOT"

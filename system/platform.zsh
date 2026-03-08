#!/usr/bin/env zsh

# Platform Detection Module
# Provides unified OS and architecture detection for all modules
# This module should be loaded before any platform-specific configurations

# Detect operating system
detect_os() {
    case "$OSTYPE" in
        darwin*)  echo "darwin" ;;
        linux*)   echo "linux" ;;
        msys*)    echo "windows" ;;
        cygwin*)  echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

# Detect system architecture
detect_arch() {
    local arch=$(uname -m)
    case "$arch" in
        arm64|aarch64) echo "arm64" ;;
        x86_64|amd64)  echo "amd64" ;;
        i386|i686)     echo "386" ;;
        *)             echo "unknown" ;;
    esac
}

# Export platform variables for use in other modules
# These use the detection functions above for consistency
export PLATFORM_OS=$(detect_os)
export PLATFORM_ARCH=$(detect_arch)

# Note: PLATFORM_MACHINE is set by zsh/zshrc.symlink using uname -m directly
# and may have different values (e.g., "x86_64" vs "amd64" from detect_arch)

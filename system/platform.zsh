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

# PLATFORM_OS and PLATFORM_MACHINE are now cached in zshrc.symlink
# This ensures consistency with script/lib.sh caching mechanism
# The functions below are kept for potential use in standalone scripts

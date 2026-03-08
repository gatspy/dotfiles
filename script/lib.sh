#!/usr/bin/env zsh
# script/lib.sh - 公共函数库
#
# 提供通用的日志、检测、备份等函数

# 缓存平台信息，避免重复调用 uname
# 使用与 system/platform.zsh 相同的检测逻辑
detect_os() {
    case "$OSTYPE" in
        darwin*)  echo "darwin" ;;
        linux*)   echo "linux" ;;
        msys*)    echo "windows" ;;
        cygwin*)  echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

detect_arch() {
    local arch=$(uname -m)
    case "$arch" in
        arm64|aarch64) echo "arm64" ;;
        x86_64|amd64)  echo "amd64" ;;
        i386|i686)     echo "386" ;;
        *)             echo "unknown" ;;
    esac
}

_PLATFORM_CACHE_OS=$(detect_os)
_PLATFORM_CACHE_MACHINE=$(detect_arch)

# Platform constants for consistency (matching detect_os/detect_arch output)
readonly PLATFORM_MACOS="darwin"
readonly PLATFORM_LINUX="linux"
readonly PLATFORM_ARCH_ARM64="arm64"
readonly PLATFORM_ARCH_AMD64="amd64"

# =============================================================================
# 日志函数
# =============================================================================

# 信息日志（蓝色）
log_info() {
  echo "ℹ️  $*" >&2
}

# 成功日志（绿色）
log_success() {
  echo "✅ $*" >&2
}

# 警告日志（黄色）
log_warning() {
  echo "⚠️  $*" >&2
}

# 错误日志（红色）
log_error() {
  echo "❌ $*" >&2
}

# 标题日志
log_header() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  $*"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# =============================================================================
# 命令检测函数
# =============================================================================

# 检查命令是否存在（推荐使用）
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# 检查多个命令，全部存在返回 0
commands_exist() {
  for cmd in "$@"; do
    if ! command_exists "$cmd"; then
      return 1
    fi
  done
  return 0
}

# 检查任何命令存在
any_command_exists() {
  for cmd in "$@"; do
    if command_exists "$cmd"; then
      return 0
    fi
  done
  return 1
}

# =============================================================================
# 文件操作函数
# =============================================================================

# 备份文件（自动添加时间戳）
backup_file() {
  local file=$1
  if [[ -f "$file" ]]; then
    local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
    cp "$file" "$backup"
    log_info "Backed up $file to $backup"
  fi
}

# 创建目录（如果不存在）
ensure_dir() {
  local dir=$1
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
    log_info "Created directory: $dir"
  fi
}

# =============================================================================
# 配置操作函数
# =============================================================================

# 计算相对路径
relative_path() {
  local target=$1
  local link_path=$2
  local link_dir
  link_dir=$(dirname "$link_path")
  [[ -z "$link_dir" ]] && link_dir="."

  # 使用 python 计算相对路径
  if command -v python3 >/dev/null 2>&1; then
    python3 -c "import os.path; print(os.path.relpath('$target', '$link_dir'))"
  else
    echo "$target"
  fi
}

# 创建符号链接（支持备份，优先使用相对路径）
symlink_with_backup() {
  local src=$1
  local dest=$2

  # 扩展 ~ 为 $HOME
  src="${src/#\~/$HOME}"
  dest="${dest/#\~/$HOME}"

  # 如果目标已存在
  if [[ -e "$dest" ]]; then
    # 如果是符号链接，先删除
    if [[ -L "$dest" ]]; then
      rm "$dest"
      log_info "Removed existing symlink: $dest"
    # 如果是普通文件/目录，备份
    else
      backup_file "$dest"
      rm -rf "$dest"
    fi
  fi

  # 确保目标目录存在
  local dest_dir=$(dirname "$dest")
  [[ ! -d "$dest_dir" ]] && mkdir -p "$dest_dir"

  # 创建符号链接（使用相对路径）
  local rel_src=$(relative_path "$src" "$dest")
  ln -s "$rel_src" "$dest"
  log_success "Created symlink: $dest -> $rel_src"
}

# =============================================================================
# Git 操作函数
# =============================================================================

# 获取 Git 仓库根目录
git_root() {
  git rev-parse --show-toplevel 2>/dev/null
}

# 检查是否在 Git 仓库中
in_git_repo() {
  git rev-parse --git-dir >/dev/null 2>&1
}

# =============================================================================
# 平台检测函数
# =============================================================================

# 检测操作系统（使用缓存）
is_macos() {
  [[ "$_PLATFORM_CACHE_OS" == "$PLATFORM_MACOS" ]]
}

is_linux() {
  [[ "$_PLATFORM_CACHE_OS" == "$PLATFORM_LINUX" ]]
}

# 检测架构（使用缓存）
is_arm64() {
  [[ "$_PLATFORM_CACHE_MACHINE" == "$PLATFORM_ARCH_ARM64" ]]
}

is_amd64() {
  [[ "$_PLATFORM_CACHE_MACHINE" == "$PLATFORM_ARCH_AMD64" ]]
}

# Deprecated: use is_amd64() for consistency
is_x86_64() {
  is_amd64
}

# =============================================================================
# 交互函数
# =============================================================================

# 询问用户确认（默认为 yes）
confirm() {
  local prompt=$1
  local response

  printf "%s [Y/n] " "$prompt"
  read -r response
  case "$response" in
    [nN][oO]|[nN]) return 1 ;;
    *) return 0 ;;
  esac
}

# =============================================================================
# 进度函数
# =============================================================================

# 显示进度条
progress() {
  local current=$1
  local total=$2
  local width=50
  local percent=$((current * 100 / total))
  local filled=$((width * current / total))

  printf "\r["
  printf "%${filled}s" | tr ' ' '='
  printf "%$((width - filled))s" | tr ' ' ' '
  printf "] %d%%" "$percent"

  if [[ $current -eq $total ]]; then
    echo ""
  fi
}

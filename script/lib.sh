#!/usr/bin/env zsh
# script/lib.sh - 公共函数库
#
# 提供通用的日志、检测、备份等函数

# 缓存平台信息，避免重复调用 uname
_PLATFORM_CACHE_OS=$(uname -s)
_PLATFORM_CACHE_MACHINE=$(uname -m)

# Platform constants for consistency
readonly PLATFORM_MACOS="Darwin"
readonly PLATFORM_LINUX="Linux"
readonly PLATFORM_ARCH_ARM64="arm64"
readonly PLATFORM_ARCH_X86_64="x86_64"

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

# 创建符号链接（支持备份）
symlink_with_backup() {
  local src=$1
  local dest=$2

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

  # 创建符号链接
  ln -s "$src" "$dest"
  log_success "Created symlink: $dest -> $src"
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

is_x86_64() {
  [[ "$_PLATFORM_CACHE_MACHINE" == "$PLATFORM_ARCH_X86_64" ]]
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

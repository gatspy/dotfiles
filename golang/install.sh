#!/usr/bin/env zsh
set -euo pipefail
# Go 开发工具安装脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Installing Go development tools..."

# Check if Go is installed and GOPATH is set
if ! command_exists go; then
  log_warning "Go is not installed, skipping"
  exit 0
fi

if [[ -z "${GOPATH:-}" ]]; then
  log_warning "GOPATH is not set, skipping"
  exit 0
fi

# Create Go directories
ensure_dir "$GOPATH/bin"
ensure_dir "$GOPATH/src/github.com/"

# List of packages to install
packages=(
  "github.com/fatih/gomodifytags"
  "github.com/haya14busa/goplay/cmd/goplay"
  "github.com/josharian/impl"
  "mvdan.cc/gofumpt"
  "golang.org/x/tools/cmd/goimports"
  "github.com/cweill/gotests/gotests"
  "golang.org/x/lint/golint"
  "honnef.co/go/tools/cmd/staticcheck"
  "github.com/golangci/golangci-lint/cmd/golangci-lint"
  "github.com/mgechev/revive"
  "golang.org/x/tools/gopls"
  "github.com/go-delve/delve/cmd/dlv"
  "github.com/golang/vscode-go/vscgo"
  "github.com/kisielk/errcheck"
  "github.com/klauspost/asmfmt/cmd/asmfmt"
  "golang.org/x/tools/cmd/godoc"
  "gorm.io/gen/tools/gentool"
  "github.com/google/wire/cmd/wire"
  "github.com/swaggo/swag/cmd/swag"
  "github.com/gin-admin/gin-admin-cli/v10"
  "github.com/GoAdminGroup/adm"
  "github.com/rakyll/statik"
  "google.golang.org/protobuf/cmd/protoc-gen-go"
  "github.com/araddon/dateparse/dateparse"
  "github.com/air-verse/air"
)

# Install packages
for pkg in "${packages[@]}"; do
  log_info "Installing $pkg..."
  if go install "$pkg"@latest 2>/dev/null; then
    log_success "Installed $pkg"
  else
    log_warning "Failed to install $pkg"
  fi
done

log_success "Go development tools installation complete"

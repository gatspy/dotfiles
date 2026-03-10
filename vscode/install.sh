#!/bin/bash

echo "🚀 VS Code 极速并发版创世引擎启动！"
echo "--------------------------------------------------------------"

# 🛑 致命错误拦截：检查 code 命令是否存在
if ! command -v code &> /dev/null; then
    echo "🚨 致命错误：终端找不到 'code' 命令！"
    echo "👉 解决方法：打开 VS Code，按 Cmd+Shift+P，输入 'install code'，选择在 PATH 中安装 code 命令，然后重启终端！"
    exit 1
fi

# ==========================================
# 🧱 1. 核心 AI 与基建阵列 (10 个)
# ==========================================
BASE_EXTS=(
    "github.copilot"
    "github.copilot-chat"
    "kilocode.kilo-code"
    "vscodevim.vim"
    "eamodio.gitlens"
    "usernamehw.errorlens"
    "hverlin.mise-vscode"
    "tamasfe.even-better-toml"
    "monokai.theme-monokai-pro-vscode"
    "gruntfuggly.todo-tree"
)

# ==========================================
# 🦀 2. 硬件与底层特种部队 (5 个)
# ==========================================
RUST_EXTS=(
    "rust-lang.rust-analyzer"
    "vadimcn.vscode-lldb"
    "fill-labs.dependi"
    "ms-vscode.cpptools"
    "ms-vscode.cmake-tools"
)

# ==========================================
# 🐹 3. 云原生后端特种部队 (6 个)
# ==========================================
BACKEND_EXTS=(
    "golang.go"
    "premparihar.gotestexplorer"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.black-formatter"
    "ms-azuretools.vscode-docker"
)

# ==========================================
# 📱 4. 大前端与跨端特种部队 (9 个)
# ==========================================
CLIENT_EXTS=(
    "vue.volar"
    "biomejs.biome"
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "bradlc.vscode-tailwindcss"
    "qiu8310.minapp-vscode"
    "fangkyi03.tarojs"
    "dart-code.dart-code"
    "dart-code.flutter"
)

# 上帝视角合集
COMMANDER_EXTS=("${RUST_EXTS[@]}" "${BACKEND_EXTS[@]}" "${CLIENT_EXTS[@]}")

# ==========================================
# ⚙️ 批量并发引擎 (速度提升 100 倍)
# ==========================================
install_profile() {
    local profile_name=$1
    shift
    local extensions=("$@")

    echo "✨ 正在构建宇宙: [$profile_name] ..."

    # 构建批量安装参数
    local args=()
    for ext in "${BASE_EXTS[@]}"; do
        args+=("--install-extension" "$ext")
    done
    for ext in "${extensions[@]}"; do
        args+=("--install-extension" "$ext")
    done

    # 敞开输出，移除静默，直接并发执行！
    code --profile "$profile_name" "${args[@]}" --force

    echo "✅ [$profile_name] 宇宙构建完毕！"
    echo "--------------------------------------------------------------"
}

# ==========================================
# 🚀 执行创世计划
# ==========================================
install_profile "M4-AI-Commander" "${COMMANDER_EXTS[@]}"
install_profile "M4-Rust" "${RUST_EXTS[@]}"
install_profile "M4-Backend" "${BACKEND_EXTS[@]}"
install_profile "M4-Client" "${CLIENT_EXTS[@]}"

echo "🎉 创世大业圆满成功！"

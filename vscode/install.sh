#!/bin/bash

echo "🚀 大表哥特供：VS Code 极简 30 插件 + 多重影分身一键创世启动！"
echo "--------------------------------------------------------------"

# ==========================================
# 🧱 1. 核心 AI 与基建阵列 (10 个，所有宇宙的底座)
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

# 组合“M4-AI-Commander 上帝视角” (全量合集)
COMMANDER_EXTS=("${RUST_EXTS[@]}" "${BACKEND_EXTS[@]}" "${CLIENT_EXTS[@]}")

# ==========================================
# ⚙️ 魔法安装引擎
# ==========================================
install_profile() {
    local profile_name=$1
    shift
    local extensions=("$@")

    echo "✨ 正在构建宇宙: [$profile_name] ..."

    # 强制注入基础插件 (静默安装，保持终端干净)
    for ext in "${BASE_EXTS[@]}"; do
        code --profile "$profile_name" --install-extension "$ext" --force > /dev/null 2>&1
    done

    # 注入专属插件
    for ext in "${extensions[@]}"; do
        echo "   -> 正在装载武器: $ext"
        code --profile "$profile_name" --install-extension "$ext" --force > /dev/null 2>&1
    done
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
echo "💡 提示：在终端输入 \`code .\` 打开项目后，点击左下角 ⚙️ 切换你的专属宇宙吧！"

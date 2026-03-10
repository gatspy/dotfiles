#!/bin/bash

echo "🚀 VS Code 终极创世脚本 V3"
echo "--------------------------------------------------------------"

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

RUST_EXTS=(
    "rust-lang.rust-analyzer"
    "vadimcn.vscode-lldb"
    "fill-labs.dependi"
    "ms-vscode.cpptools"
    "ms-vscode.cmake-tools"
)

BACKEND_EXTS=(
    "golang.go"
    "premparihar.gotestexplorer"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.black-formatter"
    "ms-azuretools.vscode-docker"
)

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

COMMANDER_EXTS=("${RUST_EXTS[@]}" "${BACKEND_EXTS[@]}" "${CLIENT_EXTS[@]}")

install_profile() {
    local profile_name=$1
    shift
    local extensions=("$@")

    echo "✨ 正在构建宇宙: [$profile_name] ..."

    # ========================================================
    # 🎯 终极破解：利用弹窗强行注册 Profile，绕过微软 Bug
    # ========================================================
    echo "   -> [系统破解] 正在强行唤醒 VS Code 注册环境 (此时会弹出一个空窗口)..."
    code --profile "$profile_name"
    # 睡眠 2 秒，给 VS Code 充分的时间在硬盘写入底层注册表
    sleep 2

    # 注册成功后，开始狂暴注入插件
    for ext in "${BASE_EXTS[@]}"; do
        echo "   -> [基建注入] $ext"
        code --profile "$profile_name" --install-extension "$ext" --force
    done

    for ext in "${extensions[@]}"; do
        echo "   -> [专属武器] $ext"
        code --profile "$profile_name" --install-extension "$ext" --force
    done
    echo "✅ [$profile_name] 宇宙构建完毕！"
    echo "--------------------------------------------------------------"
}

# 🚀 执行创世计划
install_profile "M4-AI-Commander" "${COMMANDER_EXTS[@]}"
install_profile "M4-Rust" "${RUST_EXTS[@]}"
install_profile "M4-Backend" "${BACKEND_EXTS[@]}"
install_profile "M4-Client" "${CLIENT_EXTS[@]}"

echo "🎉 创世大业圆满成功！"
echo "💡 提示：你的桌面上现在应该有 4 个空白的 VS Code 窗口。不用客气，直接用 Cmd + Q 把它们全关了！"
echo "👉 下次进入项目目录，敲 'code .'，享受无缝切换的快感吧！"

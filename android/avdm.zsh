# 模拟器动态版本交互管理工具 (Zsh 官方语法修正版)
avdm() {
    # 1. 自动定位 SDK 主路径
    local sdk_path=""
    if [ -d "${HOME}/Users/gatspy/Applications/android/sdk" ]; then
        sdk_path="${HOME}/Users/gatspy/Applications/android/sdk"
    elif [ -d "/Users/gatspy/Applications/android/sdk" ]; then
        sdk_path="/Users/gatspy/Applications/android/sdk"
    else
        sdk_path="${HOME}/Library/Android/sdk"
    fi

    # 2. 动态搜寻真正的 avdmanager 路径（精准命中您的 8.0 版本）
    local avdmanager_cmd=$(find "$sdk_path/cmdline-tools" -type f -name "avdmanager" 2>/dev/null | head -n 1)

    if [ -z "$avdmanager_cmd" ] && [ -f "$sdk_path/tools/bin/avdmanager" ]; then
        avdmanager_cmd="$sdk_path/tools/bin/avdmanager"
    fi

    if [ -z "$avdmanager_cmd" ] || [ ! -f "$avdmanager_cmd" ]; then
        echo "❌ 错误：在 $sdk_path 下找不到 avdmanager 组件，请确认是否安装了 cmdline-tools！"
        return 1
    fi

    echo "========================================="
    echo "📱  Mac 本地 Android 模拟器智能管理工具"
    echo "🔍 核心驱动路径: $avdmanager_cmd"
    echo "========================================="

    # 3. 将模拟器列表存入纯净的 Zsh 数组
    local avds=()
    local line
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            avds+=("$line")
        fi
    done < <("$sdk_path/emulator/emulator" -list-avds 2>/dev/null)

    # 检查是否有模拟器存在
    if [ ${#avds[@]} -eq 0 ]; then
        echo "📭 提示：当前您的 Mac 中没有创建或残留任何安卓模拟器。"
        return 0
    fi

    # 4. 使用 Zsh 原生语法循环打印列表（Zsh 数组下标从 1 开始计数）
    echo "当前发现以下模拟器设备："
    local i
    for i in {1..${#avds[@]}}; do
        echo "  [$i] ${avds[$i]}"
    done
    echo "  [q] 退出管理"
    echo "========================================="

    # 5. 用户交互输入
    echo -n "👉 请输入要删除的模拟器数字编号 (或输入 q 退出): "
    read choice

    if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
        echo "👋 已安全退出。"
        return 0
    fi

    # 验证数字输入的有效性
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#avds[@]} ]; then
        echo "❌ 错误：输入无效，请输入列表中正确的数字！"
        return 1
    fi

    # 获取目标模拟器名字
    local target_avd="${avds[$choice]}"

    echo "========================================="
    echo "⚠️  【高危警告】"
    echo "您即将彻底删除模拟器: [ $target_avd ]"
    echo "此操作将永久从您的 Mac 中抹除该手机，并立刻释放其占用的 40G+ 空间！"
    echo "========================================="
    echo -n "⚠️ 确定要删除吗？请输入 y 确认 (输入其他任何键取消): "
    read confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "扫除进行中，请稍候..."
        # 强制静默执行深层粉碎
        "$avdmanager_cmd" delete avd -n "$target_avd" &> /dev/null
        if [ $? -eq 0 ]; then
            echo "✅ 成功！模拟器 [ $target_avd ] 已被彻底粉碎，40G+ 空间已圆满拿回！"
        else
            echo "❌ 抹除失败，请检查该模拟器是否未完全关闭！"
        fi
    else
        echo "❌ 操作已取消，数据安全。"
    fi
}

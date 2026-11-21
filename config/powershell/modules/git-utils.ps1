# =============================================================================
#  Git Utilities Module
#  实用的 Git 增强函数
# =============================================================================

# 1. [glog] 漂亮的 Git 日志树
# -----------------------------------------------------------
# 痛点：git log 默认太丑，看不清分支走向
function glog {
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all
}

function gs {
	git status  
}

# 2. [gignore] 自动生成 .gitignore 文件
# -----------------------------------------------------------
# 痛点：每次都要去搜 nodejs 的 gitignore 怎么写
# 用法：gignore node,vscode,python
function gignore {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Languages
    )
    $url = "https://www.toptal.com/developers/gitignore/api/$Languages"
    try {
        Write-Host "⬇️  正在生成 .gitignore ($Languages)..." -ForegroundColor Cyan
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
        if ($content -match "ERROR") {
            Write-Warning "未找到相关语言的模板，请检查拼写。"
        } else {
            $content | Out-File -FilePath .gitignore -Encoding utf8
            Write-Host "✅ .gitignore 已生成！" -ForegroundColor Green
        }
    } catch {
        Write-Error "网络请求失败，请检查网络。"
    }
}

# 3. [gclean] 清理已合并的本地分支
# -----------------------------------------------------------
# 痛点：项目做久了，本地堆了一堆 feature/fix 分支
function gclean {
    Write-Host "🧹 正在扫描已合并到 main/master 的分支..." -ForegroundColor Cyan
    git branch --merged | 
    Select-String -NotMatch "^\*|master|main|dev" | 
    ForEach-Object { 
        $branch = $_.ToString().Trim()
        git branch -d $branch
    }
    Write-Host "✨ 清理完成！" -ForegroundColor Green
}

# 4. [gwip] 快速“工作进行中”提交 (Work In Progress)
# -----------------------------------------------------------
# 痛点：要切分支或者是下班了，不想想 Commit 信息
function gwip {
    git add -A; git commit -m "-- wip --"
}
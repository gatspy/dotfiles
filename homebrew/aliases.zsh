#!/bin/sh
# Homebrew Aliases & Functions
# 优化版：保留原有功能，新增维护和审计命令

alias b=brew

if which brew >/dev/null 2>&1; then

    brew() {
        case "$1" in
        cleanup)
            echo '[brew] Deep cleanup started...'
            (cd "$(brew --repo)" && git prune && git gc)
            command brew cleanup
            rm -rf "$(brew --cache)"
            echo '[brew] Deep cleanup complete'
            ;;
        pull)
            echo '[brew] Full update cycle started...'
            command brew update
            if [ -z "$2" ]; then
                command brew upgrade
            else
                command brew upgrade "$2"
            fi
            brew cleanup
            echo '[brew] Full update cycle complete'
            ;;
        sort)
            echo '[brew] Listing packages by size...'
            if command -v parallel >/dev/null 2>&1; then
                brew list --formula | parallel "brew info {} | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*(/{}) \1/'" | sort -k4 -hr | column -t
            else
                brew list --formula | xargs -n1 -P8 -I {} sh -c "brew info {} | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*(/{}) \1/'" | sort -k4 -hr | column -t
            fi
            ;;
        depend)
            echo '[brew] Dependency tree (leaves only)...'
            command brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput setaf 2 sgr0)/"
            ;;
        # 新增：查看可清理空间（dry-run）
        reclaim|dry-clean)
            echo '[brew] Reclaimable space (dry run):'
            command brew cleanup --dry-run
            echo ''
            echo 'Run "brew cleanup" or "brew pull" to reclaim.'
            ;;
        # 新增：快速查看过时包数量
        outdated|od)
            echo '[brew] Outdated packages:'
            command brew outdated
            echo ''
            echo "Run 'brew pull' to upgrade all."
            ;;
        # 新增：运行审计脚本
        audit)
            if [ -x ~/.dotfiles/homebrew/bin/brew-audit ]; then
                ~/.dotfiles/homebrew/bin/brew-audit
            else
                echo '[brew] Audit script not found. Run: chmod +x ~/.dotfiles/homebrew/bin/brew-audit'
            fi
            ;;
        # 新增：运行周维护
        maintain)
            if [ -x ~/.dotfiles/homebrew/bin/brew-maintain ]; then
                ~/.dotfiles/homebrew/bin/brew-maintain
            else
                echo '[brew] Maintain script not found. Run: chmod +x ~/.dotfiles/homebrew/bin/brew-maintain'
            fi
            ;;
        *)
            command brew "$@"
            ;;
        esac
    }
fi

# 快捷别名
alias bup='brew pull'               # update + upgrade + cleanup
alias bclean='brew cleanup'         # deep cleanup
alias bout='brew outdated'          # check outdated
alias baudit='brew audit'           # run audit
alias bmaintain='brew maintain'     # run weekly maintenance

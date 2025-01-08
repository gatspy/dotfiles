#!/usr/bin/env zsh

biome() {
    case "$1" in
    install)
        echo 'start install biome in current project...'
        npm install --save-dev --save-exact @biomejs/biome
        ;;
    init)
        echo 'start init biome ...'
        npx @biomejs/biome init
        ;;
    *)
        echo 'not support other...'
        ;;
    esac
}

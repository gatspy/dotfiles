#!/bin/sh
if which brew >/dev/null 2>&1; then
	brew() {
		case "$1" in
		cleanup)
            echo 'start cleanup brew...'
			(cd "$(brew --repo)" && git prune && git gc)
			command brew cleanup
            # brew new version integrete cask cleanup
			# command brew cask cleanup
            # deprecated
			# command brew prune
			rm -rf "$(brew --cache)"
			;;
		pull)
            echo 'start upgrade brew ...'
			command brew update
			if [ -z "$2" ];then
				command brew upgrade
			fi

			if [ -n "$2" ];then
				command brew upgrade "$2"
			fi

			brew cleanup
			;;
		depend)
			echo 'start search dependency'
			command brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput setaf 2 sgr0)/"
			;;
		*)
			command brew "$@"
			;;
		esac
	}
fi

#  if command -v brew >/dev/null 2>&1; then
#    alias bu='brew update && brew upgrade'
#    alias bcu='brew cu --all --yes --cleanup'
#    alias bua='bu && bcu'
#  fi

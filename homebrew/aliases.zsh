#!/bin/sh

alias b=brew
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
		sort)
			echo 'start list all packages installed using brew and their sizes ...'
			# brew list --formula | xargs -n1 -P8 -I {} sh -c "brew info {} | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*$/{} \1/'" | sort -h -r -k2 - | column -t
			brew list --formula | parallel "brew info {} | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*(/{}) \1/'" | sort -k4 -hr | column -t
			# brew list --formula | parallel "brew info {} | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*$/{} \1/'" | sort -h -r
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

#!/usr/bin/env zsh

# Lazy load dnscrypt-proxy

alias dns=dnscrypt-proxy
export DNSCRYPT_PROXY_CFG="/usr/local/etc/dnscrypt-proxy.toml"


# if [[ $(command -v dnscrypt-proxy) == "" ]]; then
#     echo "Installing dnscrypt-proxy"
# else
#     echo "dnscrypt-proxy can not exists"
# fi

if which dnscrypt-proxy >/dev/null 2>&1; then
    dnscrypt-proxy() {
		case "$1" in
		start)
            echo 'start dnscrypt-proxy service...'
			command sudo dnscrypt-proxy -config "$DNSCRYPT_PROXY_CFG"

			;;
		resolve)
            echo "resolve $2 ..."

			if [ -n "$2" ];then
				command dnscrypt-proxy -config "$DNSCRYPT_PROXY_CFG" -resolve "$2"
			fi

			;;
		help)
			command dnscrypt-proxy -config "$DNSCRYPT_PROXY_CFG" "$@"
			;;
		*)
			command sudo dnscrypt-proxy -config "$DNSCRYPT_PROXY_CFG" "$@"
			;;
		esac
	}
fi

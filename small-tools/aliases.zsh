# Small Tools Configuration
# =========================

# Zenith - 系统监控工具
if [[ $commands[zenith] ]]; then
  alias ztop='zenith'
fi

# zdns - DNS 查询工具
if [[ -f ~/.zdns/bin/zdns ]]; then
  alias zdns='~/.zdns/bin/zdns'
fi

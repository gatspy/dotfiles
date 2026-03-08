# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  [[ -f "$HOMEBREW_PREFIX/etc/grc.zsh" ]] && source "$HOMEBREW_PREFIX/etc/grc.zsh"
fi

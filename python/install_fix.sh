#!/bin/bash

# export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
# export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"
# export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
# export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/sqlite/lib/pkgconfig"

echo -e "Setting Environment Variables"
export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(xcrun --show-sdk-path)/usr/lib -L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

echo "Done!"
echo
echo "Installing Python 3.9.0"

# env PYTHON_CONFIGURE_OPTS="--enable-framework"
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# pyenv install 3.9.0

echo "Done!"
exit 0

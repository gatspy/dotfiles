
export EMSDK_HOME=${HOME}/Projects/flutter/engine/src/buildtools/emsdk

function flutter_env() {
    source $EMSDK_HOME/emsdk_env.sh
}

function fos_env() {
    source ${HOME}/fuchsia/fuchsia/scripts/fx-env.sh
    export PATH=${HOME}/fuchsia/fuchsia/.jiri_root/bin:$PATH
}

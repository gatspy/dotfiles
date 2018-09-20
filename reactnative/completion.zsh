#compdef react-native
#autoload
typeset -ga nul_args
nul_args=(
  "--version[show program's version number and exit.]"
  {-h,--help}'[show this help message and exit.]'
)

typeset -ga runios_args
runios_args=(
  '--simulator[simulator "iPhone 7 Plus"]'
)

_reactnative-run-ios() {
  _arguments -s : \
    $runios_args \
    $nul_args && ret=0
}

_reactnative-commands() {
    local -a commands
    commands=(
        'init:<ProjectName> generates a new project and installs its dependencies'
        'android:creates an empty android project'
        'start:starts the webserver'
        'run-ios:builds your app and starts it on iOS simulator'
        'run-android:builds your app and starts it on a connected Android emulator or device'
        'new-library:generates a native library bridge'
        'bundle:builds the javascript bundle for offline use'
        'unbundle:builds javascript as "unbundle" for offline use'
        'link:[options] <packageName> links all native dependencies'
        'unlink:[options] <packageName> unlink native dependency'
        'install:[options] <packageName> install and link native dependencies'
        'uninstall:[options] <packageName> uninstall and unlink native dependencies'
        "upgrade:upgrade your app's template files to the latest version; run this after updating the react-native version in your package.json and running npm install"
        'log-android:starts adb logcat'
        'log-ios:starts iOS device syslog tail'
    )
    _describe -t commands 'react-native command' commands && ret=0
}

_reactnative() {
  local curcontext=$curcontext ret=1
  # echo CURRENT
  if ((CURRENT == 2)); then
    _reactnative-commands
  else
    shift words
    (( CURRENT -- ))
    curcontext="${curcontext%:*:*}:reactnative-$words[1]:"
    _call_function ret _reactnative-$words[1]
  fi
}

compdef _reactnative react-native
compdef _reactnative rn

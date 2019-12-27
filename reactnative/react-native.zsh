alias rn='react-native'
alias rns='react-native start'
alias rnlink='react-native link'

alias rnand='npx react-native run-android'
alias rnios='npx react-native run-ios'
alias rnios4s='npx react-native run-ios --simulator "iPhone 4s"'
alias rnios5='npx react-native run-ios --simulator "iPhone 5"'
alias rnios5s='npx react-native run-ios --simulator "iPhone 5s"'
alias rnios6='npx react-native run-ios --simulator "iPhone 6"'
alias rnios6s='npx react-native run-ios --simulator "iPhone 6s"'
alias rniosx='npx react-native run-ios --simulator="iPhone X"'
alias rnios11='npx react-native run-ios --simulator="iPhone 11"'

alias rnland='react-native log-android'
alias rnlios='react-native log-ios'

alias rnwipe='watchman watch-del-all && rm -rf ios/build && rm -rf node_modules/ && npm cache clean --force && yarn install'
alias rncls='watchman watch-del-all && npm cache clean --force'
alias rncios='watchman watch-del-all && npm cache clean --force && rm -rf ios/build'
alias rncand="watchman watch-del-all && npm cache clean --force && ./android/gradlew assembleRelease"
alias rnctmp='rm -rf $TMPDIR/react-*'

# android:build
alias rnband='cd android && ./gradlew assembleRelease'
# android:install
alias rniand='cd android && ./gradlew assembleRelease && ./gradlew installRelease'

alias rnlint='standard --verbose | snazzy'

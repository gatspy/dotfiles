#compdef pixi

autoload -U is-at-least

_pixi() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_pixi_commands" \
"*::: :->pixi" \
&& ret=0
    case $state in
    (pixi)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" : \
'(-i --import)*-c+[Channels to use in the project]:channel: ' \
'(-i --import)*--channel=[Channels to use in the project]:channel: ' \
'*-p+[Platforms that the project supports]:platform: ' \
'*--platform=[Platforms that the project supports]:platform: ' \
'-i+[Environment.yml file to bootstrap the project]:ENV_FILE:_files' \
'--import=[Environment.yml file to bootstrap the project]:ENV_FILE:_files' \
'(-i --import --pyproject-toml)--format=[The manifest format to create]:FORMAT:(pixi pyproject)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-i --import --format)--pyproject-toml[Create a pyproject.toml manifest instead of a pixi.toml manifest]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'::path -- Where to place the project (defaults to current path):_files' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-p+[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'*--platform=[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'-f+[The feature for which the dependency should be modified]:FEATURE: ' \
'--feature=[The feature for which the dependency should be modified]:FEATURE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--build --pypi)--host[The specified dependencies are host dependencies. Conflicts with \`build\` and \`pypi\`]' \
'(--host --pypi)--build[The specified dependencies are build dependencies. Conflicts with \`host\` and \`pypi\`]' \
'(--host --build)--pypi[The specified dependencies are pypi dependencies. Conflicts with \`host\` and \`build\`]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--editable[Whether the pypi requirement should be editable]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- The dependencies as names, conda MatchSpecs or PyPi requirements:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-p+[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'*--platform=[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'-f+[The feature for which the dependency should be modified]:FEATURE: ' \
'--feature=[The feature for which the dependency should be modified]:FEATURE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--build --pypi)--host[The specified dependencies are host dependencies. Conflicts with \`build\` and \`pypi\`]' \
'(--host --pypi)--build[The specified dependencies are build dependencies. Conflicts with \`host\` and \`pypi\`]' \
'(--host --build)--pypi[The specified dependencies are pypi dependencies. Conflicts with \`host\` and \`build\`]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--editable[Whether the pypi requirement should be editable]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- The dependencies as names, conda MatchSpecs or PyPi requirements:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-p+[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'*--platform=[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'-f+[The feature for which the dependency should be modified]:FEATURE: ' \
'--feature=[The feature for which the dependency should be modified]:FEATURE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--build --pypi)--host[The specified dependencies are host dependencies. Conflicts with \`build\` and \`pypi\`]' \
'(--host --pypi)--build[The specified dependencies are build dependencies. Conflicts with \`host\` and \`pypi\`]' \
'(--host --build)--pypi[The specified dependencies are pypi dependencies. Conflicts with \`host\` and \`build\`]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- The dependencies as names, conda MatchSpecs or PyPi requirements:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-p+[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'*--platform=[The platform(s) for which the dependency should be modified]:PLATFORM: ' \
'-f+[The feature for which the dependency should be modified]:FEATURE: ' \
'--feature=[The feature for which the dependency should be modified]:FEATURE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--build --pypi)--host[The specified dependencies are host dependencies. Conflicts with \`build\` and \`pypi\`]' \
'(--host --pypi)--build[The specified dependencies are build dependencies. Conflicts with \`host\` and \`pypi\`]' \
'(--host --build)--pypi[The specified dependencies are pypi dependencies. Conflicts with \`host\` and \`build\`]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- The dependencies as names, conda MatchSpecs or PyPi requirements:' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-e+[The environment to install]:ENVIRONMENT: ' \
'*--environment=[The environment to install]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'(-e --environment)-a[]' \
'(-e --environment)--all[]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(i)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-e+[The environment to install]:ENVIRONMENT: ' \
'*--environment=[The environment to install]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'(-e --environment)-a[]' \
'(-e --environment)--all[]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'*-e+[The environments to update. If none is specified, all environments are updated]:ENVIRONMENTS: ' \
'*--environment=[The environments to update. If none is specified, all environments are updated]:ENVIRONMENTS: ' \
'*-p+[The platforms to update. If none is specified, all platforms are updated]:PLATFORMS: ' \
'*--platform=[The platforms to update. If none is specified, all platforms are updated]:PLATFORMS: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--no-install[Don'\''t install the (solve) environments needed for pypi-dependencies solving]' \
'-n[Don'\''t actually write the lockfile or update any environment]' \
'--dry-run[Don'\''t actually write the lockfile or update any environment]' \
'--json[Output the changes in JSON format]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::packages -- The packages to update:' \
&& ret=0
;;
(run)
local tasks
tasks=("${(@s/ /)$(pixi task list --machine-readable 2> /dev/null)}")

if [[ -n "$tasks" ]]; then
    _values 'task' "${tasks[@]}"
else
    return 1
fi
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The environment to run the task in]:ENVIRONMENT: ' \
'--environment=[The environment to run the task in]:ENVIRONMENT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--clean-env[Use a clean environment to run the task]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::task -- The pixi task or a task shell command you want to run in the project'\''s environment, which can be an executable in the environment'\''s PATH:' \
&& ret=0
;;
(r)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The environment to run the task in]:ENVIRONMENT: ' \
'--environment=[The environment to run the task in]:ENVIRONMENT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--clean-env[Use a clean environment to run the task]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::task -- The pixi task or a task shell command you want to run in the project'\''s environment, which can be an executable in the environment'\''s PATH:' \
&& ret=0
;;
(exec)
_arguments "${_arguments_options[@]}" : \
'*-s+[Matchspecs of packages to install. If this is not provided, the package is guessed from the command]:SPECS: ' \
'*--spec=[Matchspecs of packages to install. If this is not provided, the package is guessed from the command]:SPECS: ' \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--force-reinstall[If specified a new environment is always created even if one already exists]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- The executable to run:_cmdambivalent' \
&& ret=0
;;
(x)
_arguments "${_arguments_options[@]}" : \
'*-s+[Matchspecs of packages to install. If this is not provided, the package is guessed from the command]:SPECS: ' \
'*--spec=[Matchspecs of packages to install. If this is not provided, the package is guessed from the command]:SPECS: ' \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--force-reinstall[If specified a new environment is always created even if one already exists]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- The executable to run:_cmdambivalent' \
&& ret=0
;;
(shell)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The environment to activate in the shell]:ENVIRONMENT: ' \
'--environment=[The environment to activate in the shell]:ENVIRONMENT: ' \
'--change-ps1=[Do not change the PS1 variable when starting a prompt]:CHANGE_PS1:(true false)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(s)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The environment to activate in the shell]:ENVIRONMENT: ' \
'--environment=[The environment to activate in the shell]:ENVIRONMENT: ' \
'--change-ps1=[Do not change the PS1 variable when starting a prompt]:CHANGE_PS1:(true false)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(shell-hook)
_arguments "${_arguments_options[@]}" : \
'-s+[Sets the shell, options\: \[\`bash\`,  \`zsh\`,  \`xonsh\`,  \`cmd\`, \`powershell\`,  \`fish\`,  \`nushell\`\]]:SHELL: ' \
'--shell=[Sets the shell, options\: \[\`bash\`,  \`zsh\`,  \`xonsh\`,  \`cmd\`, \`powershell\`,  \`fish\`,  \`nushell\`\]]:SHELL: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The environment to activate in the script]:ENVIRONMENT: ' \
'--environment=[The environment to activate in the script]:ENVIRONMENT: ' \
'--change-ps1=[Do not change the PS1 variable when starting a prompt]:CHANGE_PS1:(true false)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'(-s --shell)--json[Emit the environment variables set by running the activation as JSON]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(project)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project_commands" \
"*::: :->project" \
&& ret=0

    case $state in
    (project)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-command-$line[1]:"
        case $line[1] in
            (channel)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__channel_commands" \
"*::: :->channel" \
&& ret=0

    case $state in
    (channel)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-channel-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'--priority=[Specify the channel priority]:PRIORITY: ' \
'-f+[The name of the feature to modify]:FEATURE: ' \
'--feature=[The name of the feature to modify]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only modify the manifest and the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::channel -- The channel name or URL:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'--priority=[Specify the channel priority]:PRIORITY: ' \
'-f+[The name of the feature to modify]:FEATURE: ' \
'--feature=[The name of the feature to modify]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only modify the manifest and the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::channel -- The channel name or URL:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--urls[Whether to display the channel'\''s names or urls]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--urls[Whether to display the channel'\''s names or urls]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--priority=[Specify the channel priority]:PRIORITY: ' \
'-f+[The name of the feature to modify]:FEATURE: ' \
'--feature=[The name of the feature to modify]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only modify the manifest and the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::channel -- The channel name or URL:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'--priority=[Specify the channel priority]:PRIORITY: ' \
'-f+[The name of the feature to modify]:FEATURE: ' \
'--feature=[The name of the feature to modify]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only modify the manifest and the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::channel -- The channel name or URL:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__channel__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-channel-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(description)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__description_commands" \
"*::: :->description" \
&& ret=0

    case $state in
    (description)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-description-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':description -- The project description:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__description__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-description-help-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(platform)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__platform_commands" \
"*::: :->platform" \
&& ret=0

    case $state in
    (platform)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-platform-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-f+[The name of the feature to add the platform to]:FEATURE: ' \
'--feature=[The name of the feature to add the platform to]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only add changed packages to the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::platform -- The platform name(s) to add:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'-f+[The name of the feature to add the platform to]:FEATURE: ' \
'--feature=[The name of the feature to add the platform to]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only add changed packages to the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::platform -- The platform name(s) to add:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'-f+[The name of the feature to remove the platform from]:FEATURE: ' \
'--feature=[The name of the feature to remove the platform from]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only remove the platform(s) from the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::platform -- The platform name(s) to remove:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'-f+[The name of the feature to remove the platform from]:FEATURE: ' \
'--feature=[The name of the feature to remove the platform from]:FEATURE: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-install[Don'\''t update the environment, only remove the platform(s) from the lock-file]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::platform -- The platform name(s) to remove:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__platform__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-platform-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(version)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__version_commands" \
"*::: :->version" \
&& ret=0

    case $state in
    (version)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-version-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':version -- The new project version:' \
&& ret=0
;;
(major)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(minor)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__version__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-version-help-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(major)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(minor)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(environment)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__environment_commands" \
"*::: :->environment" \
&& ret=0

    case $state in
    (environment)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-environment-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'*-f+[Features to add to the environment]:FEATURES: ' \
'*--feature=[Features to add to the environment]:FEATURES: ' \
'--solve-group=[The solve-group to add the environment to]:SOLVE_GROUP: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-default-feature[Don'\''t include the default feature in the environment]' \
'--force[Update the manifest even if the environment already exists]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- The name of the environment to add:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'*-f+[Features to add to the environment]:FEATURES: ' \
'*--feature=[Features to add to the environment]:FEATURES: ' \
'--solve-group=[The solve-group to add the environment to]:SOLVE_GROUP: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--no-default-feature[Don'\''t include the default feature in the environment]' \
'--force[Update the manifest even if the environment already exists]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- The name of the environment to add:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- The name of the environment to remove:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- The name of the environment to remove:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__environment__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-environment-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(export)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__project__export_commands" \
"*::: :->export" \
&& ret=0

    case $state in
    (export)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-export-command-$line[1]:"
        case $line[1] in
            (conda-explicit-spec)
_arguments "${_arguments_options[@]}" : \
'*-e+[Environment to render. Can be repeated for multiple envs. Defaults to all environments]:ENVIRONMENT: ' \
'*--environment=[Environment to render. Can be repeated for multiple envs. Defaults to all environments]:ENVIRONMENT: ' \
'*-p+[The platform to render. Can be repeated for multiple platforms. Defaults to all platforms available for selected environments]:PLATFORM: ' \
'*--platform=[The platform to render. Can be repeated for multiple platforms. Defaults to all platforms available for selected environments]:PLATFORM: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--ignore-pypi-errors[PyPI dependencies are not supported in the conda explicit spec file. This flag allows creating the spec file even if PyPI dependencies are present]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':output_dir -- Output directory for rendered explicit environment spec files:_files' \
&& ret=0
;;
(ces)
_arguments "${_arguments_options[@]}" : \
'*-e+[Environment to render. Can be repeated for multiple envs. Defaults to all environments]:ENVIRONMENT: ' \
'*--environment=[Environment to render. Can be repeated for multiple envs. Defaults to all environments]:ENVIRONMENT: ' \
'*-p+[The platform to render. Can be repeated for multiple platforms. Defaults to all platforms available for selected environments]:PLATFORM: ' \
'*--platform=[The platform to render. Can be repeated for multiple platforms. Defaults to all platforms available for selected environments]:PLATFORM: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--ignore-pypi-errors[PyPI dependencies are not supported in the conda explicit spec file. This flag allows creating the spec file even if PyPI dependencies are present]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':output_dir -- Output directory for rendered explicit environment spec files:_files' \
&& ret=0
;;
(conda-environment)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform to render the environment file for. Defaults to the current platform]:PLATFORM: ' \
'--platform=[The platform to render the environment file for. Defaults to the current platform]:PLATFORM: ' \
'-e+[The environment to render the environment file for. Defaults to the default environment]:ENVIRONMENT: ' \
'--environment=[The environment to render the environment file for. Defaults to the default environment]:ENVIRONMENT: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'::output_path -- Explicit path to export the environment to:_files' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__export__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-export-help-command-$line[1]:"
        case $line[1] in
            (conda-explicit-spec)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(conda-environment)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-command-$line[1]:"
        case $line[1] in
            (channel)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__channel_commands" \
"*::: :->channel" \
&& ret=0

    case $state in
    (channel)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-channel-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(description)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__description_commands" \
"*::: :->description" \
&& ret=0

    case $state in
    (description)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-description-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(platform)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__platform_commands" \
"*::: :->platform" \
&& ret=0

    case $state in
    (platform)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-platform-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(version)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__version_commands" \
"*::: :->version" \
&& ret=0

    case $state in
    (version)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-version-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(major)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(minor)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(environment)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__environment_commands" \
"*::: :->environment" \
&& ret=0

    case $state in
    (environment)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-environment-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(export)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__project__help__export_commands" \
"*::: :->export" \
&& ret=0

    case $state in
    (export)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-project-help-export-command-$line[1]:"
        case $line[1] in
            (conda-explicit-spec)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(conda-environment)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(task)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__task_commands" \
"*::: :->task" \
&& ret=0

    case $state in
    (task)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-task-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'*--depends-on=[Depends on these other commands]:DEPENDS_ON: ' \
'-p+[The platform for which the task should be added]:PLATFORM: ' \
'--platform=[The platform for which the task should be added]:PLATFORM: ' \
'-f+[The feature for which the task should be added]:FEATURE: ' \
'--feature=[The feature for which the task should be added]:FEATURE: ' \
'--cwd=[The working directory relative to the root of the project]:CWD:_files' \
'*--env=[The environment variable to set, use --env key=value multiple times for more than one variable]:ENV: ' \
'--description=[A description of the task to be added]:DESCRIPTION: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--clean-env[Isolate the task from the shell environment, and only use the pixi environment to run the task]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- Task name:' \
'*::commands -- One or more commands to actually execute:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'*--depends-on=[Depends on these other commands]:DEPENDS_ON: ' \
'-p+[The platform for which the task should be added]:PLATFORM: ' \
'--platform=[The platform for which the task should be added]:PLATFORM: ' \
'-f+[The feature for which the task should be added]:FEATURE: ' \
'--feature=[The feature for which the task should be added]:FEATURE: ' \
'--cwd=[The working directory relative to the root of the project]:CWD:_files' \
'*--env=[The environment variable to set, use --env key=value multiple times for more than one variable]:ENV: ' \
'--description=[A description of the task to be added]:DESCRIPTION: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--clean-env[Isolate the task from the shell environment, and only use the pixi environment to run the task]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- Task name:' \
'*::commands -- One or more commands to actually execute:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform for which the task should be removed]:PLATFORM: ' \
'--platform=[The platform for which the task should be removed]:PLATFORM: ' \
'-f+[The feature for which the task should be removed]:FEATURE: ' \
'--feature=[The feature for which the task should be removed]:FEATURE: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::names -- Task names to remove:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform for which the task should be removed]:PLATFORM: ' \
'--platform=[The platform for which the task should be removed]:PLATFORM: ' \
'-f+[The feature for which the task should be removed]:FEATURE: ' \
'--feature=[The feature for which the task should be removed]:FEATURE: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::names -- Task names to remove:' \
&& ret=0
;;
(alias)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform for which the alias should be added]:PLATFORM: ' \
'--platform=[The platform for which the alias should be added]:PLATFORM: ' \
'--description=[The description of the alias task]:DESCRIPTION: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':alias -- Alias name:' \
'*::depends_on -- Depends on these tasks to execute:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment the list should be generated for. If not specified, the default environment is used]:ENVIRONMENT: ' \
'--environment=[The environment the list should be generated for. If not specified, the default environment is used]:ENVIRONMENT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'-s[Tasks available for this machine per environment]' \
'--summary[Tasks available for this machine per environment]' \
'--machine-readable[Output the list of tasks from all environments in machine readable format (space delimited) this output is used for autocomplete by \`pixi run\`]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment the list should be generated for. If not specified, the default environment is used]:ENVIRONMENT: ' \
'--environment=[The environment the list should be generated for. If not specified, the default environment is used]:ENVIRONMENT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'-s[Tasks available for this machine per environment]' \
'--summary[Tasks available for this machine per environment]' \
'--machine-readable[Output the list of tasks from all environments in machine readable format (space delimited) this output is used for autocomplete by \`pixi run\`]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__task__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-task-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(alias)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--platform=[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--sort-by=[Sorting strategy]:SORT_BY:(size name kind)' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-e+[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--environment=[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--json[Whether to output in json format]' \
'--json-pretty[Whether to output in pretty json format]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'-x[Only list packages that are explicitly defined in the project]' \
'--explicit[Only list packages that are explicitly defined in the project]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression:' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--platform=[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--sort-by=[Sorting strategy]:SORT_BY:(size name kind)' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-e+[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--environment=[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--json[Whether to output in json format]' \
'--json-pretty[Whether to output in pretty json format]' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'-x[Only list packages that are explicitly defined in the project]' \
'--explicit[Only list packages that are explicitly defined in the project]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression:' \
&& ret=0
;;
(tree)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--platform=[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-e+[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--environment=[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'-i[Invert tree and show what depends on given package in the regex argument]' \
'--invert[Invert tree and show what depends on given package in the regex argument]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression:' \
&& ret=0
;;
(t)
_arguments "${_arguments_options[@]}" : \
'-p+[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--platform=[The platform to list packages for. Defaults to the current platform]:PLATFORM: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-e+[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--environment=[The environment to list packages for. Defaults to the default environment]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(--no-install)--no-lockfile-update[Don'\''t update lockfile, implies the no-install as well]' \
'(--locked)--frozen[Install the environment as defined in the lockfile, doesn'\''t update lockfile if it isn'\''t up-to-date with the manifest file]' \
'(--frozen)--locked[Check if lockfile is up-to-date before installing the environment, aborts when lockfile isn'\''t up-to-date with the manifest file]' \
'--no-install[Don'\''t modify the environment, only modify the lock-file]' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'-i[Invert tree and show what depends on given package in the regex argument]' \
'--invert[Invert tree and show what depends on given package in the regex argument]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression:' \
&& ret=0
;;
(global)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global_commands" \
"*::: :->global" \
&& ret=0

    case $state in
    (global)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be added to the environment:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be added to the environment:' \
&& ret=0
;;
(edit)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::editor -- The editor to use, defaults to `EDITOR` environment variable or `nano` on Unix and `notepad` on Windows:' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'-p+[]:PLATFORM: ' \
'--platform=[]:PLATFORM: ' \
'-e+[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'--environment=[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'*--with=[Add additional dependencies to the environment. Their executables will not be exposed]:WITH: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--force-reinstall[Specifies that the packages should be reinstalled even if they are already installed]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be installed:' \
&& ret=0
;;
(i)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'-p+[]:PLATFORM: ' \
'--platform=[]:PLATFORM: ' \
'-e+[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'--environment=[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'*--with=[Add additional dependencies to the environment. Their executables will not be exposed]:WITH: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--force-reinstall[Specifies that the packages should be reinstalled even if they are already installed]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be installed:' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::environment -- Specifies the environments that are to be removed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be removed:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be removed:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The name of the environment to list]:ENVIRONMENT: ' \
'--environment=[The name of the environment to list]:ENVIRONMENT: ' \
'--sort-by=[Sorting strategy for the package table of an environment]:SORT_BY:(size name)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression. Without regex syntax it acts like a `contains` filter:' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The name of the environment to list]:ENVIRONMENT: ' \
'--environment=[The name of the environment to list]:ENVIRONMENT: ' \
'--sort-by=[Sorting strategy for the package table of an environment]:SORT_BY:(size name)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression. Without regex syntax it acts like a `contains` filter:' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(s)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(expose)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--environment=[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::mappings -- Add one or more mapping which describe which executables are exposed. The syntax is `exposed_name=executable_name`, so for example `python3.10=python`. Alternatively, you can input only an executable_name and `executable_name=executable_name` is assumed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::exposed_names -- The exposed names that should be removed:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__expose__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(e)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--environment=[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::mappings -- Add one or more mapping which describe which executables are exposed. The syntax is `exposed_name=executable_name`, so for example `python3.10=python`. Alternatively, you can input only an executable_name and `executable_name=executable_name` is assumed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::exposed_names -- The exposed names that should be removed:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__expose__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(update)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::environments -- Specifies the environments that are to be updated:' \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--platform=[The platform to install the package for]:PLATFORM: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- Specifies the packages to upgrade:' \
&& ret=0
;;
(upgrade-all)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--platform=[The platform to install the package for]:PLATFORM: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(edit)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(expose)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__help__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-help-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade-all)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(g)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global_commands" \
"*::: :->global" \
&& ret=0

    case $state in
    (global)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be added to the environment:' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be added to]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be added to the environment:' \
&& ret=0
;;
(edit)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::editor -- The editor to use, defaults to `EDITOR` environment variable or `nano` on Unix and `notepad` on Windows:' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'-p+[]:PLATFORM: ' \
'--platform=[]:PLATFORM: ' \
'-e+[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'--environment=[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'*--with=[Add additional dependencies to the environment. Their executables will not be exposed]:WITH: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--force-reinstall[Specifies that the packages should be reinstalled even if they are already installed]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be installed:' \
&& ret=0
;;
(i)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'-p+[]:PLATFORM: ' \
'--platform=[]:PLATFORM: ' \
'-e+[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'--environment=[Ensures that all packages will be installed in the same environment]:ENVIRONMENT: ' \
'*--expose=[Add one or more mapping which describe which executables are exposed. The syntax is \`exposed_name=executable_name\`, so for example \`python3.10=python\`. Alternatively, you can input only an executable_name and \`executable_name=executable_name\` is assumed]:EXPOSE: ' \
'*--with=[Add additional dependencies to the environment. Their executables will not be exposed]:WITH: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'--force-reinstall[Specifies that the packages should be reinstalled even if they are already installed]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be installed:' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::environment -- Specifies the environments that are to be removed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be removed:' \
&& ret=0
;;
(rm)
_arguments "${_arguments_options[@]}" : \
'-e+[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--environment=[Specifies the environment that the dependencies need to be removed from]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::packages -- Specifies the packages that are to be removed:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The name of the environment to list]:ENVIRONMENT: ' \
'--environment=[The name of the environment to list]:ENVIRONMENT: ' \
'--sort-by=[Sorting strategy for the package table of an environment]:SORT_BY:(size name)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression. Without regex syntax it acts like a `contains` filter:' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'-e+[The name of the environment to list]:ENVIRONMENT: ' \
'--environment=[The name of the environment to list]:ENVIRONMENT: ' \
'--sort-by=[Sorting strategy for the package table of an environment]:SORT_BY:(size name)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::regex -- List only packages matching a regular expression. Without regex syntax it acts like a `contains` filter:' \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(s)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(expose)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--environment=[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::mappings -- Add one or more mapping which describe which executables are exposed. The syntax is `exposed_name=executable_name`, so for example `python3.10=python`. Alternatively, you can input only an executable_name and `executable_name=executable_name` is assumed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::exposed_names -- The exposed names that should be removed:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__expose__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(e)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_pixi__global__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
'-e+[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--environment=[The environment to which the binaries should be exposed]:ENVIRONMENT: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::mappings -- Add one or more mapping which describe which executables are exposed. The syntax is `exposed_name=executable_name`, so for example `python3.10=python`. Alternatively, you can input only an executable_name and `executable_name=executable_name` is assumed:' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::exposed_names -- The exposed names that should be removed:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__expose__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-expose-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(update)
_arguments "${_arguments_options[@]}" : \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'*::environments -- Specifies the environments that are to be updated:' \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--platform=[The platform to install the package for]:PLATFORM: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::specs -- Specifies the packages to upgrade:' \
&& ret=0
;;
(upgrade-all)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--auth-file=[Path to the file containing the authentication token]:AUTH_FILE:_files' \
'--pypi-keyring-provider=[Specifies if we want to use uv keyring provider]:PYPI_KEYRING_PROVIDER:(disabled subprocess)' \
'--platform=[The platform to install the package for]:PLATFORM: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--tls-no-verify[Do not verify the TLS certificate of the server]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-help-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(edit)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(expose)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__global__help__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-global-help-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade-all)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(auth)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__auth_commands" \
"*::: :->auth" \
&& ret=0

    case $state in
    (auth)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-auth-command-$line[1]:"
        case $line[1] in
            (login)
_arguments "${_arguments_options[@]}" : \
'--token=[The token to use (for authentication with prefix.dev)]:TOKEN: ' \
'--username=[The username to use (for basic HTTP authentication)]:USERNAME: ' \
'--password=[The password to use (for basic HTTP authentication)]:PASSWORD: ' \
'--conda-token=[The token to use on anaconda.org / quetz authentication]:CONDA_TOKEN: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':host -- The host to authenticate with (e.g. repo.prefix.dev):' \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
':host -- The host to remove authentication for:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__auth__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-auth-help-command-$line[1]:"
        case $line[1] in
            (login)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(config)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__config_commands" \
"*::: :->config" \
&& ret=0

    case $state in
    (config)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-config-command-$line[1]:"
        case $line[1] in
            (edit)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
'::editor -- The editor to use, defaults to `EDITOR` environment variable or `nano` on Unix and `notepad` on Windows:' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--json[Output in JSON format]' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::key -- Configuration key to show (all if not provided):' \
&& ret=0
;;
(ls)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--json[Output in JSON format]' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::key -- Configuration key to show (all if not provided):' \
&& ret=0
;;
(prepend)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':key -- Configuration key to set:' \
':value -- Configuration value to (pre|ap)pend:' \
&& ret=0
;;
(append)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':key -- Configuration key to set:' \
':value -- Configuration value to (pre|ap)pend:' \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':key -- Configuration key to set:' \
'::value -- Configuration value to set (key will be unset if value not provided):' \
&& ret=0
;;
(unset)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'(-g --global -s --system)-l[Operation on project-local configuration]' \
'(-g --global -s --system)--local[Operation on project-local configuration]' \
'(-l --local -s --system)-g[Operation on global configuration]' \
'(-l --local -s --system)--global[Operation on global configuration]' \
'(-l --local -g --global)-s[Operation on system configuration]' \
'(-l --local -g --global)--system[Operation on system configuration]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':key -- Configuration key to unset:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__config__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-config-help-command-$line[1]:"
        case $line[1] in
            (edit)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(prepend)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(append)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(unset)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(info)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--extended[Show cache and environment size]' \
'--json[Whether to show the output as JSON or not]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(upload)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':host -- The host + channel to upload to:' \
':package_file -- The file to upload:_files' \
&& ret=0
;;
(search)
_arguments "${_arguments_options[@]}" : \
'*-c+[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'*--channel=[The channels to consider as a name or a url. Multiple channels can be specified by using this field multiple times]:CHANNEL: ' \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-p+[The platform to search for, defaults to current platform]:PLATFORM: ' \
'--platform=[The platform to search for, defaults to current platform]:PLATFORM: ' \
'-l+[Limit the number of search results]:LIMIT: ' \
'--limit=[Limit the number of search results]:LIMIT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':package -- Name of package to search:' \
&& ret=0
;;
(self-update)
_arguments "${_arguments_options[@]}" : \
'--version=[The desired version (to downgrade or upgrade to). Update to the latest version if not specified]:VERSION: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(clean)
_arguments "${_arguments_options[@]}" : \
'--manifest-path=[The path to \`pixi.toml\` or \`pyproject.toml\`]:MANIFEST_PATH:_files' \
'-e+[The environment directory to remove]:ENVIRONMENT: ' \
'--environment=[The environment directory to remove]:ENVIRONMENT: ' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_pixi__clean_commands" \
"*::: :->clean" \
&& ret=0

    case $state in
    (clean)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-clean-command-$line[1]:"
        case $line[1] in
            (cache)
_arguments "${_arguments_options[@]}" : \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'--pypi[Clean only the pypi related cache]' \
'--conda[Clean only the conda related cache]' \
'--mapping[Clean only the mapping cache]' \
'--exec[Clean only \`exec\` cache]' \
'--repodata[Clean only the repodata cache]' \
'-y[Answer yes to all questions]' \
'--yes[Answer yes to all questions]' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__clean__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-clean-help-command-$line[1]:"
        case $line[1] in
            (cache)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'-s+[The shell to generate a completion script for]:SHELL:((bash\:"Bourne Again SHell (bash)"
elvish\:"Elvish shell"
fish\:"Friendly Interactive SHell (fish)"
nushell\:"Nushell"
powershell\:"PowerShell"
zsh\:"Z SHell (zsh)"))' \
'--shell=[The shell to generate a completion script for]:SHELL:((bash\:"Bourne Again SHell (bash)"
elvish\:"Elvish shell"
fish\:"Friendly Interactive SHell (fish)"
nushell\:"Nushell"
powershell\:"PowerShell"
zsh\:"Z SHell (zsh)"))' \
'--color=[Whether the log needs to be colored]:COLOR:(always never auto)' \
'*-v[Increase logging verbosity]' \
'*--verbose[Increase logging verbosity]' \
'(-v --verbose)*-q[Decrease logging verbosity]' \
'(-v --verbose)*--quiet[Decrease logging verbosity]' \
'--no-progress[Hide all progress bars]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(exec)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(shell)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(shell-hook)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(project)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project_commands" \
"*::: :->project" \
&& ret=0

    case $state in
    (project)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-command-$line[1]:"
        case $line[1] in
            (channel)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__channel_commands" \
"*::: :->channel" \
&& ret=0

    case $state in
    (channel)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-channel-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(description)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__description_commands" \
"*::: :->description" \
&& ret=0

    case $state in
    (description)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-description-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(platform)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__platform_commands" \
"*::: :->platform" \
&& ret=0

    case $state in
    (platform)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-platform-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(version)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__version_commands" \
"*::: :->version" \
&& ret=0

    case $state in
    (version)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-version-command-$line[1]:"
        case $line[1] in
            (get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(major)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(minor)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(environment)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__environment_commands" \
"*::: :->environment" \
&& ret=0

    case $state in
    (environment)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-environment-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(export)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__project__export_commands" \
"*::: :->export" \
&& ret=0

    case $state in
    (export)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-project-export-command-$line[1]:"
        case $line[1] in
            (conda-explicit-spec)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(conda-environment)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(task)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__task_commands" \
"*::: :->task" \
&& ret=0

    case $state in
    (task)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-task-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(alias)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(tree)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(global)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__global_commands" \
"*::: :->global" \
&& ret=0

    case $state in
    (global)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-global-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(edit)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(sync)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(expose)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__global__expose_commands" \
"*::: :->expose" \
&& ret=0

    case $state in
    (expose)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-global-expose-command-$line[1]:"
        case $line[1] in
            (add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upgrade-all)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(auth)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__auth_commands" \
"*::: :->auth" \
&& ret=0

    case $state in
    (auth)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-auth-command-$line[1]:"
        case $line[1] in
            (login)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(config)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__config_commands" \
"*::: :->config" \
&& ret=0

    case $state in
    (config)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-config-command-$line[1]:"
        case $line[1] in
            (edit)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(prepend)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(append)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(unset)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(info)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(upload)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(search)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(self-update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(clean)
_arguments "${_arguments_options[@]}" : \
":: :_pixi__help__clean_commands" \
"*::: :->clean" \
&& ret=0

    case $state in
    (clean)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:pixi-help-clean-command-$line[1]:"
        case $line[1] in
            (cache)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_pixi_commands] )) ||
_pixi_commands() {
    local commands; commands=(
'init:Creates a new project' \
'add:Adds dependencies to the project' \
'a:Adds dependencies to the project' \
'remove:Removes dependencies from the project' \
'rm:Removes dependencies from the project' \
'install:Install all dependencies' \
'i:Install all dependencies' \
'update:Update dependencies as recorded in the local lock file' \
'run:Runs task in project' \
'r:Runs task in project' \
'exec:Run a command in a temporary environment' \
'x:Run a command in a temporary environment' \
'shell:Start a shell in the pixi environment of the project' \
's:Start a shell in the pixi environment of the project' \
'shell-hook:Print the pixi environment activation script' \
'project:Modify the project configuration file through the command line' \
'task:Interact with tasks in the project' \
'list:List project'\''s packages' \
'ls:List project'\''s packages' \
'tree:Show a tree of project dependencies' \
't:Show a tree of project dependencies' \
'global:Subcommand for global package management actions' \
'g:Subcommand for global package management actions' \
'auth:Login to prefix.dev or anaconda.org servers to access private channels' \
'config:Configuration management' \
'info:Information about the system, project and environments for the current machine' \
'upload:Upload a conda package' \
'search:Search a conda package' \
'self-update:Update pixi to the latest version or a specific version' \
'clean:Clean the parts of your system which are touched by pixi. Defaults to cleaning the environments and task cache. Use the \`cache\` subcommand to clean the cache' \
'completion:Generates a completion script for a shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi commands' commands "$@"
}
(( $+functions[_pixi__add_commands] )) ||
_pixi__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi add commands' commands "$@"
}
(( $+functions[_pixi__auth_commands] )) ||
_pixi__auth_commands() {
    local commands; commands=(
'login:Store authentication information for a given host' \
'logout:Remove authentication information for a given host' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi auth commands' commands "$@"
}
(( $+functions[_pixi__auth__help_commands] )) ||
_pixi__auth__help_commands() {
    local commands; commands=(
'login:Store authentication information for a given host' \
'logout:Remove authentication information for a given host' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi auth help commands' commands "$@"
}
(( $+functions[_pixi__auth__help__help_commands] )) ||
_pixi__auth__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi auth help help commands' commands "$@"
}
(( $+functions[_pixi__auth__help__login_commands] )) ||
_pixi__auth__help__login_commands() {
    local commands; commands=()
    _describe -t commands 'pixi auth help login commands' commands "$@"
}
(( $+functions[_pixi__auth__help__logout_commands] )) ||
_pixi__auth__help__logout_commands() {
    local commands; commands=()
    _describe -t commands 'pixi auth help logout commands' commands "$@"
}
(( $+functions[_pixi__auth__login_commands] )) ||
_pixi__auth__login_commands() {
    local commands; commands=()
    _describe -t commands 'pixi auth login commands' commands "$@"
}
(( $+functions[_pixi__auth__logout_commands] )) ||
_pixi__auth__logout_commands() {
    local commands; commands=()
    _describe -t commands 'pixi auth logout commands' commands "$@"
}
(( $+functions[_pixi__clean_commands] )) ||
_pixi__clean_commands() {
    local commands; commands=(
'cache:Clean the cache of your system which are touched by pixi' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi clean commands' commands "$@"
}
(( $+functions[_pixi__clean__cache_commands] )) ||
_pixi__clean__cache_commands() {
    local commands; commands=()
    _describe -t commands 'pixi clean cache commands' commands "$@"
}
(( $+functions[_pixi__clean__help_commands] )) ||
_pixi__clean__help_commands() {
    local commands; commands=(
'cache:Clean the cache of your system which are touched by pixi' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi clean help commands' commands "$@"
}
(( $+functions[_pixi__clean__help__cache_commands] )) ||
_pixi__clean__help__cache_commands() {
    local commands; commands=()
    _describe -t commands 'pixi clean help cache commands' commands "$@"
}
(( $+functions[_pixi__clean__help__help_commands] )) ||
_pixi__clean__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi clean help help commands' commands "$@"
}
(( $+functions[_pixi__completion_commands] )) ||
_pixi__completion_commands() {
    local commands; commands=()
    _describe -t commands 'pixi completion commands' commands "$@"
}
(( $+functions[_pixi__config_commands] )) ||
_pixi__config_commands() {
    local commands; commands=(
'edit:Edit the configuration file' \
'list:List configuration values' \
'ls:List configuration values' \
'prepend:Prepend a value to a list configuration key' \
'append:Append a value to a list configuration key' \
'set:Set a configuration value' \
'unset:Unset a configuration value' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi config commands' commands "$@"
}
(( $+functions[_pixi__config__append_commands] )) ||
_pixi__config__append_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config append commands' commands "$@"
}
(( $+functions[_pixi__config__edit_commands] )) ||
_pixi__config__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config edit commands' commands "$@"
}
(( $+functions[_pixi__config__help_commands] )) ||
_pixi__config__help_commands() {
    local commands; commands=(
'edit:Edit the configuration file' \
'list:List configuration values' \
'prepend:Prepend a value to a list configuration key' \
'append:Append a value to a list configuration key' \
'set:Set a configuration value' \
'unset:Unset a configuration value' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi config help commands' commands "$@"
}
(( $+functions[_pixi__config__help__append_commands] )) ||
_pixi__config__help__append_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help append commands' commands "$@"
}
(( $+functions[_pixi__config__help__edit_commands] )) ||
_pixi__config__help__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help edit commands' commands "$@"
}
(( $+functions[_pixi__config__help__help_commands] )) ||
_pixi__config__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help help commands' commands "$@"
}
(( $+functions[_pixi__config__help__list_commands] )) ||
_pixi__config__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help list commands' commands "$@"
}
(( $+functions[_pixi__config__help__prepend_commands] )) ||
_pixi__config__help__prepend_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help prepend commands' commands "$@"
}
(( $+functions[_pixi__config__help__set_commands] )) ||
_pixi__config__help__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help set commands' commands "$@"
}
(( $+functions[_pixi__config__help__unset_commands] )) ||
_pixi__config__help__unset_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config help unset commands' commands "$@"
}
(( $+functions[_pixi__config__list_commands] )) ||
_pixi__config__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config list commands' commands "$@"
}
(( $+functions[_pixi__config__prepend_commands] )) ||
_pixi__config__prepend_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config prepend commands' commands "$@"
}
(( $+functions[_pixi__config__set_commands] )) ||
_pixi__config__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config set commands' commands "$@"
}
(( $+functions[_pixi__config__unset_commands] )) ||
_pixi__config__unset_commands() {
    local commands; commands=()
    _describe -t commands 'pixi config unset commands' commands "$@"
}
(( $+functions[_pixi__exec_commands] )) ||
_pixi__exec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi exec commands' commands "$@"
}
(( $+functions[_pixi__global_commands] )) ||
_pixi__global_commands() {
    local commands; commands=(
'add:Adds dependencies to an environment' \
'a:Adds dependencies to an environment' \
'edit:Edit the global manifest file' \
'install:Installs the defined packages in a globally accessible location and exposes their command line applications.' \
'i:Installs the defined packages in a globally accessible location and exposes their command line applications.' \
'uninstall:Uninstalls environments from the global environment.' \
'remove:Removes dependencies from an environment' \
'rm:Removes dependencies from an environment' \
'list:Lists all packages previously installed into a globally accessible location via \`pixi global install\`.' \
'ls:Lists all packages previously installed into a globally accessible location via \`pixi global install\`.' \
'sync:Sync global manifest with installed environments' \
's:Sync global manifest with installed environments' \
'expose:Interact with the exposure of binaries in the global environment' \
'e:Interact with the exposure of binaries in the global environment' \
'update:Updates environments in the global environment' \
'upgrade:Upgrade specific package which is installed globally. This command has been removed, please use \`pixi global update\` instead' \
'upgrade-all:Upgrade all globally installed packages This command has been removed, please use \`pixi global update\` instead' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi global commands' commands "$@"
}
(( $+functions[_pixi__global__add_commands] )) ||
_pixi__global__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global add commands' commands "$@"
}
(( $+functions[_pixi__global__edit_commands] )) ||
_pixi__global__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global edit commands' commands "$@"
}
(( $+functions[_pixi__global__expose_commands] )) ||
_pixi__global__expose_commands() {
    local commands; commands=(
'add:Add exposed binaries from an environment to your global environment' \
'remove:Remove exposed binaries from the global environment' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi global expose commands' commands "$@"
}
(( $+functions[_pixi__global__expose__add_commands] )) ||
_pixi__global__expose__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global expose add commands' commands "$@"
}
(( $+functions[_pixi__global__expose__help_commands] )) ||
_pixi__global__expose__help_commands() {
    local commands; commands=(
'add:Add exposed binaries from an environment to your global environment' \
'remove:Remove exposed binaries from the global environment' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi global expose help commands' commands "$@"
}
(( $+functions[_pixi__global__expose__help__add_commands] )) ||
_pixi__global__expose__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global expose help add commands' commands "$@"
}
(( $+functions[_pixi__global__expose__help__help_commands] )) ||
_pixi__global__expose__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global expose help help commands' commands "$@"
}
(( $+functions[_pixi__global__expose__help__remove_commands] )) ||
_pixi__global__expose__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global expose help remove commands' commands "$@"
}
(( $+functions[_pixi__global__expose__remove_commands] )) ||
_pixi__global__expose__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global expose remove commands' commands "$@"
}
(( $+functions[_pixi__global__help_commands] )) ||
_pixi__global__help_commands() {
    local commands; commands=(
'add:Adds dependencies to an environment' \
'edit:Edit the global manifest file' \
'install:Installs the defined packages in a globally accessible location and exposes their command line applications.' \
'uninstall:Uninstalls environments from the global environment.' \
'remove:Removes dependencies from an environment' \
'list:Lists all packages previously installed into a globally accessible location via \`pixi global install\`.' \
'sync:Sync global manifest with installed environments' \
'expose:Interact with the exposure of binaries in the global environment' \
'update:Updates environments in the global environment' \
'upgrade:Upgrade specific package which is installed globally. This command has been removed, please use \`pixi global update\` instead' \
'upgrade-all:Upgrade all globally installed packages This command has been removed, please use \`pixi global update\` instead' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi global help commands' commands "$@"
}
(( $+functions[_pixi__global__help__add_commands] )) ||
_pixi__global__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help add commands' commands "$@"
}
(( $+functions[_pixi__global__help__edit_commands] )) ||
_pixi__global__help__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help edit commands' commands "$@"
}
(( $+functions[_pixi__global__help__expose_commands] )) ||
_pixi__global__help__expose_commands() {
    local commands; commands=(
'add:Add exposed binaries from an environment to your global environment' \
'remove:Remove exposed binaries from the global environment' \
    )
    _describe -t commands 'pixi global help expose commands' commands "$@"
}
(( $+functions[_pixi__global__help__expose__add_commands] )) ||
_pixi__global__help__expose__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help expose add commands' commands "$@"
}
(( $+functions[_pixi__global__help__expose__remove_commands] )) ||
_pixi__global__help__expose__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help expose remove commands' commands "$@"
}
(( $+functions[_pixi__global__help__help_commands] )) ||
_pixi__global__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help help commands' commands "$@"
}
(( $+functions[_pixi__global__help__install_commands] )) ||
_pixi__global__help__install_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help install commands' commands "$@"
}
(( $+functions[_pixi__global__help__list_commands] )) ||
_pixi__global__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help list commands' commands "$@"
}
(( $+functions[_pixi__global__help__remove_commands] )) ||
_pixi__global__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help remove commands' commands "$@"
}
(( $+functions[_pixi__global__help__sync_commands] )) ||
_pixi__global__help__sync_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help sync commands' commands "$@"
}
(( $+functions[_pixi__global__help__uninstall_commands] )) ||
_pixi__global__help__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help uninstall commands' commands "$@"
}
(( $+functions[_pixi__global__help__update_commands] )) ||
_pixi__global__help__update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help update commands' commands "$@"
}
(( $+functions[_pixi__global__help__upgrade_commands] )) ||
_pixi__global__help__upgrade_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help upgrade commands' commands "$@"
}
(( $+functions[_pixi__global__help__upgrade-all_commands] )) ||
_pixi__global__help__upgrade-all_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global help upgrade-all commands' commands "$@"
}
(( $+functions[_pixi__global__install_commands] )) ||
_pixi__global__install_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global install commands' commands "$@"
}
(( $+functions[_pixi__global__list_commands] )) ||
_pixi__global__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global list commands' commands "$@"
}
(( $+functions[_pixi__global__remove_commands] )) ||
_pixi__global__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global remove commands' commands "$@"
}
(( $+functions[_pixi__global__sync_commands] )) ||
_pixi__global__sync_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global sync commands' commands "$@"
}
(( $+functions[_pixi__global__uninstall_commands] )) ||
_pixi__global__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global uninstall commands' commands "$@"
}
(( $+functions[_pixi__global__update_commands] )) ||
_pixi__global__update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global update commands' commands "$@"
}
(( $+functions[_pixi__global__upgrade_commands] )) ||
_pixi__global__upgrade_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global upgrade commands' commands "$@"
}
(( $+functions[_pixi__global__upgrade-all_commands] )) ||
_pixi__global__upgrade-all_commands() {
    local commands; commands=()
    _describe -t commands 'pixi global upgrade-all commands' commands "$@"
}
(( $+functions[_pixi__help_commands] )) ||
_pixi__help_commands() {
    local commands; commands=(
'init:Creates a new project' \
'add:Adds dependencies to the project' \
'remove:Removes dependencies from the project' \
'install:Install all dependencies' \
'update:Update dependencies as recorded in the local lock file' \
'run:Runs task in project' \
'exec:Run a command in a temporary environment' \
'shell:Start a shell in the pixi environment of the project' \
'shell-hook:Print the pixi environment activation script' \
'project:Modify the project configuration file through the command line' \
'task:Interact with tasks in the project' \
'list:List project'\''s packages' \
'tree:Show a tree of project dependencies' \
'global:Subcommand for global package management actions' \
'auth:Login to prefix.dev or anaconda.org servers to access private channels' \
'config:Configuration management' \
'info:Information about the system, project and environments for the current machine' \
'upload:Upload a conda package' \
'search:Search a conda package' \
'self-update:Update pixi to the latest version or a specific version' \
'clean:Clean the parts of your system which are touched by pixi. Defaults to cleaning the environments and task cache. Use the \`cache\` subcommand to clean the cache' \
'completion:Generates a completion script for a shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi help commands' commands "$@"
}
(( $+functions[_pixi__help__add_commands] )) ||
_pixi__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help add commands' commands "$@"
}
(( $+functions[_pixi__help__auth_commands] )) ||
_pixi__help__auth_commands() {
    local commands; commands=(
'login:Store authentication information for a given host' \
'logout:Remove authentication information for a given host' \
    )
    _describe -t commands 'pixi help auth commands' commands "$@"
}
(( $+functions[_pixi__help__auth__login_commands] )) ||
_pixi__help__auth__login_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help auth login commands' commands "$@"
}
(( $+functions[_pixi__help__auth__logout_commands] )) ||
_pixi__help__auth__logout_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help auth logout commands' commands "$@"
}
(( $+functions[_pixi__help__clean_commands] )) ||
_pixi__help__clean_commands() {
    local commands; commands=(
'cache:Clean the cache of your system which are touched by pixi' \
    )
    _describe -t commands 'pixi help clean commands' commands "$@"
}
(( $+functions[_pixi__help__clean__cache_commands] )) ||
_pixi__help__clean__cache_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help clean cache commands' commands "$@"
}
(( $+functions[_pixi__help__completion_commands] )) ||
_pixi__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help completion commands' commands "$@"
}
(( $+functions[_pixi__help__config_commands] )) ||
_pixi__help__config_commands() {
    local commands; commands=(
'edit:Edit the configuration file' \
'list:List configuration values' \
'prepend:Prepend a value to a list configuration key' \
'append:Append a value to a list configuration key' \
'set:Set a configuration value' \
'unset:Unset a configuration value' \
    )
    _describe -t commands 'pixi help config commands' commands "$@"
}
(( $+functions[_pixi__help__config__append_commands] )) ||
_pixi__help__config__append_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config append commands' commands "$@"
}
(( $+functions[_pixi__help__config__edit_commands] )) ||
_pixi__help__config__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config edit commands' commands "$@"
}
(( $+functions[_pixi__help__config__list_commands] )) ||
_pixi__help__config__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config list commands' commands "$@"
}
(( $+functions[_pixi__help__config__prepend_commands] )) ||
_pixi__help__config__prepend_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config prepend commands' commands "$@"
}
(( $+functions[_pixi__help__config__set_commands] )) ||
_pixi__help__config__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config set commands' commands "$@"
}
(( $+functions[_pixi__help__config__unset_commands] )) ||
_pixi__help__config__unset_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help config unset commands' commands "$@"
}
(( $+functions[_pixi__help__exec_commands] )) ||
_pixi__help__exec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help exec commands' commands "$@"
}
(( $+functions[_pixi__help__global_commands] )) ||
_pixi__help__global_commands() {
    local commands; commands=(
'add:Adds dependencies to an environment' \
'edit:Edit the global manifest file' \
'install:Installs the defined packages in a globally accessible location and exposes their command line applications.' \
'uninstall:Uninstalls environments from the global environment.' \
'remove:Removes dependencies from an environment' \
'list:Lists all packages previously installed into a globally accessible location via \`pixi global install\`.' \
'sync:Sync global manifest with installed environments' \
'expose:Interact with the exposure of binaries in the global environment' \
'update:Updates environments in the global environment' \
'upgrade:Upgrade specific package which is installed globally. This command has been removed, please use \`pixi global update\` instead' \
'upgrade-all:Upgrade all globally installed packages This command has been removed, please use \`pixi global update\` instead' \
    )
    _describe -t commands 'pixi help global commands' commands "$@"
}
(( $+functions[_pixi__help__global__add_commands] )) ||
_pixi__help__global__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global add commands' commands "$@"
}
(( $+functions[_pixi__help__global__edit_commands] )) ||
_pixi__help__global__edit_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global edit commands' commands "$@"
}
(( $+functions[_pixi__help__global__expose_commands] )) ||
_pixi__help__global__expose_commands() {
    local commands; commands=(
'add:Add exposed binaries from an environment to your global environment' \
'remove:Remove exposed binaries from the global environment' \
    )
    _describe -t commands 'pixi help global expose commands' commands "$@"
}
(( $+functions[_pixi__help__global__expose__add_commands] )) ||
_pixi__help__global__expose__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global expose add commands' commands "$@"
}
(( $+functions[_pixi__help__global__expose__remove_commands] )) ||
_pixi__help__global__expose__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global expose remove commands' commands "$@"
}
(( $+functions[_pixi__help__global__install_commands] )) ||
_pixi__help__global__install_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global install commands' commands "$@"
}
(( $+functions[_pixi__help__global__list_commands] )) ||
_pixi__help__global__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global list commands' commands "$@"
}
(( $+functions[_pixi__help__global__remove_commands] )) ||
_pixi__help__global__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global remove commands' commands "$@"
}
(( $+functions[_pixi__help__global__sync_commands] )) ||
_pixi__help__global__sync_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global sync commands' commands "$@"
}
(( $+functions[_pixi__help__global__uninstall_commands] )) ||
_pixi__help__global__uninstall_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global uninstall commands' commands "$@"
}
(( $+functions[_pixi__help__global__update_commands] )) ||
_pixi__help__global__update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global update commands' commands "$@"
}
(( $+functions[_pixi__help__global__upgrade_commands] )) ||
_pixi__help__global__upgrade_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global upgrade commands' commands "$@"
}
(( $+functions[_pixi__help__global__upgrade-all_commands] )) ||
_pixi__help__global__upgrade-all_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help global upgrade-all commands' commands "$@"
}
(( $+functions[_pixi__help__help_commands] )) ||
_pixi__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help help commands' commands "$@"
}
(( $+functions[_pixi__help__info_commands] )) ||
_pixi__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help info commands' commands "$@"
}
(( $+functions[_pixi__help__init_commands] )) ||
_pixi__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help init commands' commands "$@"
}
(( $+functions[_pixi__help__install_commands] )) ||
_pixi__help__install_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help install commands' commands "$@"
}
(( $+functions[_pixi__help__list_commands] )) ||
_pixi__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help list commands' commands "$@"
}
(( $+functions[_pixi__help__project_commands] )) ||
_pixi__help__project_commands() {
    local commands; commands=(
'channel:Commands to manage project channels' \
'description:Commands to manage project description' \
'platform:Commands to manage project platforms' \
'version:Commands to manage project version' \
'environment:Commands to manage project environments' \
'export:Commands to export projects to other formats' \
    )
    _describe -t commands 'pixi help project commands' commands "$@"
}
(( $+functions[_pixi__help__project__channel_commands] )) ||
_pixi__help__project__channel_commands() {
    local commands; commands=(
'add:Adds a channel to the project file and updates the lockfile' \
'list:List the channels in the project file' \
'remove:Remove channel(s) from the project file and updates the lockfile' \
    )
    _describe -t commands 'pixi help project channel commands' commands "$@"
}
(( $+functions[_pixi__help__project__channel__add_commands] )) ||
_pixi__help__project__channel__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project channel add commands' commands "$@"
}
(( $+functions[_pixi__help__project__channel__list_commands] )) ||
_pixi__help__project__channel__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project channel list commands' commands "$@"
}
(( $+functions[_pixi__help__project__channel__remove_commands] )) ||
_pixi__help__project__channel__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project channel remove commands' commands "$@"
}
(( $+functions[_pixi__help__project__description_commands] )) ||
_pixi__help__project__description_commands() {
    local commands; commands=(
'get:Get the project description' \
'set:Set the project description' \
    )
    _describe -t commands 'pixi help project description commands' commands "$@"
}
(( $+functions[_pixi__help__project__description__get_commands] )) ||
_pixi__help__project__description__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project description get commands' commands "$@"
}
(( $+functions[_pixi__help__project__description__set_commands] )) ||
_pixi__help__project__description__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project description set commands' commands "$@"
}
(( $+functions[_pixi__help__project__environment_commands] )) ||
_pixi__help__project__environment_commands() {
    local commands; commands=(
'add:Adds an environment to the manifest file' \
'list:List the environments in the manifest file' \
'remove:Remove an environment from the manifest file' \
    )
    _describe -t commands 'pixi help project environment commands' commands "$@"
}
(( $+functions[_pixi__help__project__environment__add_commands] )) ||
_pixi__help__project__environment__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project environment add commands' commands "$@"
}
(( $+functions[_pixi__help__project__environment__list_commands] )) ||
_pixi__help__project__environment__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project environment list commands' commands "$@"
}
(( $+functions[_pixi__help__project__environment__remove_commands] )) ||
_pixi__help__project__environment__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project environment remove commands' commands "$@"
}
(( $+functions[_pixi__help__project__export_commands] )) ||
_pixi__help__project__export_commands() {
    local commands; commands=(
'conda-explicit-spec:Export project environment to a conda explicit specification file' \
'conda-environment:Export project environment to a conda environment.yaml file' \
    )
    _describe -t commands 'pixi help project export commands' commands "$@"
}
(( $+functions[_pixi__help__project__export__conda-environment_commands] )) ||
_pixi__help__project__export__conda-environment_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project export conda-environment commands' commands "$@"
}
(( $+functions[_pixi__help__project__export__conda-explicit-spec_commands] )) ||
_pixi__help__project__export__conda-explicit-spec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project export conda-explicit-spec commands' commands "$@"
}
(( $+functions[_pixi__help__project__platform_commands] )) ||
_pixi__help__project__platform_commands() {
    local commands; commands=(
'add:Adds a platform(s) to the project file and updates the lockfile' \
'list:List the platforms in the project file' \
'remove:Remove platform(s) from the project file and updates the lockfile' \
    )
    _describe -t commands 'pixi help project platform commands' commands "$@"
}
(( $+functions[_pixi__help__project__platform__add_commands] )) ||
_pixi__help__project__platform__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project platform add commands' commands "$@"
}
(( $+functions[_pixi__help__project__platform__list_commands] )) ||
_pixi__help__project__platform__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project platform list commands' commands "$@"
}
(( $+functions[_pixi__help__project__platform__remove_commands] )) ||
_pixi__help__project__platform__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project platform remove commands' commands "$@"
}
(( $+functions[_pixi__help__project__version_commands] )) ||
_pixi__help__project__version_commands() {
    local commands; commands=(
'get:Get the project version' \
'set:Set the project version' \
'major:Bump the project version to MAJOR' \
'minor:Bump the project version to MINOR' \
'patch:Bump the project version to PATCH' \
    )
    _describe -t commands 'pixi help project version commands' commands "$@"
}
(( $+functions[_pixi__help__project__version__get_commands] )) ||
_pixi__help__project__version__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project version get commands' commands "$@"
}
(( $+functions[_pixi__help__project__version__major_commands] )) ||
_pixi__help__project__version__major_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project version major commands' commands "$@"
}
(( $+functions[_pixi__help__project__version__minor_commands] )) ||
_pixi__help__project__version__minor_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project version minor commands' commands "$@"
}
(( $+functions[_pixi__help__project__version__patch_commands] )) ||
_pixi__help__project__version__patch_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project version patch commands' commands "$@"
}
(( $+functions[_pixi__help__project__version__set_commands] )) ||
_pixi__help__project__version__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help project version set commands' commands "$@"
}
(( $+functions[_pixi__help__remove_commands] )) ||
_pixi__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help remove commands' commands "$@"
}
(( $+functions[_pixi__help__run_commands] )) ||
_pixi__help__run_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help run commands' commands "$@"
}
(( $+functions[_pixi__help__search_commands] )) ||
_pixi__help__search_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help search commands' commands "$@"
}
(( $+functions[_pixi__help__self-update_commands] )) ||
_pixi__help__self-update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help self-update commands' commands "$@"
}
(( $+functions[_pixi__help__shell_commands] )) ||
_pixi__help__shell_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help shell commands' commands "$@"
}
(( $+functions[_pixi__help__shell-hook_commands] )) ||
_pixi__help__shell-hook_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help shell-hook commands' commands "$@"
}
(( $+functions[_pixi__help__task_commands] )) ||
_pixi__help__task_commands() {
    local commands; commands=(
'add:Add a command to the project' \
'remove:Remove a command from the project' \
'alias:Alias another specific command' \
'list:List all tasks in the project' \
    )
    _describe -t commands 'pixi help task commands' commands "$@"
}
(( $+functions[_pixi__help__task__add_commands] )) ||
_pixi__help__task__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help task add commands' commands "$@"
}
(( $+functions[_pixi__help__task__alias_commands] )) ||
_pixi__help__task__alias_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help task alias commands' commands "$@"
}
(( $+functions[_pixi__help__task__list_commands] )) ||
_pixi__help__task__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help task list commands' commands "$@"
}
(( $+functions[_pixi__help__task__remove_commands] )) ||
_pixi__help__task__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help task remove commands' commands "$@"
}
(( $+functions[_pixi__help__tree_commands] )) ||
_pixi__help__tree_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help tree commands' commands "$@"
}
(( $+functions[_pixi__help__update_commands] )) ||
_pixi__help__update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help update commands' commands "$@"
}
(( $+functions[_pixi__help__upload_commands] )) ||
_pixi__help__upload_commands() {
    local commands; commands=()
    _describe -t commands 'pixi help upload commands' commands "$@"
}
(( $+functions[_pixi__info_commands] )) ||
_pixi__info_commands() {
    local commands; commands=()
    _describe -t commands 'pixi info commands' commands "$@"
}
(( $+functions[_pixi__init_commands] )) ||
_pixi__init_commands() {
    local commands; commands=()
    _describe -t commands 'pixi init commands' commands "$@"
}
(( $+functions[_pixi__install_commands] )) ||
_pixi__install_commands() {
    local commands; commands=()
    _describe -t commands 'pixi install commands' commands "$@"
}
(( $+functions[_pixi__list_commands] )) ||
_pixi__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi list commands' commands "$@"
}
(( $+functions[_pixi__project_commands] )) ||
_pixi__project_commands() {
    local commands; commands=(
'channel:Commands to manage project channels' \
'description:Commands to manage project description' \
'platform:Commands to manage project platforms' \
'version:Commands to manage project version' \
'environment:Commands to manage project environments' \
'export:Commands to export projects to other formats' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project commands' commands "$@"
}
(( $+functions[_pixi__project__channel_commands] )) ||
_pixi__project__channel_commands() {
    local commands; commands=(
'add:Adds a channel to the project file and updates the lockfile' \
'a:Adds a channel to the project file and updates the lockfile' \
'list:List the channels in the project file' \
'ls:List the channels in the project file' \
'remove:Remove channel(s) from the project file and updates the lockfile' \
'rm:Remove channel(s) from the project file and updates the lockfile' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project channel commands' commands "$@"
}
(( $+functions[_pixi__project__channel__add_commands] )) ||
_pixi__project__channel__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel add commands' commands "$@"
}
(( $+functions[_pixi__project__channel__help_commands] )) ||
_pixi__project__channel__help_commands() {
    local commands; commands=(
'add:Adds a channel to the project file and updates the lockfile' \
'list:List the channels in the project file' \
'remove:Remove channel(s) from the project file and updates the lockfile' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project channel help commands' commands "$@"
}
(( $+functions[_pixi__project__channel__help__add_commands] )) ||
_pixi__project__channel__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel help add commands' commands "$@"
}
(( $+functions[_pixi__project__channel__help__help_commands] )) ||
_pixi__project__channel__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel help help commands' commands "$@"
}
(( $+functions[_pixi__project__channel__help__list_commands] )) ||
_pixi__project__channel__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel help list commands' commands "$@"
}
(( $+functions[_pixi__project__channel__help__remove_commands] )) ||
_pixi__project__channel__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel help remove commands' commands "$@"
}
(( $+functions[_pixi__project__channel__list_commands] )) ||
_pixi__project__channel__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel list commands' commands "$@"
}
(( $+functions[_pixi__project__channel__remove_commands] )) ||
_pixi__project__channel__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project channel remove commands' commands "$@"
}
(( $+functions[_pixi__project__description_commands] )) ||
_pixi__project__description_commands() {
    local commands; commands=(
'get:Get the project description' \
'set:Set the project description' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project description commands' commands "$@"
}
(( $+functions[_pixi__project__description__get_commands] )) ||
_pixi__project__description__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project description get commands' commands "$@"
}
(( $+functions[_pixi__project__description__help_commands] )) ||
_pixi__project__description__help_commands() {
    local commands; commands=(
'get:Get the project description' \
'set:Set the project description' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project description help commands' commands "$@"
}
(( $+functions[_pixi__project__description__help__get_commands] )) ||
_pixi__project__description__help__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project description help get commands' commands "$@"
}
(( $+functions[_pixi__project__description__help__help_commands] )) ||
_pixi__project__description__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project description help help commands' commands "$@"
}
(( $+functions[_pixi__project__description__help__set_commands] )) ||
_pixi__project__description__help__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project description help set commands' commands "$@"
}
(( $+functions[_pixi__project__description__set_commands] )) ||
_pixi__project__description__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project description set commands' commands "$@"
}
(( $+functions[_pixi__project__environment_commands] )) ||
_pixi__project__environment_commands() {
    local commands; commands=(
'add:Adds an environment to the manifest file' \
'a:Adds an environment to the manifest file' \
'list:List the environments in the manifest file' \
'ls:List the environments in the manifest file' \
'remove:Remove an environment from the manifest file' \
'rm:Remove an environment from the manifest file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project environment commands' commands "$@"
}
(( $+functions[_pixi__project__environment__add_commands] )) ||
_pixi__project__environment__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment add commands' commands "$@"
}
(( $+functions[_pixi__project__environment__help_commands] )) ||
_pixi__project__environment__help_commands() {
    local commands; commands=(
'add:Adds an environment to the manifest file' \
'list:List the environments in the manifest file' \
'remove:Remove an environment from the manifest file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project environment help commands' commands "$@"
}
(( $+functions[_pixi__project__environment__help__add_commands] )) ||
_pixi__project__environment__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment help add commands' commands "$@"
}
(( $+functions[_pixi__project__environment__help__help_commands] )) ||
_pixi__project__environment__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment help help commands' commands "$@"
}
(( $+functions[_pixi__project__environment__help__list_commands] )) ||
_pixi__project__environment__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment help list commands' commands "$@"
}
(( $+functions[_pixi__project__environment__help__remove_commands] )) ||
_pixi__project__environment__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment help remove commands' commands "$@"
}
(( $+functions[_pixi__project__environment__list_commands] )) ||
_pixi__project__environment__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment list commands' commands "$@"
}
(( $+functions[_pixi__project__environment__remove_commands] )) ||
_pixi__project__environment__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project environment remove commands' commands "$@"
}
(( $+functions[_pixi__project__export_commands] )) ||
_pixi__project__export_commands() {
    local commands; commands=(
'conda-explicit-spec:Export project environment to a conda explicit specification file' \
'ces:Export project environment to a conda explicit specification file' \
'conda-environment:Export project environment to a conda environment.yaml file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project export commands' commands "$@"
}
(( $+functions[_pixi__project__export__conda-environment_commands] )) ||
_pixi__project__export__conda-environment_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project export conda-environment commands' commands "$@"
}
(( $+functions[_pixi__project__export__conda-explicit-spec_commands] )) ||
_pixi__project__export__conda-explicit-spec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project export conda-explicit-spec commands' commands "$@"
}
(( $+functions[_pixi__project__export__help_commands] )) ||
_pixi__project__export__help_commands() {
    local commands; commands=(
'conda-explicit-spec:Export project environment to a conda explicit specification file' \
'conda-environment:Export project environment to a conda environment.yaml file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project export help commands' commands "$@"
}
(( $+functions[_pixi__project__export__help__conda-environment_commands] )) ||
_pixi__project__export__help__conda-environment_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project export help conda-environment commands' commands "$@"
}
(( $+functions[_pixi__project__export__help__conda-explicit-spec_commands] )) ||
_pixi__project__export__help__conda-explicit-spec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project export help conda-explicit-spec commands' commands "$@"
}
(( $+functions[_pixi__project__export__help__help_commands] )) ||
_pixi__project__export__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project export help help commands' commands "$@"
}
(( $+functions[_pixi__project__help_commands] )) ||
_pixi__project__help_commands() {
    local commands; commands=(
'channel:Commands to manage project channels' \
'description:Commands to manage project description' \
'platform:Commands to manage project platforms' \
'version:Commands to manage project version' \
'environment:Commands to manage project environments' \
'export:Commands to export projects to other formats' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project help commands' commands "$@"
}
(( $+functions[_pixi__project__help__channel_commands] )) ||
_pixi__project__help__channel_commands() {
    local commands; commands=(
'add:Adds a channel to the project file and updates the lockfile' \
'list:List the channels in the project file' \
'remove:Remove channel(s) from the project file and updates the lockfile' \
    )
    _describe -t commands 'pixi project help channel commands' commands "$@"
}
(( $+functions[_pixi__project__help__channel__add_commands] )) ||
_pixi__project__help__channel__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help channel add commands' commands "$@"
}
(( $+functions[_pixi__project__help__channel__list_commands] )) ||
_pixi__project__help__channel__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help channel list commands' commands "$@"
}
(( $+functions[_pixi__project__help__channel__remove_commands] )) ||
_pixi__project__help__channel__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help channel remove commands' commands "$@"
}
(( $+functions[_pixi__project__help__description_commands] )) ||
_pixi__project__help__description_commands() {
    local commands; commands=(
'get:Get the project description' \
'set:Set the project description' \
    )
    _describe -t commands 'pixi project help description commands' commands "$@"
}
(( $+functions[_pixi__project__help__description__get_commands] )) ||
_pixi__project__help__description__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help description get commands' commands "$@"
}
(( $+functions[_pixi__project__help__description__set_commands] )) ||
_pixi__project__help__description__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help description set commands' commands "$@"
}
(( $+functions[_pixi__project__help__environment_commands] )) ||
_pixi__project__help__environment_commands() {
    local commands; commands=(
'add:Adds an environment to the manifest file' \
'list:List the environments in the manifest file' \
'remove:Remove an environment from the manifest file' \
    )
    _describe -t commands 'pixi project help environment commands' commands "$@"
}
(( $+functions[_pixi__project__help__environment__add_commands] )) ||
_pixi__project__help__environment__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help environment add commands' commands "$@"
}
(( $+functions[_pixi__project__help__environment__list_commands] )) ||
_pixi__project__help__environment__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help environment list commands' commands "$@"
}
(( $+functions[_pixi__project__help__environment__remove_commands] )) ||
_pixi__project__help__environment__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help environment remove commands' commands "$@"
}
(( $+functions[_pixi__project__help__export_commands] )) ||
_pixi__project__help__export_commands() {
    local commands; commands=(
'conda-explicit-spec:Export project environment to a conda explicit specification file' \
'conda-environment:Export project environment to a conda environment.yaml file' \
    )
    _describe -t commands 'pixi project help export commands' commands "$@"
}
(( $+functions[_pixi__project__help__export__conda-environment_commands] )) ||
_pixi__project__help__export__conda-environment_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help export conda-environment commands' commands "$@"
}
(( $+functions[_pixi__project__help__export__conda-explicit-spec_commands] )) ||
_pixi__project__help__export__conda-explicit-spec_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help export conda-explicit-spec commands' commands "$@"
}
(( $+functions[_pixi__project__help__help_commands] )) ||
_pixi__project__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help help commands' commands "$@"
}
(( $+functions[_pixi__project__help__platform_commands] )) ||
_pixi__project__help__platform_commands() {
    local commands; commands=(
'add:Adds a platform(s) to the project file and updates the lockfile' \
'list:List the platforms in the project file' \
'remove:Remove platform(s) from the project file and updates the lockfile' \
    )
    _describe -t commands 'pixi project help platform commands' commands "$@"
}
(( $+functions[_pixi__project__help__platform__add_commands] )) ||
_pixi__project__help__platform__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help platform add commands' commands "$@"
}
(( $+functions[_pixi__project__help__platform__list_commands] )) ||
_pixi__project__help__platform__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help platform list commands' commands "$@"
}
(( $+functions[_pixi__project__help__platform__remove_commands] )) ||
_pixi__project__help__platform__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help platform remove commands' commands "$@"
}
(( $+functions[_pixi__project__help__version_commands] )) ||
_pixi__project__help__version_commands() {
    local commands; commands=(
'get:Get the project version' \
'set:Set the project version' \
'major:Bump the project version to MAJOR' \
'minor:Bump the project version to MINOR' \
'patch:Bump the project version to PATCH' \
    )
    _describe -t commands 'pixi project help version commands' commands "$@"
}
(( $+functions[_pixi__project__help__version__get_commands] )) ||
_pixi__project__help__version__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help version get commands' commands "$@"
}
(( $+functions[_pixi__project__help__version__major_commands] )) ||
_pixi__project__help__version__major_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help version major commands' commands "$@"
}
(( $+functions[_pixi__project__help__version__minor_commands] )) ||
_pixi__project__help__version__minor_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help version minor commands' commands "$@"
}
(( $+functions[_pixi__project__help__version__patch_commands] )) ||
_pixi__project__help__version__patch_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help version patch commands' commands "$@"
}
(( $+functions[_pixi__project__help__version__set_commands] )) ||
_pixi__project__help__version__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project help version set commands' commands "$@"
}
(( $+functions[_pixi__project__platform_commands] )) ||
_pixi__project__platform_commands() {
    local commands; commands=(
'add:Adds a platform(s) to the project file and updates the lockfile' \
'a:Adds a platform(s) to the project file and updates the lockfile' \
'list:List the platforms in the project file' \
'ls:List the platforms in the project file' \
'remove:Remove platform(s) from the project file and updates the lockfile' \
'rm:Remove platform(s) from the project file and updates the lockfile' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project platform commands' commands "$@"
}
(( $+functions[_pixi__project__platform__add_commands] )) ||
_pixi__project__platform__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform add commands' commands "$@"
}
(( $+functions[_pixi__project__platform__help_commands] )) ||
_pixi__project__platform__help_commands() {
    local commands; commands=(
'add:Adds a platform(s) to the project file and updates the lockfile' \
'list:List the platforms in the project file' \
'remove:Remove platform(s) from the project file and updates the lockfile' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project platform help commands' commands "$@"
}
(( $+functions[_pixi__project__platform__help__add_commands] )) ||
_pixi__project__platform__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform help add commands' commands "$@"
}
(( $+functions[_pixi__project__platform__help__help_commands] )) ||
_pixi__project__platform__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform help help commands' commands "$@"
}
(( $+functions[_pixi__project__platform__help__list_commands] )) ||
_pixi__project__platform__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform help list commands' commands "$@"
}
(( $+functions[_pixi__project__platform__help__remove_commands] )) ||
_pixi__project__platform__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform help remove commands' commands "$@"
}
(( $+functions[_pixi__project__platform__list_commands] )) ||
_pixi__project__platform__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform list commands' commands "$@"
}
(( $+functions[_pixi__project__platform__remove_commands] )) ||
_pixi__project__platform__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project platform remove commands' commands "$@"
}
(( $+functions[_pixi__project__version_commands] )) ||
_pixi__project__version_commands() {
    local commands; commands=(
'get:Get the project version' \
'set:Set the project version' \
'major:Bump the project version to MAJOR' \
'minor:Bump the project version to MINOR' \
'patch:Bump the project version to PATCH' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project version commands' commands "$@"
}
(( $+functions[_pixi__project__version__get_commands] )) ||
_pixi__project__version__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version get commands' commands "$@"
}
(( $+functions[_pixi__project__version__help_commands] )) ||
_pixi__project__version__help_commands() {
    local commands; commands=(
'get:Get the project version' \
'set:Set the project version' \
'major:Bump the project version to MAJOR' \
'minor:Bump the project version to MINOR' \
'patch:Bump the project version to PATCH' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi project version help commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__get_commands] )) ||
_pixi__project__version__help__get_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help get commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__help_commands] )) ||
_pixi__project__version__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help help commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__major_commands] )) ||
_pixi__project__version__help__major_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help major commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__minor_commands] )) ||
_pixi__project__version__help__minor_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help minor commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__patch_commands] )) ||
_pixi__project__version__help__patch_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help patch commands' commands "$@"
}
(( $+functions[_pixi__project__version__help__set_commands] )) ||
_pixi__project__version__help__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version help set commands' commands "$@"
}
(( $+functions[_pixi__project__version__major_commands] )) ||
_pixi__project__version__major_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version major commands' commands "$@"
}
(( $+functions[_pixi__project__version__minor_commands] )) ||
_pixi__project__version__minor_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version minor commands' commands "$@"
}
(( $+functions[_pixi__project__version__patch_commands] )) ||
_pixi__project__version__patch_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version patch commands' commands "$@"
}
(( $+functions[_pixi__project__version__set_commands] )) ||
_pixi__project__version__set_commands() {
    local commands; commands=()
    _describe -t commands 'pixi project version set commands' commands "$@"
}
(( $+functions[_pixi__remove_commands] )) ||
_pixi__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi remove commands' commands "$@"
}
(( $+functions[_pixi__run_commands] )) ||
_pixi__run_commands() {
    local commands; commands=()
    _describe -t commands 'pixi run commands' commands "$@"
}
(( $+functions[_pixi__search_commands] )) ||
_pixi__search_commands() {
    local commands; commands=()
    _describe -t commands 'pixi search commands' commands "$@"
}
(( $+functions[_pixi__self-update_commands] )) ||
_pixi__self-update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi self-update commands' commands "$@"
}
(( $+functions[_pixi__shell_commands] )) ||
_pixi__shell_commands() {
    local commands; commands=()
    _describe -t commands 'pixi shell commands' commands "$@"
}
(( $+functions[_pixi__shell-hook_commands] )) ||
_pixi__shell-hook_commands() {
    local commands; commands=()
    _describe -t commands 'pixi shell-hook commands' commands "$@"
}
(( $+functions[_pixi__task_commands] )) ||
_pixi__task_commands() {
    local commands; commands=(
'add:Add a command to the project' \
'a:Add a command to the project' \
'remove:Remove a command from the project' \
'rm:Remove a command from the project' \
'alias:Alias another specific command' \
'list:List all tasks in the project' \
'ls:List all tasks in the project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi task commands' commands "$@"
}
(( $+functions[_pixi__task__add_commands] )) ||
_pixi__task__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task add commands' commands "$@"
}
(( $+functions[_pixi__task__alias_commands] )) ||
_pixi__task__alias_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task alias commands' commands "$@"
}
(( $+functions[_pixi__task__help_commands] )) ||
_pixi__task__help_commands() {
    local commands; commands=(
'add:Add a command to the project' \
'remove:Remove a command from the project' \
'alias:Alias another specific command' \
'list:List all tasks in the project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'pixi task help commands' commands "$@"
}
(( $+functions[_pixi__task__help__add_commands] )) ||
_pixi__task__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task help add commands' commands "$@"
}
(( $+functions[_pixi__task__help__alias_commands] )) ||
_pixi__task__help__alias_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task help alias commands' commands "$@"
}
(( $+functions[_pixi__task__help__help_commands] )) ||
_pixi__task__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task help help commands' commands "$@"
}
(( $+functions[_pixi__task__help__list_commands] )) ||
_pixi__task__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task help list commands' commands "$@"
}
(( $+functions[_pixi__task__help__remove_commands] )) ||
_pixi__task__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task help remove commands' commands "$@"
}
(( $+functions[_pixi__task__list_commands] )) ||
_pixi__task__list_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task list commands' commands "$@"
}
(( $+functions[_pixi__task__remove_commands] )) ||
_pixi__task__remove_commands() {
    local commands; commands=()
    _describe -t commands 'pixi task remove commands' commands "$@"
}
(( $+functions[_pixi__tree_commands] )) ||
_pixi__tree_commands() {
    local commands; commands=()
    _describe -t commands 'pixi tree commands' commands "$@"
}
(( $+functions[_pixi__update_commands] )) ||
_pixi__update_commands() {
    local commands; commands=()
    _describe -t commands 'pixi update commands' commands "$@"
}
(( $+functions[_pixi__upload_commands] )) ||
_pixi__upload_commands() {
    local commands; commands=()
    _describe -t commands 'pixi upload commands' commands "$@"
}

if [ "$funcstack[1]" = "_pixi" ]; then
    _pixi "$@"
else
    compdef _pixi pixi
fi

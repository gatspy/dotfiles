
# ------------------------------------
# Docker alias and function
# ------------------------------------
# export MACHINE_STORAGE_PATH=/Volumes/Home/Data/docker
# images {{{

# Get images
alias dils="docker images"
alias dila="docker images -a"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dird="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dirt="docker run -i -t -P"

# Remove all images
didi() { docker rmi $1 ;}
alias didd='docker rmi $(docker images -f "dangling=true" -q)'
didn() { docker rmi $(docker images -a | grep '^<none>' | awk '{print $3}') }
# dri() { docker rmi $(docker images -q); }

# }}}

# container {{{

# Get container process
alias dcls="docker ps"
# Get process included stop container
alias dcla="docker ps -a"

# Get container IP
alias dcip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Execute interactive container, e.g., $dex base /bin/bash
alias dcex="docker exec -i -t"

# Remove all containers
dcra() { docker rm $(docker ps -a -q); }
# Stop and Remove all containers
alias dcrs='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Stop all containers
dcstop() {
    if [ "$1" != "" ]; then
        docker stop $1;
    else
        docker stop $(docker ps -a -q);
    fi
}

# }}}

# machine {{{

dmc-ip() {
    if [ "$1" != "" ]; then
        docker-machine ip $1 2> /dev/null
    else
        docker-machine ip 2> /dev/null
    fi
}

dmc-name() {
    echo $DOCKER_MACHINE_NAME
}

dmc() { docker-machine $@ }
dmc-env () {
  eval "$(docker-machine env $1)"
}
# }}}


# utility {{{

dmc-in() {
    docker-machine ssh $DOCKER_MACHINE_NAME
}

dmc-on() {

    if [ "$1" = "" ]; then
        DOCKHOST="default"
    else
        # echo $1
        DOCKHOST="$1"
    fi

    STATUS="$(dmc status $DOCKHOST)"
    STOPPED="Stopped"
    # echo $STATUS
    if [ "$STATUS" != "$STOPPED" ]; then
        # echo "It's there!"
        IP=$(docker-machine ip $DOCKHOST)
        export DOCKER_TLS_VERIFY="1"
        export DOCKER_HOST="tcp://$IP:2376"
        export DOCKER_CERT_PATH="/Users/Gatspy/.docker/machine/machines/$DOCKHOST"
        export DOCKER_MACHINE_NAME="$DOCKHOST"
        # echo $DOCKER_MACHINE_NAME
    else
        echo "$DOCKHOST $STATUS" 2> /dev/null
    fi
    # if ["$STATUS" != "$STOPPED"]; then

    # else
    #     echo $STATUS
    # fi
}

dck-in() {
  docker-machine ssh $DOCKER_MACHINE_NAME '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
  docker-machine ssh $DOCKER_MACHINE_NAME -t sudo /var/lib/boot2docker/docker-enter "$@"
}

dck-host() {
    # echo "$1"
    if [ "$1" = "" ] || [ "$1" = "-p" ] ; then
        DOCKHOST="$DOCKER_MACHINE_NAME"
    else
        # echo $1
        DOCKHOST="$1"
    fi

    if [ "$2" == "" ]; then
        PORT=80;
    else
        PORT="$2";
    fi

    STATUS="$(dmc status $DOCKHOST)"
    STOPPED="Stopped"
    if [ "$STATUS" != "$STOPPED" ]; then
        DOCKIP=$(docker-machine ip $DOCKHOST);
        echo "open dockerhost - $DOCKHOST - $PORT ..."
        open http://$DOCKIP:$PORT;
    else
        echo "$DOCKHOST - $STATUS"
    fi

    # if [ "$1" = "" ] || [ "$1" = "-p" ]; then
    # # if ["$1" == "" -o "$1" == "t"]; then
    #     DOCKHOST=$(docker-machine ip $DOCKER_MACHINE_NAME);
    # else
    #     echo $1
    #     DOCKHOST=$(docker-machine ip $1);
    # fi

    # echo $DOCKHOST

    # open http://$DOCKHOST:$PORT;
}

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build --rm -t=$1 .; }
dbuf() { docker build --rm -t=$1 -f=$2 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# alias dm-ip='docker-machine ip'
dck() { docker $@ }
export DOCKER_COMPOSE_DEV_FILE="/Users/gatspy/App/docker/dev/docker-compose.yaml"
dcp() {docker-compose $@ }
dcp-dev() {docker-compose -f ${DOCKER_COMPOSE_DEV_FILE} $@}



dck_test() {
    echo "$1\n"
    echo "${@:3}"
}
# dmc-on
# }}}


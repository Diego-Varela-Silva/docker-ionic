# Description

Container for develop with ionic 4

## Usage

* Add functions to manage the docker in your bash/zsh config

```
ionicDockerStart() {
    xhost + local:docker
    CURRENT_DIR=${PWD##*/}
    docker run --name $CURRENT_DIR -dt --net host --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/.gradle:/root/.gradle \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $PWD:/myApp:rw \
        -e DISPLAY=$DISPLAY \
        diegovarela/ionic
    docker cp ~/.ssh $1:/root/.ssh
    docker exec -it $1 chown -R root:users /root/.ssh
    docker cp ~/.gitconfig $1:/etc/gitconfig
    docker cp ~/.gitmessage $1:/root/.gitmessage
}

ionicDockerStop() {
    CURRENT_DIR=${PWD##*/}
    docker stop CURRENT_DIR
    docker rm CURRENT_DIR
}
```

* Then start the machine on your project folder

```
ionicDockerStart
```

* Also on the project folde, after the usage you can stop the machine

```
ionicDockerStop myDocker
```

# Description

Container for develop with ionic 4

## Usage

* Add functions to manage the docker in your bash/zsh config

```
ionicDockerStart() {
    xhost + local:docker
    docker run --name $1 -dt --net host --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/.gradle:/root/.gradle \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $PWD:/myApp:rw \
        -v ~/.gitconfig:/etc/gitconfig \
        -v ~/.gitmessage:/root/.gitmessage \
        -e DISPLAY=$DISPLAY \
        diegovarela/ionic
}

ionicDockerStop() {
    docker stop $1
    docker rm $1
}
```

* Then start the machine in your project folder

```
ionicDockerStart myDocker
```

* After the usage you can stop the machine

```
ionicDockerStop myDocker
```

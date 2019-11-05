# Description

Container for develop with ionic 4

## Usage

* Add functions to manage the docker in your bash/zsh config

```
ionicDockerStart() {
  CURRENT_DIR=${PWD##*/}
  docker run --name $CURRENT_DIR -dt --net host --privileged \
    -v /dev/bus/usb:/dev/bus/usb \
    -v $PWD:/home/diego/app:rw \
    docker-ionic:latest
  docker cp ~/.ssh $CURRENT_DIR:/home/diego/.ssh
  docker cp ~/.gitconfig $CURRENT_DIR:/home/diego/gitconfig
}

ionicDockerStop() {
    CURRENT_DIR=${PWD##*/}
    docker stop $CURRENT_DIR
    docker rm $CURRENT_DIR
}
```

* Then start the machine on your project folder

```
ionicDockerStart
```

* Also on the project folde, after the usage you can stop the machine

```
ionicDockerStop
```

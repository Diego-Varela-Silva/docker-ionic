# Description

Container for develop with ionic 4

## Usage

* Add aliases for the docker in your bash/zsh config

```
alias ionic_docker="xhost + local:docker && docker run --name ionic -dt --net host --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v \$PWD:/myApp:rw diegovarela/ionic"
alias ionic='docker exec -it ionic ionic'
alias adb='docker exec -it ionic adb'
alias scrcpy='docker exec -it ionic scrcpy'
```

* Then start the machine in your project folder

```
ionic_docker
```

* You are ready to go with ionic adb and scrcpy

```
ionic serve
adb devices
scrcpy
```

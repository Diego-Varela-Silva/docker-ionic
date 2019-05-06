# Description

Container for develop with ionic 4

## Usage

* Add aliases for the docker in your bash/zsh config

```
alias ionic_docker_start="xhost + local:docker && docker run --name ionic -dt --net host --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v \$PWD:/myApp:rw diegovarela/ionic"
alias ionic_docker_stop="docker stop ionic && docker rm ionic"
alias ionic='docker exec -it ionic ionic'
alias adb='docker exec -it ionic adb'
alias scrcpy='docker exec -it ionic scrcpy'
alias node='docker exec -it ionic node'
alias npm='docker exec -it ionic npm'
```

* Then start the machine in your project folder

```
ionic_docker_start
```

* You are ready to go with ionic, adb, scrcpy and other stuff! 

```
ionic serve
adb devices
scrcpy
npm run test -- --code-coverage --browsers=ChromeHeadlessCI
```

* After the usage you can stop the machine

```
ionic_docker_stop
```

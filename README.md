# Description

Container for develop with ionic 4

## Usage

First start the docker in background

```
docker run --name ionic_docker -dt -p 8100:8100 -p 35729:35729 --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v \$PWD:/myApp:rw diegovarela/ionic
```

Then run commands

```
docker exec -it ionic_docker ionic serve
```

```
docker exec -it ionic_docker adb_devices
```


## Using with alias

```
alias ionic_docker="docker run --name ionic -dt -p 8100:8100 -p 35729:35729 --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v \$PWD:/myApp:rw diegovarela/ionic"
alias ionic='docker exec -it ionic ionic'
alias adb='docker exec -it ionic adb'
```

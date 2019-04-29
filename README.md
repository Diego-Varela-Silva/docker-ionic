# Description

Container for develop with ionic 4

## Usage

Run in background

```
docker run -dt -p 8100:8100 -p 35729:35729 --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v \$PWD:/myApp:rw diegovarela/ionic:4.12.0
```

Attach Shell

```
docker exec -it (name/id) /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"


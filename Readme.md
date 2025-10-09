# Maya for Linux

## About

This repository contains scripts and instructions to help install and run Autodesk Maya on Linux systems.

For now it only supports Maya 2024 using Docker or Nix.


> **🚨 Help Wanted! 🚨**
>
> We are currently working to package Maya 2026.2 for Linux. If you have experience, ideas, or just want to contribute, **all help is welcome!** Please open an issue or pull request to join the effort.

## How to use it

first, you need to [download](https://manage.autodesk.com/products)  the official Autodesk Maya archive and extract it at the root of this repository.
It should create a folder named `Autodesk_Maya_2024_2_Update_Linux_64bit`.

Then you can either use the Docker or Nix method.

### Docker

Build the docker image:
```sh
docker build -f maya4docker/Dockerfile -t maya:2024.2 .
```

Run it:
```sh
xhost +
docker run \
    -ti \
    --rm \
    --network host \
    -e DISPLAY=${DISPLAY} \
    -e XDG_RUNTIME_DIR=/tmp/runtime-user \
    --device /dev/dri:/dev/dri \
    -v /run/user/$(id -u):/tmp/runtime-user \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    maya:2024.2
```

then :
```sh
./start_licensing_service.sh&
su user
maya
```

### Nix

First, you need to set the path to the extracted Maya archive in `maya4nix/flake.nix`

Then you can run Maya and the licensing service with:

```sh
cd maya4nix
NIXPKGS_ALLOW_INSECURE=1 nix run --impure .#adskLicensingService -- --run&
NIXPKGS_ALLOW_INSECURE=1 nix run --impure .#maya 
```

Remark:
- The first time, you need to register maya. After starting the licensing service, run: `NIXPKGS_ALLOW_INSECURE=1 nix run --impure .#adskLicensingInstHelper -- register -pk 657P1 -pv 2024.0.0.F -el EN_US -cf /path/to/Autodesk_Maya_2024_2_Update_Linux_64bit/MayaConfig.pit`
- For the licensing service to run, you need to have a folder `/var/opt/Autodesk` writable by your user.
- For Maya to start, you need to have a folder `/usr/tmp` writable by your user.
- the insecure option is because of openssl-1.1.1, needed by Maya
- To check that maya was register, run `NIXPKGS_ALLOW_INSECURE=1 nix run --impure .#adskLicensingInstHelper list`

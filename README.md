# cpp-ide

## Description

C++ development environment with Visual Studio Code IDE.

The following software is installed:

- GCC-8 compiler
- Visual Studio Code with C++ extension

## Usage

```bash
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v /dev/shm:/dev/shm \
                    -v sources_folder:/src \
                    --cap-add=SYS_PTRACE \
                    --security-opt seccomp=unconfined \
                    vvinch/cpp-ide
```

The --cap-add and --security-opt options are mandatory for running the GDB debugger inside the container.

### Volumes

- /tmp/.X11-unix

   This location must be mapped to the Docker host X11 socket. Typically at the same location.

- /src

   This folder is the root path for C++ projects. This should be mapped to an external volume containing the sources in order to backing up the data and the build results.

- /dev/shm

   This specific volume allows mapping shared memory to the native system one.

### Environment

- DISPLAY=:0.0

   This environment variable is defined by default.

- VS_OPTIONS

   Additionnal command line parameters for Visual Studio Code (eg: ```--ignore-certificate-errors```)

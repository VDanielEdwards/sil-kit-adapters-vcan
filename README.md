# Vector SIL Kit Adapter for SocketCAN 
This collection of software is provided to illustrate how the [Vector SIL Kit](https://github.com/vectorgrp/sil-kit/)
can be attached to a virtual CAN (Controller Area Network) interface [[SocketCAN]](https://docs.kernel.org/networking/can.html) running in Linux kernel.

This repository contains instructions to build the adapter and set up a minimal working development environment.

The main contents are working examples of necessary software to connect the running system to a SIL Kit environment,
as well as complimentary demo applications for some communication to happen.

## Getting Started
Those instructions assume you use a Linux OS (or a virtual machine running a Linux image) for building and running the adapter and use ``bash`` as your interactive
shell.

This section specifies steps you should do if you have just cloned the repository.

First, change your current directory to the top-level in the ``sil-kit-adapters-vcan``
repository:

    cd /path/to/sil-kit-adapters-vcan

### Fetch Third Party Software
The first thing that you should do is initializing the submodules to fetch the required third party software:

    git submodule update --init --recursive

Otherwise clone the standalone version of asio manually:

    git clone --branch asio-1-18-2 https://github.com/chriskohlhoff/asio.git third_party/asio

### Build the Adapter
To build the adapter, you'll need an ubuntu SIL Kit package ``SilKit-x.y.z-$ubuntu``. You can download it directly from [Vector SIL Kit Releases](https://github.com/vectorgrp/sil-kit/releases). The easiest way would be to download it with your web browser, unzip it and place it on your file system, where it also can be accessed by ``bash``.

The adapters and demos are built using ``cmake``:

    mkdir build
    cmake -S. -Bbuild -DSILKIT_PACKAGE_DIR=/path/to/SilKit-x.y.z-$ubuntu/
    cmake --build build --parallel

The adapter executable will be available in ``build/bin`` (depending on the configured build directory).
Additionally the ``SilKit`` shared object (e.g., ``libSilKitd.so``) is copied to that directory automatically.

### Run the SilKitAdapterSocketCAN
This application allows the user to attach virtual CAN interfaces (``SocketCAN``) running in Linux environment to the
SIL Kit.

Before you start the adapter there always needs to be a sil-kit-registry running already. Start it e.g. like this:

    ./path/to/SilKit-x.y.z-$ubuntu/SilKit/bin/sil-kit-registry --listen-uri 'silkit://127.0.0.1:8501'

It is also necessary that a virtual CAN interface is already opened and running in Linux kernel before you run the adapter. This can be done using the following terminal commands: 

    sudo modprobe vcan
    ip link add dev can0 type vcan
    ip link set up can0

**Note:** These commands will open a virtual CAN interface with the name ``can0``.

Now you can run the adapter from terminal. 

    ./build/bin/SilKitAdapterSocketCAN

This command will run the adapter with default parameters: 
    
    can-name         : can0
    registry-uri     : silkit://localhost:8501
    participant-name : SocketCAN_silkit
    network-name     : NETCAN0

**Note:** Optionally, if you want to change the values of any of these parameters, you can run the adapter with the following optional command line arguments:

    ./build/bin/SilKitAdapterSocketCAN [--can-name 'A'] [--registry-uri 'silkit://B:8501'] [--participant-name 'C'] [--network-name 'D']

You may set the ``A``,``B``,``C``,``D`` values according to your preference.   


## SocketCAN Demo
The aim of this demo is to showcase a simple adapter forwarding CAN traffic from Linux terminal running a virtual CAN interface through to
Vector SIL Kit. 

This demo is further explained in [SocketCAN/README.md](SocketCAN/README.md).

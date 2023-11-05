## Qrackmin - a minimalistic container image for Qrack - OpenCL & CUDA

`:latest` container image is meant to be used on a single node with Nvidia-Docker2 and Linux support

```bash
docker run --gpus all --device=/dev/dri:/dev/dri --privileged -d twobombs/qrackmin[:tag]
````

- `-v /var/log/qrack:/var/log/qrack` for saving of measured results outside container

```bash 
docker exec -ti [containerID] bash
````

- ThereminQ repo with runfiles is checked out on `/root`

- Windows users should install `WSL2, Docker Desktop, Ubuntu 22.04, docker.io, nvidia-docker2` to run this ( `CUDA` only )

---------------

- ### `Qrackmin:POCL` - latest & POCL added for CPU-only support

`:pocl` container image adds the generic OpenCL-ICD and is to be used with high memory & CPU count hosts 

- Simulate performance and measured results on CPU
- For validation before GPU cluster deployment

---------------

- ### Qrackmin`:VCL` - Qrack@VCL with node support

`:vcl` contains the VCL binaries to run VCL as a backend and host

#### On the host the following directory structure needs to be created 
`sudo mkdir /var/log/vcl /var/log/vcl/etc /var/log/vcl/etc/vcl/ /var/log/vcl/etc/init.d /var/log/vcl/usr /var/log/vcl/usr/bin /var/log/vcl/etc/rc0.d /var/log/vcl/etc/rc1.d /var/log/vcl/etc/rc2.d /var/log/vcl/etc/rc3.d /var/log/vcl/etc/rc4.d /var/log/vcl/etc/rc5.d /var/log/vcl/etc/rc6.d`

####  Run the bash in `/run-scripts/` in this repository called `./1-run-nodes`
You will be asked two questions:
- the amount of virtual nodes you want to create
- the NVIDIA devices you want to expose ( often 'all' will suffice, otherwise use the device number )*

#### When you've deployed enough backend containers to you liking you can start `./2-run-host`
- the nodes' IPs will be scraped
- the host container will be started and will initialize
- you'll drop into the `host-containers' bash`
- then run workloads through `./vcl-1.25/vclrun [command]`

(*) = other OpenCL device types such as an IntelIGP that are also recognised will also be taken into the cluster

---------------

#### A Full VDI host experience is avaliable in `ThereminQ:vcl-controller`
https://github.com/twobombs/thereminq#to-run-thereminq-as-a-virtualcl-controller

### Follow the guide for running VCL in a cluster [here](https://mosix.cs.huji.ac.il/vcl/VCL_Guide.pdf)

### For multi-host setup please look [here](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)

Zerotier https://www.zerotier.com/

---------------

### Credits go to Dan Strano for creating Qrack
https://github.com/unitaryfund/qrack

## Qrackmin

- ### Qrackmin:latest - a minimum Qrack@OCL 

docker run --gpus all --device=/dev/dri:/dev/dri --mount type=bind,source=/var/log/qrack,target=/var/log/qrack -d twobombs/qrackmin[:tag]

then: docker exec -ti [containerID] bash

ThereminQ repo with runfile is checked out on root

Created for minimalistic verification purposes for ThereminQ https://github.com/twobombs/thereminq


- ### Qrackmin:POCL - latest & POCL added for CPU-only support

This container images is meant to be used with high memory & CPU count hosts 

Simulate performance and measured results on high-Qubit (34+) for validation before GPU cluster deployment

For this reason POCL CPU OpenCL ICD is installed so OpenCL is used for maximum alignment with GPU OCL requirements

- ### Qrackmin:CUDA -  a minimum Qrack@CUDA 

This container image is meant to be used with Single node or Clustered NV-link enabled GPUs 

Windows users should install Docker Desktop, WSL2 - Ubuntu 22.04 and CUDA with docker.io to run this on-par with Linux

- ### Qrackmin:VCL - Qrack@OCL with node support

Qrackmin:VCL contains the VCL binaries to run VCL as a backend and host

#### On the host the following directory structure needs to be created 
mkdir /var/log/vcl && mkdir /var/log/vcl/etc && mkdir /var/log/vcl/etc/vcl/ && mkdir /var/log/vcl/etc/init.d && mkdir /var/log/vcl/usr && mkdir /var/log/vcl/usr/bin && mkdir /var/log/vcl/etc/rc0.d && mkdir /var/log/vcl/etc/rc1.d && mkdir /var/log/vcl/etc/rc2.d  &&  mkdir /var/log/vcl/etc/rc3.d && mkdir /var/log/vcl/etc/rc4.d &&  mkdir /var/log/vcl/etc/rc5.d &&  mkdir /var/log/vcl/etc/rc6.d 

####  Run the bash in /run-scripts/ in this repository called ./1-run-nodes ( make it executable with chmod 744 )
You will be asked two questions:
- the amount of virtual nodes you want to create
- the NVIDIA devices you want to expose ( often 'all' will suffice, otherwise use the device number )*

#### When you've deployed enough backend containers to you liking you can start ./2-run-host
- the nodes' IPs will be scraped
- the host container will be started and will initialize
- you'll drop into the host-containers' bash 
- then run workloads through ./vcl-1.25/vclrun [command]

(*) = other OpenCL device types such as an IntelIGP that are also recognised will also be taken into the cluster

#### A Full VDI host experience is avaliable in ThereminQ:vcl-controller
https://github.com/twobombs/thereminq#to-run-thereminq-as-a-virtualcl-controller

### Follow the guide for running VCL in a cluster here
https://mosix.cs.huji.ac.il/vcl/VCL_Guide.pdf

### For multi-host setup please look at
Docker Swarm https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/

Zerotier https://www.zerotier.com/

### Credits go to Dan Strano for creating Qrack
https://github.com/unitaryfund/qrack

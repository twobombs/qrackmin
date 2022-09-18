## Qrackmin

### Minimum Qrack@docker 

docker run --gpus all --device=/dev/dri:/dev/dri --mount type=bind,source=/var/log/qrack,target=/var/log/qrack -d twobombs/qrackmin

then: docker exec -ti [containerID] bash

ThereminQ repo with runfile is checked out on root
Created for minimalistic verification purposes

### VCL Qrack@docker nodes

Qrackmin:vcl contains the VCL binaries to run VCL as a backend and host

#### On the host the following directory structure needs to be created 
mkdir /var/log/vcl && /var/log/vcl/etc && mkdir /var/log/vcl/etc/vcl/ && mkdir /var/log/vcl/etc/init.d && mkdir /var/log/vcl/usr && mkdir /var/log/vcl/usr/bin && mkdir /var/log/vcl/etc/rc0.d && mkdir /var/log/vcl/etc/rc1.d && mkdir /var/log/vcl/etc/rc2.d  &&  mkdir /var/log/vcl/etc/rc3.d && mkdir /var/log/vcl/etc/rc4.d &&  mkdir /var/log/vcl/etc/rc5.d &&  mkdir /var/log/vcl/etc/rc6.d 

####  Run the bash script in this repository called ./run-nodes ( make it executable with chmod 744 )
You will be asked two questions:
- the amount of virtual nodes you want to create
- the NVIDIA devices you want to expose ( often 'all' will suffice, otherwise use the device number )*

#### When you've deployed enough backend containers to you liking you can start ./run-host
- the nodes' IPs will be scraped
- the host will be started and will initialize
- you'll drop into the host-containers' bash 
- then run workloads through ./vcl-1.25/vclrun

(*) = other OpenCL device types such as an IntelIGP that are also recognised will also be taken into the cluster

#### A Full VDI host experience is avaliable in ThereminQ:vcl-controller
https://github.com/twobombs/thereminq#to-run-thereminq-as-a-virtualcl-controller

### Follow the guide for running VCL in a cluster here

https://mosix.cs.huji.ac.il/vcl/VCL_Guide.pdf

All credits go to Dan Strano for creating Qrack

https://github.com/unitaryfund/qrack

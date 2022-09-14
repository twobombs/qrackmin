## Qrackmin

### Minimum Qrack@docker 

docker run --gpus all --device=/dev/dri:/dev/dri --mount type=bind,source=/var/log/qrack,target=/var/log/qrack -d twobombs/qrackmin

then: docker exec -ti [containerID] bash

ThereminQ repo with runfile is checked out on root
Created for minimalistic verification purposes

### VCL Qrack@docker nodes

Qrackmin:vcl contains the VCL binaries to run VCL as a backend and host

#### The VDI host experience is avaliable in ThereminQ:controller
https://github.com/twobombs/thereminq#to-run-thereminq-as-a-virtualcl-controller

Tip: preset directories on host machine, fill in /var/log/vcl in ./vclconfig

mkdir /var/log/vcl && /var/log/vcl/etc && mkdir /var/log/vcl/etc/init.d && mkdir /var/log/vcl/usr && mkdir /var/log/vcl/usr/bin && mkdir /var/log/vcl/etc/rc0.d && mkdir /var/log/vcl/etc/rc1.d && mkdir /var/log/vcl/etc/rc2.d  &&  mkdir /var/log/vcl/etc/rc3.d && mkdir /var/log/vcl/etc/rc4.d &&  mkdir /var/log/vcl/etc/rc5.d &&  mkdir /var/log/vcl/etc/rc6.d 

docker run --gpus all --device=/dev/dri:/dev/dri --mount type=bind,source=/var/log/vcl,target=/var/log/vcl -d twobombs/qrackmin:vcl

then: docker exec -ti [containerID] bash for configuration and/or running workloads through ./vclrun

### Follow the guide for configuring VCL in a cluster here

https://mosix.cs.huji.ac.il/vcl/VCL_Guide.pdf

All credits go to Dan Strano for creating Qrack

https://github.com/unitaryfund/qrack

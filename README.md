## Qrackmin - a minimalistic container image for Qrack - OpenCL & CUDA

[`:latest`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile) container image is meant to be used on a single node with Nvidia-Docker2 and Linux support

```bash
docker run --gpus all --device=/dev/dri:/dev/dri --privileged -d twobombs/qrackmin[:tag]
````

- `-v /var/log/qrack:/var/log/qrack` for saving of measured results outside container

```bash 
docker exec -ti [containerID] bash
````

- ThereminQ repo with runfiles is checked out on `/root`

- Windows users should install `WSL2, Docker Desktop, docker.io, nvidia-docker2` to run this ( `CUDA` only )

---------------

- ### `Qrackmin:AWS` - `Qrackmin:PYTHON` - `Qrackmin:QISKIT`
  on demand AWS template proposals ( in active development )

- [`:AWS`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-aws) boilerplate code for Qrack as a Service ( benchmarks output )

![image](https://github.com/twobombs/qrackmin/assets/12692227/02f74309-bb42-43fd-b0bd-8197cce9835e)

- [`:PYTHON`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-python) boilerplate code for PyQrack as a notebook container runtime

![imagepython](https://github.com/twobombs/qrackmin/assets/12692227/008a8a06-7980-47e6-b75e-a09685f879c0)

- [`:QISKIT`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-qiskit) boilerplate code to run Qiskit notebooks and Python container runtime ( dev. features pending )

The AWS template proposal container images run on Qrack's native C++ simulation and have only minimal OpenCL support

---------------

- ### `Qrackmin:POCL` - latest & POCL added for CPU-only support

[`:pocl`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-pocl) container image adds the generic OpenCL-ICD and is to be used with high memory & CPU count hosts 

- Simulate performance and measured results on CPU
- For validation before GPU cluster deployment

---------------

- ### Qrackmin`:VCL` - Qrack@VCL with node support

[`:vcl`](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-vcl) contains the VCL binaries to run VCL as a backend and host

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

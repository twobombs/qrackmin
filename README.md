<img width="1016" height="443" alt="Screenshot from 2026-01-01 15-36-30" src="https://github.com/user-attachments/assets/b5c8d613-5dac-484a-baef-0032dfd8e484" />


# Thereminq - HPC container solutions

![Screenshot from 2024-10-05 15-58-16](https://github.com/user-attachments/assets/d84647ea-3158-4e48-98d0-60d884f82283)
*Thereminq-HPC container system deployed in rancher through the ThereminQ [HELM](https://github.com/twobombs/thereminq-helm) definitions*

## Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Docker Deployments](#docker-deployments)
  - [latest](#latest)
  - [AWS & BRAKET](#aws--braket)
  - [pyqrack & qbdd](#pyqrack--qbdd)
  - [elidded](#elidded)
  - [POCL](#pocl)
  - [VCL](#vcl)
- [Run Scripts](#run-scripts)
- [VCL Cluster Setup](#vcl-cluster-setup)
- [Credits](#credits)
- [License](#license)

## Overview

Thereminq-HPC is a minimalistic container system for [Qrack](https://github.com/unitaryfund/qrack), designed for both OpenCL and CUDA environments. It provides a set of Docker images and scripts to run quantum computing simulations and benchmarks. ThereminQ orchestrates a suite of best-of-class tools designed to control extend and visualize data emanating for Quantum circuits using Qrack ELK Tipsy Jupyter CUDA and OpenCL accelerators.

## Directory Structure

Here's an overview of the main directories in this repository:

-   `benchmarks/`: Contains benchmark files for testing quantum simulations.
-   `deploy-scripts/`: Includes scripts for deploying and managing the containerized environment, especially for VCL clusters.
-   `dockerfiles/`: A collection of Dockerfiles to build various container images tailored for different environments and purposes (e.g., AWS, CUDA, OpenCL, Python).
-   `run-scripts/`: A variety of scripts to execute different quantum simulation tasks and benchmarks within the containers.

## Dockerfiles

The `dockerfiles/` directory contains a variety of Dockerfiles to build container images for different environments and purposes. Here's a breakdown of the most important ones:

| Dockerfile                        | Purpose                                                                                             |
| --------------------------------- | --------------------------------------------------------------------------------------------------- |
| `Dockerfile`                      | The main Dockerfile for the `:latest` image, including CUDA and OpenCL support.                     |
| `Dockerfile-1804`                 | Dockerfile for Ubuntu 18.04.                                                                        |
| `Dockerfile-2004`                 | Dockerfile for Ubuntu 20.04.                                                                        |
| `Dockerfile-2204`                 | Dockerfile for Ubuntu 22.04.                                                                        |
| `Dockerfile-2204amd`              | Dockerfile for Ubuntu 22.04 with AMD support.                                                       |
| `Dockerfile-arm`                  | Dockerfile for ARM architecture.                                                                    |
| `Dockerfile-aws`                  | For `Thereminq-HPC:AWS`, providing a binary runtime for Qrack as a Service on AWS.                       |
| `Dockerfile-braket`               | For `Thereminq-HPC:BRAKET`, providing a Python runtime for PyQrack as a `|BraKET>` container service.     |
| `Dockerfile-cluster`              | Dockerfile for cluster support.                                                                     |
| `Dockerfile-cluster-pocl`         | Dockerfile for cluster support with POCL.                                                           |
| `Dockerfile-cuda`                 | Dockerfile with CUDA support.                                                                       |
| `Dockerfile-mitiq`                | Dockerfile for Mitiq.                                                                               |
| `Dockerfile-pocl`                 | For `Thereminq-HPC:POCL`, adding the generic OpenCL-ICD for CPU-only support.                            |
| `Dockerfile-pyqrack`              | A Python runtime environment for running `pyqrack` tests.                                           |
| `Dockerfile-qbdd`                 | A Python runtime environment for running `qbdd` benchmarks.                                         |
| `Dockerfile-qbdd-sycamore-sleep`  | Dockerfile for qbdd sycamore sleep.                                                                 |
| `Dockerfile-qimcifa`              | Dockerfile for Qimcifa.                                                                             |
| `Dockerfile-sycamore-elidded`     | For `Thereminq-HPC:elidded`, for elidded and patched quadrant time tests.                                |
| `Dockerfile-vcl`                  | For `Thereminq-HPC:VCL`, containing VCL binaries for VCL cluster support.                                |
| `Dockerfile-vcl-controller`       | Dockerfile for VCL controller.                                                                      |
| `Dockerfile-vcl-pocl`             | Dockerfile for VCL with POCL support.                                                               |
| `Dockerfile-vcl-pocl-vpn`         | Dockerfile for VCL with POCL and VPN support.                                                       |

## Docker Deployments

### `latest`

The `:latest` container image is meant to be used on a single node with Nvidia-Docker2 and Linux support.

```bash
docker run --gpus all --device=/dev/kfd --device=/dev/dri:/dev/dri --privileged -d twobombs/thereminq-hpc[:tag] [--memory 24G --memory-swap 250G]
```

-   To save measured results outside the container, use the volume flag: `-v /var/log/qrack:/var/log/qrack`.
-   To get a shell inside the container:

```bash
docker exec -ti [containerID] bash
```

-   The ThereminQ repo with runfiles is checked out at `/root`.
-   Windows users should install `WSL2`, `Docker Desktop`, `docker.io`, and `nvidia-docker2` to run this (`CUDA` only).

---

### `AWS` & `BRAKET`

-   **`Thereminq-HPC:AWS`** (`:AWS`): On-demand AWS template proposals for x86 and ARM - CUDA, OpenCL and CPU powered. Boilerplate binary runtime code for Qrack as a Service - QFT RND benchmarks output. [Dockerfile-aws](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-aws)
-   **`Thereminq-HPC:BRAKET`** (`:BRAKET`): Boilerplate python runtime code for `PyQrack` as a `|BraKET>` container service. [Dockerfile-braket](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-braket)

---

### `pyqrack` & `qbdd`

-   **`Thereminq-HPC:pyqrack`**: A python runtime environment to run tests for pyqrack.
-   **`Thereminq-HPC:qbdd`**: A python runtime environment to run benchmarks for qbdd.

---

### `elidded`

Elidded and patched quadrant time tests.

![1734875657236](https://github.com/user-attachments/assets/b69d2334-7da8-4985-9c26-a2b745af91c5)

```bash
docker run --gpus all --device=/dev/dri:/dev/dri -d twobombs/thereminq-hpc:elidded
```

---

### `POCL`

The `:pocl` container image adds the generic OpenCL-ICD and is to be used with high memory & CPU count hosts for CPU-only support.

-   Simulate performance and measured results on CPU.
-   For validation before GPU cluster deployment.
-   [Dockerfile-pocl](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-pocl)

---

### `VCL`

The `:vcl` tag contains [VCL](https://mosix.cs.huji.ac.il/txt_vcl.html) binaries that are copyrighted by Amnon Barak to run VCL as a backend and host. See the [VCL Cluster Setup](#vcl-cluster-setup) section for more details. [Dockerfile-vcl](https://github.com/twobombs/qrackmin/blob/main/dockerfiles/Dockerfile-vcl)

---

## Run Scripts

The `run-scripts/` directory contains various scripts to execute simulations and benchmarks. You can run these scripts from within the appropriate Docker container. For example, to run a qbdd benchmark:

1.  Start the `qbdd` container.
2.  Get a shell inside the container.
3.  Navigate to the `/root/thereminq/run-scripts` directory.
4.  Execute the desired script, e.g., `./run-qbdd`.

The `run-scripts/` directory contains various scripts to execute simulations and benchmarks. You can run these scripts from within the appropriate Docker container. For example, to run a qbdd benchmark:

| Script                             | Description                                                                                              |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `run`                              | A general-purpose script to run simulations.                                                             |
| `run-arm`                          | Script for running simulations on ARM architecture.                                                      |
| `run-aws`                          | Script for running simulations on AWS.                                                                   |
| `run-cluster`                      | Script for running simulations on a cluster.                                                             |
| `run-fqa-dask`                     | Script for running FQA Dask simulations.                                                                 |
| `run-python`                       | Script for running Python-based simulations.                                                             |
| `run-qbdd`                         | A script to run `qbdd` benchmarks.                                                                       |
| `run-qbdd-sycamore-sleep`          | A script to run `qbdd` sycamore sleep benchmarks.                                                        |
| `run-rcs-nn`                       | A script to run RCS NN benchmarks.                                                                       |
| `run-sycamore-patch-quadrant`      | A script to run sycamore patch quadrant benchmarks.                                                      |
| `run-vcl`                          | Script for running VCL.                                                                                  |
| `run-vcl-controller`               | Script for running VCL controller.                                                                       |
| `run-vcl-vpn`                      | Script for running VCL with VPN.                                                                         |

Please refer to the individual scripts for more details on their usage.

## VCL Cluster Setup

Thereminq-HPC can be deployed as a VCL cluster for distributed computing.

#### On the host, the following directory structure needs to be created:

```bash
sudo mkdir -p /var/log/vcl/etc/vcl/ /var/log/vcl/etc/init.d /var/log/vcl/usr/bin /var/log/vcl/etc/rc0.d /var/log/vcl/etc/rc1.d /var/log/vcl/etc/rc2.d /var/log/vcl/etc/rc3.d /var/log/vcl/etc/rc4.d /var/log/vcl/etc/rc5.d /var/log/vcl/etc/rc6.d
```

#### 1. Run the VCL Nodes

Run the bash script in `/run-scripts/` in this repository called `./1-run-nodes`. You will be asked two questions:
-   The amount of virtual nodes you want to create.
-   The NVIDIA devices you want to expose (often 'all' will suffice, otherwise use the device number).

*Other OpenCL device types such as an Intel IGP that are also recognised will also be taken into the cluster.*

#### 2. Run the VCL Host

When you've deployed enough backend containers to your liking, you can start `./2-run-host`.
-   The nodes' IPs will be scraped.
-   The host container will be started and will initialize.
-   You'll drop into the host-container's bash.
-   Then run workloads through `./vcl-1.25/vclrun [command]`.

---

#### A Full VDI host experience is available in [`ThereminQ:vcl-controller`](https://github.com/twobombs/thereminq#to-run-thereminq-as-a-virtualcl-controller)

#### Follow the guide for running [`VCL`](https://mosix.cs.huji.ac.il/txt_vcl.html) in a cluster [here](https://mosix.cs.huji.ac.il/vcl/VCL_Guide.pdf).

#### For multi-host setup please look [`Docker Swarm`](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/) and [`Zerotier`](https://www.zerotier.com/).

---

## Credits

-   Dan Strano for creating [Qrack](https://github.com/unitaryfund/qrack) and [Qimcifa](https://github.com/vm6502q/qimcifa).
-   Some rights are reserved regarding code and functionality for the `Amazon AWS |BraKET>` container images; they are in the git repo checkouts for the `:aws` and `:braket` container images and the `aws tools` for Amazon AWS as well.

## License

This project is licensed under the GPL-3.0+ License. See the [LICENSE](LICENSE) file for details.

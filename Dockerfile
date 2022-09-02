FROM nvidia/cudagl:11.4.2-base-ubuntu20.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# install glvnd ( temp key fix )
RUN apt-get clean && \
    apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/cuda/repos/$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F'=' '{print $2}' | sed 's/[^0-9]*//g')/x86_64/3bf863cc.pub" && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt install -y software-properties-common && add-apt-repository multiverse && apt update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends pkg-config libglvnd-dev && apt-get -f -y install && dpkg --configure -a && apt-get clean all && apt -y autoremove

COPY run /root/run
ENTRYPOINT /root/run

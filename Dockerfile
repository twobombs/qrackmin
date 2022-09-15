FROM nvidia/cudagl:11.4.2-base-ubuntu20.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# install glvnd ( temp key fix )
RUN apt-get clean && \
    apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/cuda/repos/$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F'=' '{print $2}' | sed 's/[^0-9]*//g')/x86_64/3bf863cc.pub" && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt install -y software-properties-common net-tools clinfo git mc opencl-headers ocl-icd-opencl-dev  && add-apt-repository multiverse && apt update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends pkg-config libglvnd-dev && apt-get -f -y install && dpkg --configure -a && apt-get clean all && apt -y autoremove

# NVidia hw integration
RUN mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# clone repos
RUN git clone --recursive https://github.com/unitaryfund/qrack.git
RUN cp -r /qrack /qrack128
RUN cp -r /qrack /qrack64
RUN cp -r /qrack /qrack16
RUN cp -r /qrack /qrack8

# install features
RUN apt-get update && apt-get -y install build-essential cmake openssh-server wget vim-common opencl-headers curl libfreetype6-dev autotools-dev libicu-dev libbz2-dev libboost-all-dev && apt-get clean all
# Qrack install & dependancies 
RUN cd /qrack/include && mkdir CL && cd /var/log && mkdir qrack && cd /qrack && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=5 -DUINTPOW=6 -DQBCAPPOW=6 -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON .. && make -i -k -j 2 all && make install
# 64Qrack install & dependancies
RUN cd /qrack64/include && mkdir CL && cd /qrack64 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=7 -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON .. && make -i -k -j 2 all && make install
# SmallQrack install & dependancies
# RUN cd /qrack16/include && mkdir CL && cd /qrack16 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=4 -DUINTPOW=5 -DQBCAPPOW=5 -DENABLE_COMPLEX_X2=OFF -DENABLE_OCL_MEM_GUARDS=ON .. && make -i -k -j 2 all && make install
# BigQrack install & dependancies
RUN cd /qrack128/include && mkdir CL && cd /qrack128 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=12 -DENABLE_RDRAND=OFF -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON .. && make -i -k -j 2 all && make install
# fetch thereminq & run/build scripts
RUN git clone https://github.com/twobombs/thereminq.git && cd /thereminq/runscripts/ && chmod 744 * && cp run-* /root/

COPY run* /root/*
RUN chmod 744 /root/run*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENTRYPOINT /root/run

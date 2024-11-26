FROM nvidia/cuda:12.4.1-devel-ubuntu22.04
LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# upgrade image because of nv not upgrading
RUN apt update && apt -y upgrade && apt clean all

# fetch qrack-dev deb package
RUN apt update && apt install -y software-properties-common && apt clean
RUN add-apt-repository -y ppa:wrathfulspatula/vm6502q && apt clean
RUN apt install -y libqrack-dev libeigen3-dev

# install glvnd ( temp key fix )
RUN apt-get clean && \
    apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/cuda/repos/$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F'=' '{print $2}' | sed 's/[^0-9]*//g')/x86_64/3bf863cc.pub" && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt install -y software-properties-common net-tools openvpn netcat clinfo git mc opencl-headers ocl-icd-opencl-dev  && add-apt-repository multiverse && apt update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends pkg-config libglvnd-dev pciutils && apt-get -f -y install && dpkg --configure -a && apt-get clean all && apt -y autoremove

# NVidia hw integration
RUN mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# install dask
RUN apt install -y python3-pip && apt clean all && pip3 install dask-cuda cupy joblib matplotlib && pip3 cache purge

# install openmpi
RUN apt-get install -y infiniband-diags ibverbs-utils libibverbs-dev libfabric1 libfabric-dev libpsm2-dev && apt clean all
RUN apt-get install -y openmpi-bin openmpi-common libopenmpi-dev libgtk2.0-dev && apt clean all
RUN apt-get install -y librdmacm-dev libpsm2-dev && apt clean all
# openmpi benchmark
RUN git clone https://github.com/forresti/osu-micro-benchmarks.git && cd osu-micro-benchmarks 
## && ./configure CC=mpicc CXX=mpicxx --enable-cuda && make

# GVirtuS
RUN apt-get install -y build-essential cmake libxmu-dev libxi-dev libgl-dev libosmesa-dev git liblog4cplus-dev cudnn && apt clean all
RUN git clone https://github.com/vm6502q/GVirtuS.git qrack_update && cd /qrack_updateS && mkdir build && cd build && cmake .. && make && make install

# clone repo
RUN git clone --depth=1 --recursive https://github.com/unitaryfund/qrack.git

RUN cp -r /qrack /qrack128
RUN cp -r /qrack /qrack64
RUN cp -r /qrack /qrack16
RUN cp -r /qrack /qrack8

RUN cp -r /qrack /qrack128cuda
RUN cp -r /qrack /qrackcuda
RUN cp -r /qrack /qrack128cuda
RUN cp -r /qrack /qrack64cuda
RUN cp -r /qrack /qrack16cuda
RUN cp -r /qrack /qrack8cuda

RUN cp -r /qrack /qrackcudagvirtus

# install features
RUN apt-get update && apt-get -y install build-essential cmake openssh-server wget vim-common opencl-headers curl libfreetype6-dev autotools-dev libicu-dev libbz2-dev libboost-all-dev && apt-get clean all

# CUDA Qrack install & dependancies 
RUN cd /qrackcuda/include && mkdir CL && cd /var/log && mkdir qrack && cd /qrackcuda && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=5 -DUINTPOW=6 -DQBCAPPOW=6 -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON -DENABLE_CUDA=ON -DENABLE_OPENCL=OFF -DQRACK_CUDA_ARCHITECTURES=50 .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all
RUN cd /qrack64cuda/include && mkdir CL && cd /qrack64cuda && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=7 -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON -DENABLE_CUDA=ON -DENABLE_OPENCL=OFF -DQRACK_CUDA_ARCHITECTURES=50 .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all
# SmallQrack install & dependancies
RUN cd /qrack16cuda/include && mkdir CL && cd /qrack16cuda && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=4 -DUINTPOW=5 -DQBCAPPOW=5 -DENABLE_COMPLEX_X2=OFF -DENABLE_OCL_MEM_GUARDS=ON -DENABLE_CUDA=ON -DENABLE_OPENCL=OFF -DQRACK_CUDA_ARCHITECTURES=50 .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all
# BigQrack install & dependancies
RUN cd /qrack128cuda/include && mkdir CL && cd /qrack128cuda && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=12 -DENABLE_RDRAND=OFF -DENABLE_COMPLEX_X2=ON -DENABLE_OCL_MEM_GUARDS=ON -DENABLE_CUDA=ON -DENABLE_OPENCL=OFF -DQRACK_CUDA_ARCHITECTURES=50 .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all

# Qrack install & dependancies 
RUN cd /qrack/include && mkdir CL && cd /qrack && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=5 -DUINTPOW=6 -DQBCAPPOW=6 -DENABLE_COMPLEX_X2=ON .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all 
# 64Qrack install & dependancies
RUN cd /qrack64/include && mkdir CL && cd /qrack64 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=7 -DENABLE_COMPLEX_X2=ON .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all 
# SmallQrack install & dependancies
RUN cd /qrack16/include && mkdir CL && cd /qrack16 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=4 -DUINTPOW=5 -DQBCAPPOW=5 -DENABLE_COMPLEX_X2=OFF -DENABLE_OCL_MEM_GUARDS=ON .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all
# BigQrack install & dependancies
RUN cd /qrack128/include && mkdir CL && cd /qrack128 && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DFPPOW=6 -DUINTPOW=6 -DQBCAPPOW=12 -DENABLE_RDRAND=OFF -DENABLE_COMPLEX_X2=ON .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all 

# qrack cuda ENABLE_GVIRTUS
RUN cd /qrackcudagvirtus/include && mkdir CL && cd /qrackcudagvirtus/ && mkdir _build && cd _build && cmake -DENABLE_DEVRAND=ON -DENABLE_RDRAND=OFF -DFPPOW=5 -DUINTPOW=6 -DQBCAPPOW=6 -DENABLE_COMPLEX_X2=ON -DENABLE_CUDA=ON -DENABLE_OPENCL=OFF -DQRACK_CUDA_ARCHITECTURES=50 -DENABLE_GVIRTUS=ON .. && make -i -k -j $(grep -c ^processor /proc/cpuinfo) all

# fetch thereminq & run/build scripts
RUN git clone --depth=1 https://github.com/twobombs/thereminq.git && cd /thereminq/runscripts/ && chmod 744 * && cp run-* /root/

COPY run-scripts/run* /root/
RUN chmod 755 /root/run*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENTRYPOINT /root/run

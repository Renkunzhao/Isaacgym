FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive 

RUN sed -i 's|http://.*archive.ubuntu.com|http://mirror.mit.edu/ubuntu/|g' /etc/apt/sources.list && \
    sed -i 's|http://.*security.ubuntu.com|http://mirror.mit.edu/ubuntu/|g' /etc/apt/sources.list && \
    apt clean

# dependencies for gym
#
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 libxcursor-dev \
 libxrandr-dev \
 libxinerama-dev \
 libxi-dev \
 mesa-common-dev \
 zip \
 unzip \
 make \
 vulkan-tools \
 mesa-vulkan-drivers \
 pigz \
 git \
 libegl1 \
 git-lfs

RUN apt-get install -y wget python3-pip libmkl-intel-lp64 libmkl-gnu-thread libmkl-core libomp5 openmpi-bin && \
    pip install uv && \
    ln -s /usr/lib/x86_64-linux-gnu/libomp.so.5 /usr/lib/x86_64-linux-gnu/libomp.so

RUN apt upgrade libcudnn9-cuda-12 libcudnn9-dev-cuda-12

# WAR for eglReleaseThread shutdown crash in libEGL_mesa.so.0 (ensure it's never detected/loaded)
# Can't remove package libegl-mesa0 directly (because of libegl1 which we need)
RUN rm /usr/lib/x86_64-linux-gnu/libEGL_mesa.so.0 /usr/lib/x86_64-linux-gnu/libEGL_mesa.so.0.0.0 /usr/share/glvnd/egl_vendor.d/50_mesa.json

COPY docker/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json
COPY docker/10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json

WORKDIR /root/code

ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all

COPY docker/entry_point.sh /entry_point.sh
ENTRYPOINT ["/entry_point.sh"]

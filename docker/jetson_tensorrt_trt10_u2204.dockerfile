# Base image starts with CUDA
ARG BASE_IMG=nvcr.io/nvidia/l4t-cuda:12.2.12-devel
FROM ${BASE_IMG} AS base 
ARG BASE_IMG
ENV BASE_IMG=${BASE_IMG}

ENV DEBIAN_FRONTEND=noninteractive


RUN apt update && apt install -y \
    build-essential \
    manpages-dev \
    wget \
    zlib1g \
    software-properties-common \
    git \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    ca-certificates \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    mecab-ipadic-utf8 \
    libopencv-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    cmake \
    libassimp-dev


# cv-cuda
RUN cd /tmp && \
    wget https://github.com/CVCUDA/CV-CUDA/releases/download/v0.15.0/cvcuda-lib-0.15.0-cuda12-aarch64-linux.deb && \
    wget https://github.com/CVCUDA/CV-CUDA/releases/download/v0.15.0/cvcuda-dev-0.15.0-cuda12-aarch64-linux.deb &&\
    dpkg -i cvcuda-lib-0.15.0-cuda12-aarch64-linux.deb &&\
    dpkg -i cvcuda-dev-0.15.0-cuda12-aarch64-linux.deb &&\
    rm cvcuda-lib-0.15.0-cuda12-aarch64-linux.deb && \
    rm cvcuda-dev-0.15.0-cuda12-aarch64-linux.deb

# TensorRT
RUN cd /tmp && \
    wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/10.7.0/tars/TensorRT-10.7.0.23.l4t.aarch64-gnu.cuda-12.6.tar.gz && \
    wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/10.3.0/tars/TensorRT-10.3.0.26.Ubuntu-22.04.aarch64-gnu.cuda-12.5.tar.gz && \
    tar -xzvf TensorRT-10.3.0.26.Ubuntu-22.04.aarch64-gnu.cuda-12.5.tar.gz && \
    rm TensorRT-10.3.0.26.Ubuntu-22.04.aarch64-gnu.cuda-12.5.tar.gz && \
    mv TensorRT-10.3.0.26 /usr/src/tensorrt && \
    cp /usr/src/tensorrt/lib/*.so* /usr/lib/aarch64-linux-gnu/ && \
    cp /usr/src/tensorrt/include/* /usr/include/aarch64-linux-gnu/

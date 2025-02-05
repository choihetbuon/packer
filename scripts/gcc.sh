#!/bin/bash

# Install required dependencies
yum -y install wget make bzip2 gcc gcc-c++ gmp-devel mpfr-devel libmpc-devel

# Create a working directory
mkdir -p /opt/gcc-build
cd /opt/gcc-build

# Download and extract GCC 14.2.0
wget https://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.gz
tar xf gcc-14.2.0.tar.gz
cd gcc-14.2.0

# Configure and build GCC
./configure --prefix=/usr/local/gcc-14.2 \
    --enable-languages=c,c++ \
    --disable-multilib
make -j$(nproc)
make install

# Add new GCC to system PATH
echo 'export PATH=/usr/local/gcc-14.2/bin:$PATH' > /etc/profile.d/gcc-14.2.sh
echo 'export LD_LIBRARY_PATH=/usr/local/gcc-14.2/lib64:$LD_LIBRARY_PATH' >> /etc/profile.d/gcc-14.2.sh

# Source the new PATH
source /etc/profile.d/gcc-14.2.sh

# Verify installation
echo "GCC version:" && gcc --version | head -n 1
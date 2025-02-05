#!/bin/bash

# Update system and install dependencies
yum -y update
yum -y install openssl-devel bzip2-devel libffi-devel xz-devel wget gcc make

# Download Python 3.12
cd /tmp
wget https://www.python.org/ftp/python/3.12.1/Python-3.12.1.tgz
tar xzf Python-3.12.1.tgz
cd Python-3.12.1

# Configure and install Python
./configure --enable-optimizations --with-system-ffi
make -j $(nproc)
make altinstall

# Create symbolic links
ln -sf /usr/local/bin/python3.12 /usr/local/bin/python3
ln -sf /usr/local/bin/pip3.12 /usr/local/bin/pip3

# Verify installation
python3 --version
pip3 --version

# Clean up
cd /tmp
rm -rf Python-3.12.1*
#!/bin/bash

yum -y install centos-release-scl
yum -y install devtoolset-7
source /opt/rh/devtoolset-7/enable

echo "Make version:" && make --version | head -n 1
echo "CMake version:" && cmake --version | head -n 1
echo "GCC version:" && gcc --version | head -n 1
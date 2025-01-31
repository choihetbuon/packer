# Packer Build - CentOS 7 Vagrant Box

This repository contains a Packer template for building a CentOS 7 Vagrant box.

## Prerequisites

- [Packer](https://www.packer.io/downloads) (latest version)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url>
cd packer
```

2. Build the Vagrant box with Packer:
```bash
wget -O https://mirrors.cloud.tencent.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso
packer init .
packer build centos_7.json
``` 

3. Add the box to Vagrant:
```bash
vagrant box add centos7 output/centos7.box
```

4. Create a new Vagrant project:
```bash
vagrant init centos7
vagrant up
```

## Configuration

- The base image is CentOS 7 Minimal
- Default user: vagrant
- Default password: vagrant
- Root password: vagrant

## Contributing

Please feel free to submit issues and pull requests.

## License

MIT License
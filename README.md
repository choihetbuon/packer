# Packer build server templates 

## Plugin for Packer build and post-process in vagrant, vsphere, virtualbox

Install plugin if using virtualbox
```
packer plugins install github.com/hashicorp/virtualbox
```

Install plugin vsphere if using Esxi 
```
packer plugins install github.com/hashicorp/vsphere
```

<a href="https://developer.hashicorp.com/vagrant/docs/installation"> If using vagrant follow docs</a>

## Packer build image step

```
packer build <file name .json or hcl >
```
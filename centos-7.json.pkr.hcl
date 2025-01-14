packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "vagrant" "centos7" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "centos/7"
  vboxmanage   = [["modifyvm", "{{ .Name }}", "--firmware", "EFI"], ["modifyvm", "{{ .Name }}", "--cpus", "2"], ["modifyvm", "{{ .Name }}", "--memory", "4096"]]
}

build {
  sources = ["source.vagrant.centos7"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/setup.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    compression_level   = 9
    output              = "output/centos7.box"
  }
}

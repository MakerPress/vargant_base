# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  config.vm.forward_port 3000, 3000

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "development.pp"
    puppet.module_path = "puppet/modules"
#    puppet.options = "--fileserverconfig=/Users/odewahn/Desktop/vtest/puppet/fileserver.conf"
  end

end

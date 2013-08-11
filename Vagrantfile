# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd

Vagrant.configure("2") do |config|

  # Configurations from 1.0.x can be placed in Vagrant 1.1.x specs like the following.
  config.vm.provider :virtualbox do |v|
	v.customize ["modifyvm", :id, "--memory", 512]
  end
  
  # Make SSH key available to the box
  config.ssh.forward_agent = true

  # Default Ubuntu Box
  #
  # This box is provided by Vagrant at vagrantup.com and is a nicely sized (290MB)
  # box containing the Unbuntu 12.0.4 Precise 32 bit release.
  config.vm.box = "centos64"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-i386-v20130427.box"

  config.vm.hostname = "centos64"
  config.vm.network :private_network, ip: "192.168.50.64"
 
  # Customfile - POSSIBLY UNSTABLE
  #
  # Use this to insert your own (and possibly rewrite) Vagrant config lines. Helpful
  # for mapping additional drives. If a file 'Customfile' exists in the same directory
  # as this Vagrantfile, it will be evaluated as ruby inline as it loads. 
  # 
  # Note that if you find yourself using a Customfile for anything crazy or specifying 
  # different provisioning, then you may want to consider a new Vagrantfile entirely.
  if File.exists?('Customfile') then
    eval(IO.read('Customfile'), binding)
  end

  # provision.sh or provision-custom.sh
  #
  # By default, Vagrantfile is set to use the provision.sh bash script located in the
  # provision directory. If it is detected that a provision-custom.sh script has been
  # created, that is run as a replacement. This is an opportunity to replace the entirety
  # of the provisioning provided by default.
  if File.exists?('provision/provision-custom.sh') then
    config.vm.provision :shell, :path => File.join( "provision", "provision-custom.sh" )
  else
    config.vm.provision :shell, :path => File.join( "provision", "provision.sh" )
  end
end
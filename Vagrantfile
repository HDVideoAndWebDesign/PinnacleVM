# -*- mode: ruby -*-
# vi: set ft=ruby :


######################### 
DBPASS = "123456789"
DBUSER = "NODEGUY"


Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  
  ######################## LOCAL NETWORKING ###########################
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  ######################## EXTERNAL NETWORKING ###########################

  # https://docs.vagrantup.com/v2/push/atlas.html for more information.  # <-- DOCS

  # PRODUCTION DIGITAL OCEAN config use SFTP
  # config.push.define "production" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
  
  # STAGING  DIGITAL OCEAN config use SFTP
  # config.push.define "staging" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Shell provisioning setup
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y nginx > /dev/null
    apt-get install -y build-essential openssl libssl-dev pkg-config > /dev/null
    
    debconf-set-selections <<< "mysql-server mysql-server/root_password password #{$DBPASS}"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password #{$DBPASS}"
    
    apt-get install mysql-server > /dev/null
  SHELL
end

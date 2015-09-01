# -*- mode: ruby -*-
# vi: set ft=ruby :


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
    export DEBIAN_FRONTEND=noninteractive
    debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password password secretpw'
    debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password_again password secretpw'
    
    # mongoDB stuff
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
    # nodeJS stuff
    apt-get install -y -q curl
    curl -sL https://deb.nodesource.com/setup | sudo bash -
    
    apt-get update > /dev/null
    apt-get upgrade > /dev/null
    apt-get install -y -q build-essential openssl libssl-dev pkg-config
    
    # add security config for mongo
    apt-get install -y -q mongodb-org
    apt-get install -y -q nginx
    apt-get install -y -q nodejs
    
    # run this last it breaks stuff apparently
    apt-get install -y -q mysql-server mysql-client
    
  SHELL
end

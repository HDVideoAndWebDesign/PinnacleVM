# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  ######################## LOCAL NETWORKING ###########################
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network", ip: "192.168.1.88"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../../projects/pinnacle", "/srv/sites/pinnacle"

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

  ######################## Shell Setup Script ########################
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    ############################
    ######### APT KEYS #########
    ############################

    #### mongoDB ####
    # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    # echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

    #### rethinkDB ####
    source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

    ##### nodeJS ####
    apt-get install -y -q curl
    curl -sL https://deb.nodesource.com/setup | sudo bash -

    #################################
    ######### INSTALL STUFF #########
    #################################

    apt-get update > /dev/null
    apt-get upgrade > /dev/null
    apt-get install -y -q build-essential openssl \
                          libssl-dev pkg-config \
                          git apache2-utils

    #### dev setup ####
    apt-get remove -y vim  # get rid of vim-tiny
    apt-get install -y -q ctags vim
    git clone https://github.com/amix/vimrc.git /home/vagrant/.vim_runtime
    sh /home/vagrant/.vim_runtime/install_awesome_vimrc.sh # may not work
    sed -i -e 's/#force_color/force_color/g' /home/vagrant/.bashrc

    #### nginx ####
    apt-get install -y -q nginx
    ## config nginx ##
    mkdir -p /srv/sites/test/
    chown -R vagrant:www-data /srv/sites
    adduser vagrant www-data
    rm /etc/nginx/sites-enabled/default
    ln -s /vagrant/pinnacle.conf /etc/nginx/sites-enabled/pinnacle
    service nginx restart

    #### nodejs ####
    apt-get install -y -q nodejs

    #### rethinkdb ####
    apt-get install -y -q rethinkdb
    ## config rethinkdb ##
    cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
    sed -i -e 's/# bind=127\.0\.0\.1/bind=all/g' /etc/rethinkdb/instances.d/instance1.conf
    service rethinkdb restart

    #### mongodb ####
    # apt-get install -y -q mongodb-org
    ## config mongo ##

    #### mysql ####
    ## setup ##
    # debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password password secretpw'
    # debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password_again password secretpw'

    # run this last it breaks stuff apparently
    # apt-get install -y -q mysql-server mysql-client
    ## config mysql ##
    # make mysql stop squawking about key_buffer deprecation
    # sed -i -e 's/key_buffer/key_buffer_size/g' /etc/mysql/my.cnf
  SHELL
end

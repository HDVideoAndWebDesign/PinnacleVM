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
# nvm
# curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash

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
git clone https://github.com/HDVideoAndWebDesign/PinnacleProspects.git /srv/sites/pinnacle
rm /etc/nginx/sites-enabled/default
ln -s /vagrant/pinnacle.conf /etc/nginx/sites-enabled/pinnacle
service nginx restart

#### nodejs ####
apt-get install -y -q nodejs

#### rethinkdb ####
apt-get install -y -q rethinkdb
## config rethinkdb ##
cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
# WARNING This is not safe for production!!!
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

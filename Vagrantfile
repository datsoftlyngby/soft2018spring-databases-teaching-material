# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network "forwarded_port", guest: 80, host: 8080
  #config.vm.network "forwarded_port", guest: 8080, host: 8080
  # mongodb port
  #config.vm.network "forwarded_port", guest: 27017, host: 27017

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # for neo4j DB server
  config.vm.network "forwarded_port", guest: 7474, host: 7474
  config.vm.network "forwarded_port", guest: 7687, host: 7687
  # for mongoDB server
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  # config.vm.network "forwarded_port", guest: 27018, host: 27018
  # config.vm.network "forwarded_port", guest: 27019, host: 27019
  config.vm.network "forwarded_port", guest: 28017, host: 28017
  # for MySQL DB server
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # For Python serving examples
  config.vm.network "forwarded_port", guest: 8001, host: 8001

  # config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../", "/synced_folder"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.cpus = "2"
    vb.name = "dbdev_oi"
  end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update

    sudo echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/environment
    sudo locale-gen UTF-8

    echo "Installing Java"

    sudo apt-get -y install software-properties-common
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get -y update
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    sudo apt-get -y install oracle-java8-installer
    sudo update-java-alternatives -s java-8-oracle

    sudo apt-get install -y git
    sudo apt-get install -y wget

    echo "Installing MongoDB"
    sudo apt-get -y install mongodb-server

    echo "Installing Neo4J"
    wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
    echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
    sudo apt-get update

    sudo apt-get install -y neo4j

    # Permission denied...
    # Do I have to add root to neo4j group?
    sudo chmod a+w /etc/neo4j/neo4j.conf
    echo "\n# Automatically added by Vagrant provision script." >> /etc/neo4j/neo4j.conf
    echo "dbms.connectors.default_listen_address=0.0.0.0" >> /etc/neo4j/neo4j.conf
    echo "dbms.memory.heap.initial_size=1024m" >> /etc/neo4j/neo4j.conf
    echo "dbms.memory.heap.max_size=1792m" >> /etc/neo4j/neo4j.conf
    echo "browser.remote_content_hostname_whitelist=*" >> /etc/neo4j/neo4j.conf

    sudo chmod a+rw -R /var/log/neo4j
    sudo chmod a+rw -R /var/lib/neo4j

    sudo neo4j restart

    sudo /usr/bin/neo4j-admin set-initial-password class

    sudo mkdir /usr/share/neo4j/import
    wget https://github.com/HelgeCPH/db_course_nosql/raw/master/social_network/archive_graph.tar.gz
    tar -xzvf archive_graph.tar.gz
    sudo mv ./social_network_nodes.csv /var/lib/neo4j/import
    sudo mv ./social_network_edges.csv /var/lib/neo4j/import
    # I do not know why I moved earlier to /usr/share/neo4j/import/
    rm ./archive_graph.tar.gz

    sudo mkdir -p /data/db
    # TODO:
    # /etc/mongodb.conf modify bind_ip line to 0.0.0.0 and restart server
    sudo sed -i '/bind_ip = / s/127.0.0.1/0.0.0.0/' /etc/mongodb.conf
    # sudo systemctl restart mongod
    sudo service mongodb restart
    # sudo mongod


    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pwd'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pwd'
    sudo apt-get update
    sudo apt-get install -y mysql-server mysql-client

    sudo chmod a+w /etc/mysql/mysql.cnf
    sudo echo "skip-external-locking" >> /etc/mysql/mysql.cnf
    sudo echo "bind-address=0.0.0.0" >> /etc/mysql/mysql.cnf
    sudo /etc/init.d/mysql restart

    mysql -u root -ppwd -e "create user 'root'@'10.0.2.2' identified by 'pwd'; grant all privileges on *.* to 'root'@'10.0.2.2' with grant option; flush privileges;"
    sudo /etc/init.d/mysql restart

    # sudo service mysql restart
    # sudo /etc/init.d/mysql restart

    cd /synced_folder/playbooks/
    python3 serve_playbooks.py &
  SHELL
end

# Installation of Neo4J based on
# http://debian.neo4j.org/?_ga=1.80727511.1564702383.1486383801
# Something on MongoDB (service restart)
# https://www.linode.com/docs/databases/mongodb/install-mongodb-on-ubuntu-16-04

# https://raw.githubusercontent.com/neo4j-contrib/training/master/modeling/data/flights_initial.csv


# Installation of MySQL in VM with the help of:
# http://stackoverflow.com/questions/10709334/how-to-connect-to-mysql-server-inside-virtualbox-vagrant#10794530
# http://serverfault.com/questions/486710/access-to-mysql-server-via-virtualbox/486716#486716
#

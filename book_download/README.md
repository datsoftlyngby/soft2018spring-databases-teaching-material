# How to get all English books from Project Gutenberg?

The `download_books.sh` script is an adapted version from:
https://www.exratione.com/2014/11/how-to-politely-download-all-english-language-text-format-files-from-project-gutenberg/

In case you want to download all books in English and in `.txt` format from project Gutenberg you can make use of this Bash script. Alternatively, you can perform the steps defined in it with an alternative technology.


However, this guide automates the entire download process -including setup of the cloud server- with the help of Vagrant, you have to install Vagrant to your machine, see https://www.vagrantup.com/intro/getting-started/install.html


## Setup of Vagrant and DigitalOcean Credentials


For this example we rent the second cheapest possible cloud machine at DigitalOcean -which they call "droplet". The following descriptions and the provided scripts should be working on any Unix/Linux environment.

However, you have to first create an account at DigitalOcean https://www.digitalocean.com.

Additionally, you have to register your public SSH key at DigitalOcean. If you do not have a pair of keys read on how to do that. (https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets)

Furthermore, you have to create a Personal Access Token, see the first part of https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2.

Set the name of the ssh key and the personal access token as environment variables. For example in Unix/Linux environments do

```bash
export DIGITAL_OCEAN_TOKEN="your_access_token_comes_here"
export SSH_KEY_NAME="your_key_name"
```

on Windows this would more look like

```bash
set DIGITAL_OCEAN_TOKEN="your_access_token_comes_here"
set SSH_KEY_NAME="your_key_name"
```

The Vagrantfile requires those two environment variables and will not work correctly if they are not defined.


The Vagrantfile given in this directory runs with the DigitalOcean provisioner. That is, it creates a droplet at Digital Ocean, on which the `download_books.sh` script will download all the books as zipped text files. After all books are downloaded the script creates a `.tar` archive, which you can copy to your local machine via secure copy `scp` (copy over an SSH connection). To make use of the latter, you have to install the Vagrant `scp` plugin via:

```bash
vagrant plugin install vagrant-scp
```

See https://github.com/invernizzi/vagrant-scp for more details on how to secure copy (`scp`) files from and to a Vagrant VM.


To really execute the Vagrantfile and automatically instantiate a remote droplet you have to first install the DigitalOcean plugin for Vagrant

```bash
vagrant plugin install vagrant-digitalocean
```

Find more information on it here: https://www.digitalocean.com/community/tutorials/how-to-use-digitalocean-as-your-provider-in-vagrant-on-an-ubuntu-12-10-vps.


Now, that everything is installed and setup. You can execute the provisioner script via:

```bash
vagrant up --provider=digital_ocean
```

This will create a remote machine, which will take some seconds and will create output similar to the following:


```bash
$ vagrant up --provider=digital_ocean
Bringing machine 'bookdownloaddroplet' up with 'digital_ocean' provider...
==> bookdownloaddroplet: Using existing SSH key: key_name
==> bookdownloaddroplet: Creating a new droplet...
==> bookdownloaddroplet: Assigned IP address: ip
==> bookdownloaddroplet: Rsyncing folder: /.../your_folder/book_download/ => /vagrant
==> bookdownloaddroplet: Running provisioner: shell...
==> bookdownloaddroplet: mesg:
==> bookdownloaddroplet: ttyname failed
==> bookdownloaddroplet: :
==> bookdownloaddroplet: Inappropriate ioctl for device
==> bookdownloaddroplet: Hit:1 http://mirrors.digitalocean.com/ubuntu xenial InRelease
==> bookdownloaddroplet: Get:2 http://mirrors.digitalocean.com/ubuntu xenial-updates InRelease [102 kB]
==> bookdownloaddroplet: Get:3 http://mirrors.digitalocean.com/ubuntu xenial-backports InRelease [102 kB]
==> bookdownloaddroplet: Get:4 http://mirrors.digitalocean.com/ubuntu xenial/main Sources [868 kB]
==> bookdownloaddroplet: Get:5 http://security.ubuntu.com/ubuntu xenial-security InRelease [102 kB]
==> bookdownloaddroplet: Get:6 http://mirrors.digitalocean.com/ubuntu xenial/restricted Sources [4,808 B]
==> bookdownloaddroplet: Get:7 http://mirrors.digitalocean.com/ubuntu xenial/universe Sources [7,728 kB]
==> bookdownloaddroplet: Get:8 http://security.ubuntu.com/ubuntu xenial-security/main Sources [67.2 kB]
==> bookdownloaddroplet: Get:9 http://security.ubuntu.com/ubuntu xenial-security/restricted Sources [2,600 B]
==> bookdownloaddroplet: Get:10 http://security.ubuntu.com/ubuntu xenial-security/universe Sources [26.5 kB]
==> bookdownloaddroplet: Get:11 http://security.ubuntu.com/ubuntu xenial-security/multiverse Sources [1,144 B]
==> bookdownloaddroplet: Get:12 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages [243 kB]
==> bookdownloaddroplet: Get:13 http://security.ubuntu.com/ubuntu xenial-security/main Translation-en [103 kB]
==> bookdownloaddroplet: Get:14 http://security.ubuntu.com/ubuntu xenial-security/universe amd64 Packages [108 kB]
==> bookdownloaddroplet: Get:15 http://security.ubuntu.com/ubuntu xenial-security/universe Translation-en [55.2 kB]
==> bookdownloaddroplet: Get:16 http://mirrors.digitalocean.com/ubuntu xenial/multiverse Sources [179 kB]
==> bookdownloaddroplet: Get:17 http://mirrors.digitalocean.com/ubuntu xenial-updates/main Sources [240 kB]
==> bookdownloaddroplet: Get:18 http://mirrors.digitalocean.com/ubuntu xenial-updates/restricted Sources [2,996 B]
==> bookdownloaddroplet: Get:19 http://mirrors.digitalocean.com/ubuntu xenial-updates/universe Sources [149 kB]
==> bookdownloaddroplet: Get:20 http://mirrors.digitalocean.com/ubuntu xenial-updates/multiverse Sources [5,268 B]
==> bookdownloaddroplet: Get:21 http://mirrors.digitalocean.com/ubuntu xenial-updates/main amd64 Packages [509 kB]
==> bookdownloaddroplet: Get:22 http://mirrors.digitalocean.com/ubuntu xenial-updates/main Translation-en [205 kB]
==> bookdownloaddroplet: Get:23 http://mirrors.digitalocean.com/ubuntu xenial-updates/universe amd64 Packages [453 kB]
==> bookdownloaddroplet: Get:24 http://mirrors.digitalocean.com/ubuntu xenial-updates/universe Translation-en [173 kB]
==> bookdownloaddroplet: Get:25 http://mirrors.digitalocean.com/ubuntu xenial-updates/multiverse amd64 Packages [8,920 B]
==> bookdownloaddroplet: Get:26 http://mirrors.digitalocean.com/ubuntu xenial-updates/multiverse Translation-en [4,136 B]
==> bookdownloaddroplet: Get:27 http://mirrors.digitalocean.com/ubuntu xenial-backports/main Sources [3,304 B]
==> bookdownloaddroplet: Get:28 http://mirrors.digitalocean.com/ubuntu xenial-backports/universe Sources [1,868 B]
==> bookdownloaddroplet: Get:29 http://mirrors.digitalocean.com/ubuntu xenial-backports/main amd64 Packages [4,684 B]
==> bookdownloaddroplet: Get:30 http://mirrors.digitalocean.com/ubuntu xenial-backports/main Translation-en [3,216 B]
==> bookdownloaddroplet: Get:31 http://mirrors.digitalocean.com/ubuntu xenial-backports/universe amd64 Packages [2,512 B]
==> bookdownloaddroplet: Get:32 http://mirrors.digitalocean.com/ubuntu xenial-backports/universe Translation-en [1,216 B]
==> bookdownloaddroplet: Fetched 11.5 MB in 44s (258 kB/s)
==> bookdownloaddroplet: Reading package lists...
==> bookdownloaddroplet: vagrant ssh
==> bookdownloaddroplet: nohup ./download.sh > /tmp/out.log 2>&1 &
```

## Downloading all English books in `.txt` format

Subsequently, you can SSH to your new remote machine and start downloading the books:

```bash
$ vagrant ssh
vagrant@bookdownloaddroplet$ nohup ./download.sh > /tmp/out.log 2>&1 &
```

The process of downloading all books will take you a bit more than a day. Recently, when I downloaded the books, the above script harvested 37198 links, downloaded 37195 books and the final zipped archive is ca. 5.1GB large.


Copy the final zipped archive to your local machine:

```bash
$ vagrant scp bookdownloaddroplet:/root/archive.tar ~/Downloads/
```

You might want to keep the file containing the links to the files, which you actually downloaded.

```bash
$ vagrant scp bookdownloaddroplet:/root/zipfileLinks.txt ~/Downloads/
```


## Destroying the Droplet

DigitalOcean droplets are payed per hour. That is, when you are done downloading all books and after your copied the archive with it back to your local machine, you can destroy the remote machine with

```bash
$ vagrant destroy
```

*OBS* you pay as long as your remote machine is up and running.

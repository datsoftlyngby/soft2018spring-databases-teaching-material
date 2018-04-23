#!/bin/bash
sudo apt-get update

# wget https://raw.githubusercontent.com/HelgeCPH/db_course_nosql/master/book_download/download.sh

cp /vagrant/download.sh ./
chmod u+x ./download.sh

echo "vagrant ssh"
echo "nohup ./download.sh > /tmp/out.log 2>&1 &"

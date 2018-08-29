#/bin/bash
# Create development enviroment for devs
# Author: Julio Melo

echo "Please type node version, followed by [ENTER]:"
read NODE_VERSION

apt update -y

echo "Installing dev requirements"
apt install git-core build-essentials -y

echo "Installing node $NODE_VERSION..."
wget -c https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION.tar.gz

tar -zxvf node-$NODE_VERSION.tar.gz
cd node-$NODE_VERSION
./configure && make j4
make install
npm install -g yarn
cd ..

echo "Installing docker and docker-compose...;"
apt install -y docker.io docker-compose
usermod -a -G docker $USER

#python-dev
#zsh

echo "Removing artifacts"
rm node-$NODE_VERSION.tar.gz
rm -rf node-$NODE_VERSION

echo "Installing terminator"
add-apt-repository ppa:gnome-terminator
apt install terminator -y

wget -c https://download.virtualbox.org/virtualbox/5.2.18/virtualbox-5.2_5.2.18-124319~Ubuntu~bionic_amd64.deb
dpkg -i virtualbox-5.2_5.2.18-124319~Ubuntu~bionic_amd64.deb
apt install -f install

echo "Done, you MUST restart your PC"

exit 0

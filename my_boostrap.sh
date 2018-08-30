#/bin/bash
# Create development enviroment for devs
# Author: Julio Melo

echo "Please type node version, followed by [ENTER]:"
read NODE_VERSION

echo "Please type vagrant version, followed by [ENTER]:"
read VAGRANT_VERSION

echo "Please type golang version: , followed by [ENTER]:"
read GO_VERSION

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
rm  virtualbox-5.2_5.2.18-124319~Ubuntu~bionic_amd64.deb
apt install -f install

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list 

echo "Installing kubectl"

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

wget -c https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb
dpkg -i vagrant_2.1.2_x86_64.deb
rm vagrant_2.1.2_x86_64.deb
echo "Installing GO"
wget -c https://dl.google.com/go/${GO_VERSION}
tar -C /usr/local -zxvf ${GO_VERSION}

export PATH=$PATH:/usr/local/go/bin
echo "Installing zsh and oh-my-zsh"
apt install zsh
echo "Done, you MUST restart your PC"

echo "Do you want to restart your PC? [Y/N]:"
read RESTART_ANSWER

if [ RESTART_ANSWER -eq "Y" ]
then
	shutdown -r now
fi

exit 0

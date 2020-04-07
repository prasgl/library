## steps for initializing dev env on an ubuntu container.

## installations
apt-get update
if [ $? != 0 ]; then
  echo 'apt-get update failed'
fi

#### node js & npm
node -v
if  [ $? != 0 ]; then
  echo 'installing node js'
  apt install nodejs
  echo 'installing npm'
  apt install npm
else
  echo 'node already installed'
fi

#### git
git --version
if [ $? != 0 ]; then
  echo 'installing git'
  apt install git-all
else
  echo 'git already available'
fi

#### install mysql
#### provide the inputs for mysql installation, so we can 
#### invoke it in non-interactive mode

mysql --version
if [ $? != 0 ]; then 
  echo 'installing mysql'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
  apt-get -y install mysql-server
else
  echo 'mysql already available'
fi

## Create directory structure
echo 'software setup complete, creating directory structure'
mkdir ~/library
cd ~/library

## pull the source code from github
echo 'getting source code from github'
git clone https://github.com/prasgl/library.git .

#### install mysql node driver
npm i mysql
if [ $? == 0 ]; then
  echo 'installed mysql driver'
fi 


## Start mysql and insert data, the command is "mysql -u root -p", which 
## prompts for password.
mysql -u root -proot < ./db_initial.sql

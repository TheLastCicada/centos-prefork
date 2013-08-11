start_time=`date`
# This file is specified as the provisioning script to be used during `vagrant up`
# via the `config.vm.provision` parameter in the Vagrantfile.

# Add remi and epel repos
if [ -f /etc/yum.repos.d/epel.repo ]
	then
		echo "epel repo already installed - skipping"
	else 
        wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
        rpm -Uvh epel-release-6*.rpm
        rm epel-release-6*.rpm*
fi
if [ -f /etc/yum.repos.d/remi.repo ]
	then
		echo "remi repo already installed - skipping"
	else 
		wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
		rpm -Uvh remi-release-6*.rpm
		rm remi-release-6*.rpm*
fi

#yum install -y httpd mysql-server php php-soap php-pear php-gd php-mbstring php-mcrypt php-mysql php-pecl-apc php-pecl-memcache php-xml vim-enhanced git
yum install -y httpd mysql-server httpd-devel patch libpng-devel apr-devel libxml2-devel zlib zlib-devel libmcrypt-devel mysql-devel openssl-devel vim-enhanced git libevent2 libevent-devel autoconf nano

service mysqld start
/usr/bin/mysqladmin -u root password 'blank'

if [ -f /usr/local/bin/php ]
then
	echo "PHP already installed, skipping compiling"
else
	mkdir prefork
	git clone https://github.com/Automattic/prefork.git ./prefork

	mkdir /etc/php.d
	wget http://us.php.net/get/php-5.4.17.tar.gz/from/us3.php.net/mirror
	tar -zxvf php-*.tar.gz
	cd php-5.4.17
	patch  -p 1 -i ../prefork/php_cli.c.diff
	./configure --with-config-file-path=/etc --with-config-file-scan-dir=/etc/php.d --with-apxs2 --with-libdir=lib64 --enable-mbstring --with-openssl --with-soap --with-mcrypt --with-gd --with-libevent --with-memcached --enable-sockets --with-pear --with-mysql --with-mysqli --with-xml --with-zlib
	make clean
	make
	make install
	/home/vagrant/php-5.4.17/libtool --finish /home/vagrant/php-5.4.17/libs
	cp /home/vagrant/php-5.4.17/php.ini-production /etc/php.ini
	printf "\n" | /usr/local/bin/pecl install libevent-beta
	echo "extension=libevent.so" >> /etc/php.ini
	cp /vagrant/php.conf /etc/httpd/conf.d/php.conf
fi

service iptables stop

# Get WordPress
wpclone=/usr/local/src/wordpress
if [ ! -d ${wpclone} ]
then
	printf "\nDownloading WordPress from git.....https://github.com/WordPress/WordPress.git\n"
	mkdir -p /usr/local/src/
	git clone https://github.com/WordPress/WordPress.git ${wpclone}
else
	printf "\nUpdating WordPress.....\n"
	cd ${wpclone}
	git pull
fi

version=html
site_name=${version}
location=/var/www/${site_name}
index_location=${location}/index.php
config_location=${location}/wp-config.php

printf "\nBuilding ${site_name}.dev\n"
if [ ! -f ${index_location} ]
then
	printf " * Copying WordPress files for ${site_name}.dev\n"
	cp -rp ${wpclone} ${location}
	if [ ! -f ${index_location} ]
	then
		printf "   ...Failed to copy WordPress ${site}.dev files\n"
	else
		printf "   ...${site_name}.dev files copied\n"
		#Create WordPress database
		mysql -u root -pblank -e 'create database prefork'
		mysql -u root -pblank -e "create user 'wp'@'localhost' identified by 'wp'"
		mysql -u root -pblank -e "grant all on prefork.* to 'wp'@'localhost'"
	fi
else
	printf " * Skip setting up files at ${location}, already setup\n"
	printf " * Pulling latest core changes to ${location}\n"
	cd ${location}
	git pull
fi

ln -sf /vagrant/config/wp-config.php ${config_location} | echo " * /vagrant/config/wp-config.php -> /var/www/html/wp-config.php"

echo "<?php phpinfo(); ?>" > /var/www/html/info.php

service httpd restart
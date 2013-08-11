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

yum install -y httpd mysql-server php php-soap php-pear php-gd php-mbstring php-mcrypt php-mysql php-pecl-apc php-pecl-memcache php-xml vim-enhanced git

# Composer
if composer --version | grep -q 'Composer version';
then
	printf "Updating Composer...\n"
	composer self-update
else
	printf "Installing Composer...\n"
	curl -sS https://getcomposer.org/installer | php
	chmod +x composer.phar
	mv composer.phar /usr/local/bin/composer
fi

# WP-CLI Install
if [ ! -d /usr/local/wp-cli ]
then
	printf "\nDownloading wp-cli.....http://wp-cli.org\n"
	git clone git://github.com/wp-cli/wp-cli.git /usr/local/wp-cli
	cd /usr/local/wp-cli
	composer install
else
	printf "\nUpdating wp-cli....\n"
	cd /usr/local/wp-cli
	git pull --rebase origin master
	composer update
fi

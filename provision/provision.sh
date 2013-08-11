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

# Get WordPress
wpclone=/usr/local/src/wordpress
if [ ! -d ${wpclone} ]
then
	printf "\nDownloading WordPress from git.....https://github.com/WordPress/WordPress.git\n"
	git clone https://github.com/WordPress/WordPress.git ${wpclone}
else
	printf "\nUpdating WordPress.....\n"
	cd ${wpclone}
	git pull
fi

version=trunk
site_name=${version}
location=/var/www/${site_name}
index_location=${location}/index.php
config_location=${location}/wp-config.php

printf "\nBuilding ${site_name}.dev\n"
if [ ! -f ${index_location} ]
then
	printf " * Copying WordPress files for ${site_name}.dev\n"
	cp -r ${wpclone} ${location}/
	if [ ! -f ${index_location} ]
	then
		printf "   ...Failed to copy WordPress ${site}.dev files\n"
	else
		printf "   ...${site_name}.dev files copied\n"
	fi
else
	printf " * Skip setting up files at ${location}, already setup\n"
	printf " * Pulling latest core changes to ${location}\n"
	cd ${location}
	git pull
fi

#if [ ! -f ${config_location} ]
#then
#	printf " * Writing ${config_location}"
#	cd ${location}
#	wp core config --dbname=${site_name} --dbuser=wp --dbpass=wp --quiet
#	wp core install --url=${site_name}.dev --quiet --title="${site_name} Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
#	if [ ! -f ${config_location} ]
#	then
#		printf "   ...Failed to write ${config_location}"
#	else
#		printf "   ...${config_location} written"
#	fi
#else
#	printf " * Skip writing ${config_location}, already written"
#fi

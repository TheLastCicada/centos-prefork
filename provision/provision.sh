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

yum install -y httpd mysql-server php php-soap php-pear php-gd php-mbstring php-mcrypt php-mysql php-pecl-apc php-pecl-memcache php-xml vim-enhanced



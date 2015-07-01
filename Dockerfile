FROM vikas027/centos-7.1

MAINTAINER Vikas Kumar "vikas@reachvikas.com"

# Set timezone
RUN rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/UTC /etc/localtime

# Additional Repos
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm \
    http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    yum-utils wget && \
    yum-config-manager --enable remi,remi-php56,remi-php56-debuginfo && \
    wget http://download.opensuse.org/repositories/isv:/ownCloud:/community/CentOS_CentOS-7/isv:ownCloud:community.repo -P /etc/yum.repos.d
ADD mariadb.repo /etc/yum.repos.d/mariadb.repo

# Installation
RUN yum remove mariadb-libs -y && \
    yum install owncloud php-mysql \
    MariaDB-server MariaDB-client hostname sysvinit-tools postfix -y

# Supervisord
RUN yum -y install python-pip && \
    pip install --upgrade 'pip >= 1.4, < 1.5' && \
    pip install --upgrade supervisor supervisor-stdout && \
    mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/

# Clean up, reduces container size
RUN rm -rf /var/cache/yum/* && yum clean all

# Apache start up script
ADD start-httpd.sh /start-httpd.sh
RUN chmod +x start-httpd.sh -v

# How to configure OwnCloud and MariaDB
ADD README.txt /README.txt

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]

####### Run the container
http://IP or hostname/owncloud and create owncloud administrator account


####### Convert SQLite to MySQLDB (or MariaDB)
cat > /root/owncloud.sql << 'EOF'
DROP DATABASE IF EXISTS oc_db;
CREATE DATABASE oc_db;
CREATE USER 'oc_db_admin'@'127.0.0.1';
GRANT ALL ON oc_db.* TO 'oc_db_admin'@'127.0.0.1' IDENTIFIED BY 'oc_db_admin27';
flush privileges;
EOF

mysql -u root < /root/owncloud.sql
yum install sudo -y
cd /var/www/html/owncloud/
sudo -u apache php occ db:convert-type --all-apps --port="3306" --password="oc_db_admin27" mysql oc_db_admin 127.0.0.1 oc_db

Now, exit and restart the container


###### Enable External Store
cd /var/www/html/owncloud/
sudo -u apache php occ app:enable files_external

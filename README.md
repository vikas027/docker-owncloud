# Docker Container for OwnCloud v8
The docker container is based on CentOS 7.1 (Build 1503). OwnCloud v8.0.4 and MariaDB v10.0.20 have been installed and configured to run properly in the container.

More details are available on [Docker Hub Registry - OwnCloud](https://registry.hub.docker.com/u/vikas027/owncloud8-mariadb10-centos7/).

### Docker Installation
Install [Docker](https://docs.docker.com/installation/) on your favourite distro and run the container

### Run Container
Run the below commands to run the container
```bash
docker pull vikas027/owncloud8-mariadb10-centos7
docker run --name <any_name> -d -p <host_http_port>:80 -p <host_https_port>:443
```
Browse to http://IP/owncloud and create an account for administering OwnCloud

### Tweaks
Database of OwnCloud must be changed to MariaDB or MySQL in production or non-test environments.
See [README](README.txt) to convert the default database to MariaDB and enable external storage (S3, FTP, sFTP, etc). 

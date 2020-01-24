
echo "zdorova"
sudo apt-get update
sudo apt-get -y install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo gpasswd -a $USER docker
docker stop $( docker ps -a )
docker rm $( docker ps -a )
echo "2"
docker run --name=mysql-serv -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -d    mysql/mysql-server:5.7
sleep 5s
echo "3"
docker exec  -tt mysql-serv bash -c "echo '
# For advice on how to change settings please seev
# http://dev.mysql.com/doc/refman/5.7/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
secure-file-priv=/var/lib/mysql-files
user=mysql
character-set-server=utf8
collation-server=utf8_bin
default-storage-engine=INNODB
max_allowed_packet=256M
innodb_log_file_size=1GB
transaction-isolation=READ-COMMITTED
binlog_format=row
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid' > /etc/my.cnf"
echo "Hellllllllllo1"
docker exec -tt mysql-serv  mysql -uroot -padmin <<< "CREATE DATABASE cfdb CHARACTER SET utf8 COLLATE utf8_bin;"
echo "Hellllllllllo2"


docker exec -tt mysql-serv  mysql -uroot -padmin <<< "CREATE USER 'yurauser'@'localhost' IDENTIFIED BY 'admin';"
echo "Hellllllllllo3"

docker exec -tt mysql-serv  mysql -uroot -padmin <<< "GRANT ALL PRIVILIGIES ON cfdb.* TO 'yurauser'@'localhost';


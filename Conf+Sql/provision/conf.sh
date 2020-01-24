sudo su
wget anamericanwebdeveloper.com/cf/cf.bin
chmod a+x cf.bin
(echo o; echo 2; echo ''; echo ''; echo 1; echo y; echo n) | ./cf.bin
cd /opt/atlassian/confluence/confluence/WEB-INF/lib
wget anamericanwebdeveloper.com/cf/mysql-connector-java-5.1.48-bin.jar
wget anamericanwebdeveloper.com/cf/mysql-connector-java-5.1.48.jar
cat /home/vagrant/shared_folder/server.xml  > /opt/atlassian/confluence/conf/server.xml 
service restart confluence
su vagrant


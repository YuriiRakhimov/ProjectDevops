     sudo su
     cd /etc/yum.repos.d
     echo '[nginx]' >> nginx.repo
     echo 'name=nginx repo' >> nginx.repo
     echo 'baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/' >> nginx.repo
     echo 'gpgcheck=0' >> nginx.repo
     echo 'enabled=1' >> nginx.repo
     yum -y update
     yum -y install epel-release
     yum -y install nginx
     openssl req -x509 -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key   -newkey rsa:2048 -nodes -sha256   -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
     cat /home/vagrant/shared_folder/default.conf > /etc/nginx/conf.d/default.conf
     systemctl start nginx
     systemctl enable nginx
     systemctl status nginx
     su vagrant
      

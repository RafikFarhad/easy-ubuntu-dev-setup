#!/bin/bash

echo "Welcome to Easy LEMP Stack Setup 4.0"
echo -e "Created By SUST CSE Developer Network (SCDN)\n"
echo -e "Maintained By RafikFarhad<rafikfarhad@gmail.com>\n"

echo "Steap:1 [System Update]"
echo "Update Starts....."
sudo apt update
echo -e "System Update Completed Successfully\n"

echo "Step:2 [Install NGINX]"
sudo apt install -y nginx
echo -e "NGINX Installation Completed Successfully\n"

echo "Step:3 [Install MySQL]"
sudo apt install -y mysql-server mysql-client libmysqlclient-dev
echo -e "MySQL Installation Completed Successfully\n"

echo "Step:4 [Install PHP7.3]"
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y 
sudo apt -y update
sudo apt install -y php7.3
# sudo apt-cache search php7.3
sudo apt-get install -y php-redis php7.3-cli php7.3-fpm php7.3-mysql \
            php7.3-curl php7.3-json php7.3-cgi libphp7.3-embed \
            php7.3-zip php7.3-mbstring php7.3-xml php7.3-intl

echo -e "PHP7.3 Installation Completed Successfully\n"

sudo systemctl start php7.3-fpm
sudo systemctl enable php7.3-fpm

echo -e "Step:5 [Install PHPmyadmin]"
wget https://files.phpmyadmin.net/phpMyAdmin/4.7.9/phpMyAdmin-4.7.9-all-languages.zip -O ./phpmyadmin.zip
unzip phpmyadmin.zip -d /home/$USER
sudo mv /home/$USER/phpMyAdmin-4.7.9-all-languages /usr/share/phpmyadmin
sudo chown -R www-data:www-data /usr/share/phpmyadmin
sudo chmod -R 755 /usr/share/phpmyadmin
echo -e "PHPmyadmin Installation Completed Successfully\n"

echo -e "Remove the default symlink in sites-enabled directory"
sudo rm /etc/nginx/sites-enabled/default

echo -e "Writing Default Nginx Config"

sudo cat > /etc/nginx/sites-enabled/default.conf <<EOF
server {

  server_name _;
  listen 80;

  #charset koi8-r;
  access_log /var/log/nginx/host.access.log main;


  root /var/www/html;
  index index.php index.html;

  location / {

    try_files \$uri \$uri/ /index.php?\$query_string;
  }

  # error_page  404              /404.html;

  # redirect server error pages to the static page /50x.html
  error_page 500 502 503 504 /50x.html;
  location = /50x.html {

    root /usr/share/nginx/html;
  }

  location ~ \.php\$ {

    fastcgi_pass unix:/run/php/php7.3-fpm.sock;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
  }

  # deny access to .htaccess files, if Apache's document root concurs with nginx's one

  location ~ /\.ht {

    deny all;
  }

  location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)\$ {

    expires 2M;
    access_log off;
    add_header Cache-Control "public";
  }

  # CSS and Javascript
  location ~* \.(?:css|js)\$ {

    expires 2M;
    access_log off;
    add_header Cache-Control "public";
  }
  # dynamic data
  location ~* \.(?:manifest|appcache|html?|xml|json)\$ {

    expires -1;
  }
}
EOF
echo -e "Writing Config for PhpMyAdmin"

sudo cat > /etc/nginx/sites-enabled/pmad.conf <<EOF
server {

  listen 50;
  listen localhost:50;
  server_name _;
  root /usr/share/phpmyadmin;
  index index.php index.html index.htm;

  location ~ \.php\$ {

    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php7.2-fpm.sock;

  }
  location ~* (.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))\$ {

    root /usr/share/phpmyadmin;
  }

}
EOF

sudo nginx -t
sudo systemctl reload nginx

echo -e "Step:6 [Install curl]"
sudo apt install -y curl
echo -e "curl Installation Completed Successfully\n"

echo -e "Step:7 [Install Git]"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install -y git
echo -e "Git Installation Completed Successfully\n"

echo -e "Step:8 [Restart newly isntalled services]"
sudo service php7.3-fpm restart
sudo systemctl restart nginx
echo -e "Restarted Successfully\n" 

echo -e "Step:9 [Install Composer]"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo -e "Composer Installation Completed Successfully\n"


echo -e "Finished!!!\nThanks  !!!"
echo -e "MySQL Database Credential could be found at /etc/mysql/debian.cnf"

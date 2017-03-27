# Install

```
$ sudo apt-get update

$ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.4.0
rbenv global 2.4.0
ruby -v

gem install bundler
rbenv rehash



sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -y update
sudo apt-get install -y oracle-java8-installer oracle-java8-set-default
sduo apt-get install maven



sudo apt-get install mysql-client-5.6 mysql-server-5.6
mysql -uroot

CREATE DATABASE killbill CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
DROP USER 'killbill'@'localhost';
CREATE USER 'killbill'@'localhost' IDENTIFIED BY 'killbill';
GRANT ALL PRIVILEGES ON *.* TO 'killbill'@'localhost' identified by 'killbill';
FLUSH PRIVILEGES;

INSERT INTO mysql.user (host,USER,password) VALUES ('%','killbill',password('killbill')); 
GRANT ALL PRIVILEGES ON *.* TO 'killbill'@'%'; FLUSH PRIVILEGES;


sudo vi /etc/mysql/my.cnf

# bind-address          = 127.0.0.1 주석처리

max_allowed_packet      = 500M
max_connections        = 10000

$ sudo service mysql restart

/document/schema 파일들을 임포트할것.

/document/schema/killbill.sql
/document/schema/analytics.sql
/document/schema/currency.sql
/document/schema/kaui.sql
/document/schema/paypal.sql
/document/schema/stripe.sql
/document/schema/killbill.sql










$ sudo apt-get install git
$ cd
$ git clone https://github.com/TheOpenCloudEngine/killbill

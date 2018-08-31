# Install Guide (1.0.2 - Killbill 0.18.7)

**Docker**

```
docker run -p 8080:8080\
 -e DB_HOST=cloud.pas-mini.io\
 -e DB_PORT=13306\
 -e DB_DATABASE=killbill\
 -e DB_USER=root\
 -e DB_PASSWORD=killbill\
 -e IAM_CLIENT_KEY=my-client-key\
 -e IAM_CLIENT_SECRET=my-client-secret\
 -e IAM_HOST=iam.pas-mini.io\
 -e IAM_PORT=80\
 sppark/billing:v1
```

**Turn ONLY_FULL_GROUP_BY off**

```
sudo docker exec -it e1066fe2db35 /bin/bash
vi /etc/mysql/mysql.conf.d/mysqld.cnf

sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

exit

sudo docker restart e1066fe2db35 
```

## First, install the Oauth2.0 authentication server - uengine-iam

[https://github.com/TheOpenCloudEngine/uEngine-iam](https://github.com/TheOpenCloudEngine/uEngine-iam)

## Java Install && Download sources

자바 인스톨 및 필요 소스들을 다운로드합니다.

### CentOS

```
$ sudo yum update
$ sudo yum install java-1.8.0-openjdk-devel.x86_64


$ sudo yum install wget

$ cd
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/bundles.zip
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/killbill-profiles-killbill-0.18.7-SNAPSHOT.war
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/uengine-bill-all.sql
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/reports.zip
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/uengine-bill-web-1.0.2-SNAPSHOT.war
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/apache-tomcat-8.0.42.tar.gz

$ sudo yum install unzip
$ sudo mkdir /var/tmp/bundles
$ sudo unzip bundles.zip -d /var/tmp/bundles

$ tar -xvf apache-tomcat-8.0.42.tar.gz
$ cp killbill-profiles-killbill-0.18.7-SNAPSHOT.war apache-tomcat-8.0.42/webapps/killbill.war
$ cp uengine-bill-web-1.0.2-SNAPSHOT.war apache-tomcat-8.0.42/webapps/ROOT.war 
$ chmod +x apache-tomcat-8.0.42/webapps/killbill.war
$ chmod +x apache-tomcat-8.0.42/webapps/ROOT.war
$ rm -rf apache-tomcat-8.0.42/webapps/ROOT
```

### Ubuntu

```
$ sudo apt-get update
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer oracle-java8-set-default wget unzip -y

$ cd
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/bundles.zip
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/killbill-profiles-killbill-0.18.7-SNAPSHOT.war
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/uengine-bill-all.sql
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/reports.zip
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/uengine-bill-web-1.0.2-SNAPSHOT.war
$ wget https://s3.ap-northeast-2.amazonaws.com/uengine-bill/1.0.2/apache-tomcat-8.0.42.tar.gz

$ sudo mkdir /var/tmp/bundles
$ sudo unzip bundles.zip -d /var/tmp/bundles

$ tar -xvf apache-tomcat-8.0.42.tar.gz
$ cp killbill-profiles-killbill-0.18.7-SNAPSHOT.war apache-tomcat-8.0.42/webapps/killbill.war
$ cp uengine-bill-web-1.0.2-SNAPSHOT.war apache-tomcat-8.0.42/webapps/ROOT.war 
$ chmod +x apache-tomcat-8.0.42/webapps/killbill.war
$ chmod +x apache-tomcat-8.0.42/webapps/ROOT.war
$ rm -rf apache-tomcat-8.0.42/webapps/ROOT
```

## Install Jruby

유엔진 빌링은 OSGI 를 사용하여 ruby 번들을 실행시키기 때문에, Jruby 가 필요합니다.

### CentOS

```
$ sudo mkdir -p /var/lib/jruby
$ sudo su (root 권한으로 설치할 것)
$ curl -SL http://jruby.org.s3.amazonaws.com/downloads/1.7.26/jruby-bin-1.7.26.tar.gz \
    | tar -z -x --strip-components=1 -C /var/lib/jruby
$ exit (root 권한 빠져나올 것)
```

bash_profile 에 jruby 패스를 추가하고, gem 명령어를 확인합니다.

```
$ sudo vi .bash_profile
.
.
export PATH="/var/lib/jruby/bin:$PATH"


$ source .bash_profile 
$ gem env
```

### Ubuntu

```
$ sudo apt-get install curl
$ sudo mkdir -p /var/lib/jruby
$ sudo su (root 권한으로 설치할 것)
$ curl -SL http://jruby.org.s3.amazonaws.com/downloads/1.7.26/jruby-bin-1.7.26.tar.gz \
    | tar -z -x --strip-components=1 -C /var/lib/jruby
$ exit (root 권한 빠져나올 것)

$ sudo vi .bash_profile
.
.
export PATH="/var/lib/jruby/bin:$PATH"


$ source .bash_profile 
$ gem env
```


## Mysql setting

Mysql 설치 및 환경설정


### CentOS

```
$ sudo rpm -ivh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
$ sudo yum install yum install mysql mysql-server

$ sudo sudo vi /etc/my.cnf

[mysqld]
.
.
max_allowed_packet      = 100M
max_connections        = 1000


$ sudo systemctl start mysqld
$ mysql -uroot
```

### Ubuntu

```
$ sudo apt-get install mysql-client-5.6 mysql-server-5.6
$ mysql -uroot
```

데이터베이스 등록과 유저를 등록합니다.

```
CREATE DATABASE killbill CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
DROP USER 'killbill'@'localhost';
CREATE USER 'killbill'@'localhost' IDENTIFIED BY 'killbill';
GRANT ALL PRIVILEGES ON *.* TO 'killbill'@'localhost' identified by 'killbill';
FLUSH PRIVILEGES;

INSERT INTO mysql.user (host,USER,password,ssl_cipher,x509_issuer,x509_subject,authentication_string) value ('%','killbill',password('killbill') ,'', '','',''); 
GRANT ALL PRIVILEGES ON *.* TO 'killbill'@'%'; FLUSH PRIVILEGES;
EXIT;
```

다운로드 받은 스키마 파일을 killbill 데이터베이스에 임포트합니다.

```
$ mysql -u killbill -p killbill < uengine-bill-all.sql

Enter password: killbill

$ mysql -uroot
mysql> use killbill;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+----------------------------------------------+
| Tables_in_killbill                           |
+----------------------------------------------+
| _invoice_payment_control_plugin_auto_pay_off |
| account_email_history                        |
| account_emails                               |
| account_history                              |
| accounts                                     |
| analytics_account_fields                     |
| analytics_account_tags                       |
| analytics_account_transitions                |
| analytics_accounts                           |
| analytics_bundle_fields                      |
| analytics_bundle_tags                        |
| analytics_bundles                            |
| analytics_currency_conversion                |
| analytics_invoice_adjustments                |
| analytics_invoice_credits                    |
| analytics_invoice_fields                     |
| analytics_invoice_item_adjustments           |
| analytics_invoice_items                      |
| analytics_invoice_payment_fields             |
| analytics_invoice_tags                       |
| analytics_invoices                           |
| analytics_notifications                      |
| analytics_notifications_history              |
| analytics_payment_auths                      |
| analytics_payment_captures                   |
| analytics_payment_chargebacks                |
| analytics_payment_credits                    |
| analytics_payment_fields                     |
| analytics_payment_method_fields              |
| analytics_payment_purchases                  |
| analytics_payment_refunds                    |
| analytics_payment_tags                       |
| analytics_payment_voids                      |
| analytics_reports                            |
| analytics_subscription_transitions           |
| analytics_transaction_fields                 |
| audit_log                                    |
| authority                                    |
| billing_rule                                 |
| blocking_states                              |
| bundles                                      |
| bus_events                                   |
| bus_events_history                           |
| bus_ext_events                               |
| bus_ext_events_history                       |
| catalog_override_phase_definition            |
| catalog_override_plan_definition             |
| catalog_override_plan_phase                  |
| currency_rates                               |
| currency_updates                             |
| custom_field_history                         |
| custom_fields                                |
| invoice_items                                |
| invoice_parent_children                      |
| invoice_payments                             |
| invoices                                     |
| kaui_allowed_user_tenants                    |
| kaui_allowed_users                           |
| kaui_tenants                                 |
| kaui_users                                   |
| node_infos                                   |
| notification_config                          |
| notifications                                |
| notifications_history                        |
| organization                                 |
| organization_email                           |
| organization_template                        |
| payment_attempt_history                      |
| payment_attempts                             |
| payment_history                              |
| payment_method_history                       |
| payment_methods                              |
| payment_transaction_history                  |
| payment_transactions                         |
| payments                                     |
| paypal_express_payment_methods               |
| paypal_express_responses                     |
| paypal_express_transactions                  |
| product                                      |
| product_distribution_history                 |
| product_provider                             |
| product_version                              |
| registe                                      |
| roles_permissions                            |
| rolled_up_usage                              |
| service_broadcasts                           |
| sessions                                     |
| stripe_payment_methods                       |
| stripe_responses                             |
| stripe_transactions                          |
| subscription_events                          |
| subscription_events_ext                      |
| subscriptions                                |
| tag_definition_history                       |
| tag_definitions                              |
| tag_history                                  |
| tags                                         |
| tenant_broadcasts                            |
| tenant_kvs                                   |
| tenants                                      |
| user_roles                                   |
| users                                        |
+----------------------------------------------+
102 rows in set (0.01 sec)
```

## Tomcat Configuration

uEngine 빌링은 별도의 properties 파일이 없고, 실행시 런타임 env 에 의해 properties 가 정의됩니다.

아래의 catalina.sh 에 들어가는 CATALINA_OPTS 및 JAVA_OPTS 들은 Docker container 를 사용할 경우 시스템 env 로 등록하여도 됩니다.

```
$ cd apache-tomcat-8.0.42
$ vi bin/catalina.sh

.
.
CATALINA_OPTS="$CATALINA_OPTS -server -Xms1024m -Xmx2048m -XX:NewSize=512m -XX:MaxNewSize=1024m -XX:PermSize=512m -XX:MaxPermSize=1024m -Djava.awt.headless=true"

JAVA_OPTS="$JAVA_OPTS -Djdbc.driver=com.mysql.jdbc.Driver
-Dorg.killbill.dao.url=jdbc:mysql://localhost:3306/killbill
-Dorg.killbill.dao.user=killbill
-Dorg.killbill.dao.password=killbill
-Dorg.killbill.billing.osgi.dao.url=jdbc:mysql://localhost:3306/killbill
-Dorg.killbill.billing.osgi.dao.user=killbill
-Dorg.killbill.billing.osgi.dao.password=killbill
-Dorg.killbill.osgi.bundle.install.dir=/var/tmp/bundles
-Dorg.killbill.server.test.mode=true
-Dorg.killbill.notificationq.main.queue.mode=POLLING
-Dorg.killbill.persistent.bus.external.queue.mode=POLLING
-Dorg.killbill.persistent.bus.main.queue.mode=POLLING
-Dorg.killbill.notificationq.analytics.tableName=analytics_notifications
-Dorg.killbill.notificationq.analytics.historyTableName=analytics_notifications_history
-Dorg.killbill.catalog.mode=dynamic
-Dorg.killbill.payment.retry.days=1,1,1
-Dorg.killbill.mail.smtp.host=smtp.gmail.com
-Dorg.killbill.mail.smtp.port=587
-Dorg.killbill.mail.smtp.auth=true
-Dorg.killbill.mail.smtp.user=flamingo.workflow@gmail.com
-Dorg.killbill.mail.smtp.password=princoprinco9
-Dorg.killbill.mail.from=support@uengine.org
-Dorg.killbill.mail.fromname=uengine
-Dorg.killbill.mail.useSSL=true
-Dorg.killbill.mail.redirect.address=http://localhost
-Dorg.killbill.invoice.emailNotificationsEnabled=true
-Dorg.killbill.invoice.globalLock.retries=200
-Dkillbill.url=http://localhost/killbill
-Dkillbill.user=admin
-Dkillbill.password=password
-Diam.trust.client.key=e74a9505-a811-407f-b4f6-129b7af1c703
-Diam.trust.client.secret=109cf590-ac67-4b8c-912a-913373ada046
-Diam.host=iam.essencia.live
-Diam.port=8080
-Dsystem.admin.username=myaccount@gmail.com
-Dsystem.admin.password=mypassword
```

각 설정 값들에 대한 설명입니다.

| 설정값                                                | 설명                                                                                                                                   | 예시                                 |
|-------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| jdbc.driver                                           | jdbc 드라이버명                                                                                                                        | com.mysql.jdbc.Driver                |
| org.killbill.dao.url                                  | 데이터베이스 주소                                                                                                                      | jdbc:mysql://localhost:3306/killbill |
| org.killbill.dao.user                                 | 데이터베이스 사용자                                                                                                                    | killbill                             |
| org.killbill.dao.password                             | 데이터베이스 패스워드                                                                                                                  | killbill                             |
| org.killbill.billing.osgi.dao.url                     | osgi 데이터베이스 주소                                                                                                                 | jdbc:mysql://localhost:3306/killbill |
| org.killbill.billing.osgi.dao.user                    | osgi 데이터베이스 사용자                                                                                                               | killbill                             |
| org.killbill.billing.osgi.dao.password                | osgi 데이터베이스 패스워드                                                                                                             | killbill                             |
| org.killbill.osgi.bundle.install.dir                  | 번들 파일 인스톨 위치                                                                                                                  | /var/tmp/bundles                     |
| org.killbill.server.test.mode                         | 테스트 서버 모드 (시간 변경, 페이팔 및 스트라이프 샌드박스 모드)                                                                       | TRUE                                 |
| org.killbill.notificationq.main.queue.mode            | notification 큐 모드 (클라우드 환경은 POLLING 추천)                                                                                    | POLLING                              |
| org.killbill.persistent.bus.external.queue.mode       | 플러그인 이벤트 큐 모드 (클라우드 환경은 POLLING 추천)                                                                                 | POLLING                              |
| org.killbill.persistent.bus.main.queue.mode           | 메인 이벤트 큐 모드 (클라우드 환경은 POLLING 추천)                                                                                     | POLLING                              |
| org.killbill.notificationq.analytics.tableName        | 분석 도구 테이블 명 (analytics_notifications 고정)                                                                                     | analytics_notifications              |
| org.killbill.notificationq.analytics.historyTableName | 분석 도구 히스토리 테이블 명 (analytics_notifications_history 고정)                                                                    | analytics_notifications_history      |
| org.killbill.catalog.mode                             | 동적 카달로그 제어 모드 (dynamic 필수)                                                                                                 | dynamic                              |
| org.killbill.payment.retry.days                       | 결제 재시도 디폴트 값 (1,1,1 값은 3일동안 한번씩, 5,2 는 5일 후, 2틀 후 한번씩 시도 )                                                  | 1,1,1                                |
| org.killbill.mail.smtp.host                           | 이메일 stmp 주소                                                                                                                       | smtp.gmail.com                       |
| org.killbill.mail.smtp.port                           | 이메일 stmp 포트                                                                                                                       | 587                                  |
| org.killbill.mail.smtp.auth                           | 이메일 smtp auth                                                                                                                       | TRUE                                 |
| org.killbill.mail.smtp.user                           | 이메일 stmp 유저                                                                                                                       | flamingo.workflow@gmail.com          |
| org.killbill.mail.smtp.password                       | 이메일 stmp 패스워드                                                                                                                   | princoprinco9                        |
| org.killbill.mail.from                                | 이메일 발송시 표기될 주소                                                                                                              | support@uengine.org                  |
| org.killbill.mail.fromname                            | 이메일 발송시 표기될 이름                                                                                                              | uengine                              |
| org.killbill.mail.useSSL                              | 이메일 ssl 사용 여부                                                                                                                   | TRUE                                 |
| org.killbill.mail.redirect.address                    | 이메일 링크 클릭시 리다이렉트 되는 호스트 (실제 서비스 호스트 등록 추천)                                                               | http://localhost                     |
| org.killbill.invoice.emailNotificationsEnabled        | 시스템의 인보이스 이메일 발송 기능 사용 여부                                                                                           | TRUE                                 |
| org.killbill.invoice.globalLock.retries        | 시스템의 인보이스 생성 리트라이 (1회당 100ms 대기, 지정된 회수 대기 후 시스템 락)                                                                                           | 200                                 |
| killbill.url                                          | 킬빌 서버 주소 (킬빌과 유엔진빌링이 같은 was 를 사용하기 때문에, http://localhost:<was포트>/<killbill war 콘텍스트> 로 설정하면 된다.) | http://localhost/killbill            |
| killbill.user                                         | 킬빌 서버 기본 사용자 (admin 고정)                                                                                                     | admin                                |
| killbill.password                                     | 킬빌 서버 기본 사용자 패스워드 (password 고정)                                                                                         | password                             |
| iam.trust.client.key                                  | IAM 클라이언트 키                                                                                                                      | my-client-key |
| iam.trust.client.secret                               | IAM 클라이언트 시크릿 키                                                                                                               | my-client-secret |
| iam.host                                              | IAM 도메인                                                                                                                             | iam.essencia.live                    |
| iam.port                                              | IAM 포트                                                                                                                               | 8080                                 |
| system.admin.username                                              | 빌링 포탈 로그인 아이디                                                                                                                               | myaccount@gmail.com                                 |
| system.admin.password                                              | 빌링 포탈 로그인                                                                                                                                | mypassword                                 |


서버 포트 80 변경(옵션)

```
$ vi conf/server.xml

.
.
<Connector port="80" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```

## Hostname check

만약 인스턴스가 실제 도메인이 아닌 가상호스트 네임을 가지고있는 경우, 아래와 같이 호스트네임이 127.0.0.1 을 바라볼 수 있도록 설정합니다.

```
$ sudo vi /etc/hosts

127.0.0.1   localhost billing-test2 (호스트네임을 추가해준다)
::1         localhost
```

## Ntp

인스턴스를 단독으로 운영 할 때는 ntp 가 필요없지만, 멀티 인스턴스 환경에서는 모든 인스턴스가 동일한 timezone 을 바라보아야 합니다.

ntp 를 설치만 해도 자동으로 timezone 과 동기화되지만, Region 별로 특정 timezone 적용을 원할 시에는 ntp 문서를 참조하도록 합니다.

### CentOS

```
$ sudo yum install ntp
```

### Ubuntu

```
$ sudo apt-get install ntp
```

## Server Entropy

Jruby 는 Security 동작시 서버에 충분한 엔트로피가 있어야 합니다 (3K 이상).

경우에 따라 OS 에 엔트로피가 매우 낮게 설정되있는 경우가 있으니, 아래의 절차를 통해 동적 엔트로피 풀을 유지할 수 있도록 합니다.

이 설정을 하지 않을 경우 빌링 서비스가 매우 느리게 동작하게 됩니다.

### CentOS

```
$ sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
$ sudo yum update
$ sudo yum install haveged
$ sudo chkconfig haveged on
$ haveged -w 1024
$ sudo systemctl start haveged
```

### Ubuntu

```
sudo apt-get install haveged

vi /etc/default/haveged

.
.
DAEMON_ARGS="-w 1024"

update-rc.d haveged defaults
```

## Service start

이제 유엔진 빌링을 실행시킵니다.

```
$ sudo bin/startup.sh
```


## Analytics Settings

다음은 통계분석 플러그인 모듈을 위한 데이터베이스 세팅입니다.

다운로드 받은 reports.zip 의 압축을 풀면, seed_reports.sh 파일이 있습니다.

```
#!/usr/bin/env bash

HERE=`cd \`dirname $0\`; pwd`

MYSQL_HOST=${MYSQL_HOST-"127.0.0.1"}
MYSQL_USER=${MYSQL_USER-"killbill"}
MYSQL_PASSWORD=${MYSQL_PASSWORD-"killbill"}
MYSQL_DATABASE=${MYSQL_DATABASE-"killbill"}

.
.
```

seed_reports.sh 를 실행하게 될 경우 통계 분석에 필요한 뷰 테이블들이 데이터 베이스에 생성되게 됩니다.

데이터 베이스의 세팅을 환경에 맞게 설정하여 주신 후, 스크립트를 실행하도록 합니다.

```
$ sh ./seed_reports.sh
```

# 로그인

IAM 을 브라우저에서 접속합니다. IAM 의 초기 아이디와 패스워드는 admin / admin 입니다.

접속하시면, 사용자 목록에 `system.admin.username` 값으로 입력했던 아이디를 볼 수 있습니다.

빌링 포털에서 해당 아이디 및 패스워드 입력시 로그인 할 수 있습니다.





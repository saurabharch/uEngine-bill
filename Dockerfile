FROM tomcat:8.0.53-jre8
VOLUME /tmp

ARG CI_PROJECT_NAME
ARG CI_COMMIT_SHA
ENV CI_PROJECT_NAME=$CI_PROJECT_NAME
ENV CI_COMMIT_SHA=$CI_COMMIT_SHA


ADD ./catalina.sh /usr/local/tomcat/bin/catalina.sh
ADD ./bundles.zip /bundles.zip
ADD ./killbill-profiles-killbill-0.18.7-SNAPSHOT.war /usr/local/tomcat/webapps/killbill.war

RUN mkdir /var/tmp/bundles
RUN unzip /bundles.zip -d /var/tmp/bundles

RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN chmod +x /usr/local/tomcat/webapps/killbill.war
RUN chmod +x /usr/local/tomcat/bin/catalina.sh

RUN apt-get install curl
RUN mkdir -p /var/lib/jruby
RUN curl -SL http://jruby.org.s3.amazonaws.com/downloads/1.7.26/jruby-bin-1.7.26.tar.gz \
    | tar -z -x --strip-components=1 -C /var/lib/jruby

ADD ./uengine-bill-web/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN chmod +x /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["sh","bin/catalina.sh", "run"]
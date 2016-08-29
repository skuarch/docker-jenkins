FROM ubuntu:16.04

MAINTAINER Alfredo Bello <skuarch@yahoo.com.mx>

ADD ./tomcat-users.xml ./startup.sh ./server.xml ./context.xml /tmp/

RUN apt-get update -y && \
    apt-get install unzip curl -y && \

## install java
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "https://edelivery.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz" && \
    mkdir /usr/lib/jvm && \
    tar -xf /jdk-8u91-linux-x64.tar.gz && \
    mv /jdk1.8.0_91 /usr/lib/jvm/ && \
    chmod 777 -R /usr/lib/jvm && \
    update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_91/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_91/bin/javac" 1 && \
    update-alternatives --install "/usr/bin/javah" "javah" "/usr/lib/jvm/jdk1.8.0_91/bin/javah" 1 && \
    JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_91/bin/java && \
    rm -rf /jdk-8u91-linux-x64.tar.gz && \

## install tomcat
    curl -L -O http://mirror.nexcess.net/apache/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz && \
    tar -xf /apache-tomcat-8.0.36.tar.gz && \
    mv /apache-tomcat-8.0.36 ./tomcat && \
    mv /tomcat /opt/ && \
    chmod 777 -R /opt/tomcat && \
    rm /opt/tomcat/conf/server.xml && \
    mv /tmp/server.xml /opt/tomcat/conf/ && \
    mv /tmp/context.xml /opt/tomcat/conf/ && \
    HUDSON_HOME=/opt/tomcat && \
    CATALINA_HOME=/opt/tomcat && \
    export HUDSON_HOME=/opt/tomcat && \
    export CATALINA_HOME=/opt/tomcat && \
    rm -rf /apache-tomcat-8.0.36.tar.gz && \


## install jenkins
    curl -L -O http://mirrors.jenkins-ci.org/war-stable/2.7.2/jenkins.war && \
    mv /jenkins.war /opt/tomcat/webapps && \
    HUDSON_HOME=/opt/tomcat && \
    CATALINA_HOME=/opt/tomcat && \
    export HUDSON_HOME=/opt/tomcat && \
    export CATALINA_HOME=/opt/tomcat && \ 

## create tomcat user
   rm /opt/tomcat/conf/tomcat-users.xml && \
   mv /tmp/tomcat-users.xml /opt/tomcat/conf/ && \

## install git
   apt-get install git-core -y -f && \
   git config --global user.name "jenkins" && \
   git config --global user.email "jenkins@localhost" && \

## install maven
   curl -L -O http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
   tar -xf apache-maven-3.3.9-bin.tar.gz && \
   mv /apache-maven-3.3.9 /usr/local/ && \
   M2_HOME=/usr/local/apache-maven-3.3.9 && \
   M2=$M2_HOME/bin && \
   MAVEN_OPTS="-Xms256m -Xmx512m" && \
   PATH=$M2:$PATH && \
   JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
   export M2_HOME && \
   export M2 && \
   export MAVEN_OPTS && \
   export JAVA_HOME  && \
   ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
   rm -rf /apache-maven-3.3.9-bin.tar.gz && \

## startup.sh
   mv /tmp/startup.sh / && \
   chmod +x /startup.sh && \

## clean up
   rm -rf /tmp/*

WORKDIR /opt/tomcat
VOLUME /opt/tomcat
EXPOSE 8080 5000

CMD /./startup.sh

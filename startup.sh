echo "setting vars"
M2_HOME=/usr/local/apache-maven-3.3.9
M2=$M2_HOME/bin
MAVEN_OPTS="-Xms256m -Xmx512m"
PATH=$M2:$PATH
JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91
export M2_HOME
export M2
export MAVEN_OPTS
export JAVA_HOME
ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
/opt/tomcat/bin/catalina.sh run 

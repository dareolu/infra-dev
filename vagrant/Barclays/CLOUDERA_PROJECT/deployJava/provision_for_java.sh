#!/bin/bash
################## install oracle jdk1.8   ####################

#Use this if there is no Internet access (Recommended for production)
#yum localinstall -y /repository/oracle-java-sdk-jdk/jdk-8u101-linux-x64.rpm

sudo -y install zip
sudo yum -y install unzip
sudo mkdir /usr/java/ && cd /usr/java
sudo wget --no-check-certificate --no-cookies --header "Cookie:oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
sudo wget --no-check-certificate --no-cookies --header "Cookie:oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
sudo tar xzf jdk-8u151-linux-x64.tar.gz

echo '' >> /etc/profile
echo '# set JAVAHOME' >> /etc/profile
echo 'export JAVA_HOME=/usr/java/jdk1.8.0_151' >> /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
source /etc/profile

#Create a soft link to Java and set JAVA_HOME
sudo ln -s /usr/java/jdk1.8.0_151 /usr/java/default
sudo unzip -o -j -q  /usr/java/jce_policy-8.zip -d /usr/java/default/jre/lib/security/


# configure it on the system using the alternatives command. This is in order to tell the system what are the default commands for JAVA
sudo alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_151/jre/bin/java 20000
sudo alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0_151/bin/jar 20000
sudo alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_151/bin/javac 20000
sudo alternatives --set java /usr/java/jdk1.8.0_151/jre/bin/java
sudo alternatives --set javac /usr/java/jdk1.8.0_151/bin/javac
sudo alternatives --set jar /usr/java/jdk1.8.0_151/bin/jar

# list version
ls -lA /etc/alternatives/ | grep java
java -version
javac -version

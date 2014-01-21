#!/bin/bash

export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=orcl
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1
export ORACLE_SID=cdb12c

#prerequisites
sudo yum -y install oracle-rdbms-server-12cR1-preinstall
sudo cp /vagrant/env/etc/hosts /etc/hosts
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network
sudo /etc/init.d/network restart

sudo hostname -v oracle12c.localdomain

cd /vagrant/database_installer

unzip linuxamd64_12c_database_1of2.zip
unzip linuxamd64_12c_database_2of2.zip

cd /home/oracle

#copy in oracle .bash_profile

sudo -Eu oracle cp /vagrant/env/bash_profile /home/oracle/.bash_profile 

#create /u01 directory

sudo rm -r -f /u01
sudo mkdir /u01
sudo chown oracle:oinstall /u01

#run oracle installer

cd /vagrant/database_installer/database

sudo -Eu oracle ./runInstaller -showProgress -silent -waitforcompletion -ignoreSysPrereqs \
-responseFile /vagrant/scripts/oracle12c.rsp

errorlevel=$?

if [ "$errorlevel" != "0" ] && [ "$errorlevel" != "6" ]; then
  echo "There was an error preventing script from continuing"
  exit 1
fi

#install patches before creating databases
sudo su - oracle /vagrant/patches/installpatch.sh

cd

#clean up database_installer directory
rm -r -f /vagrant/database_installer/database

#run the root scripts

sudo /u01/app/oraInventory/orainstRoot.sh

sudo /u01/app/oracle/product/12.1.0/db_1/root.sh

#configure listener

#SRC=/vagrant/env/listener.ora
DEST=$ORACLE_HOME/network/admin/listener.ora
#sudo cp $SRC $DEST
#sudo chown oracle:oinstall $DEST
#sudo chmod 0644 $DEST
sudo rm $DEST

#start listener

sudo -Eu oracle $ORACLE_HOME/bin/lsnrctl start

#install oracle service
SRC=/vagrant/env/etc/init.d/oracle
DEST=/etc/init.d/oracle
sudo cp $SRC $DEST
sudo chmod 0755 $DEST

#set oracle service to start at boot
sudo chkconfig oracle on

#sqlplus startup config file
SRC=/vagrant/env/glogin.sql
DEST=$ORACLE_HOME/sqlplus/admin/glogin.sql
sudo cp $SRC $DEST
sudo chown oracle:oinstall $DEST
sudo chmod 0644 $DEST

#create the container and a pluggable database

sudo -Eu oracle $ORACLE_HOME/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName cdb12c \
-sid cdb12c \
-createAsContainerDatabase true \
-numberOfPdbs 1 \
-pdbName pdb \
-pdbadminUsername vagrant \
-pdbadminPassword vagrant \
-SysPassword vagrant \
-SystemPassword vagrant \
-emConfiguration NONE \
-datafileDestination /u01/oradata \
-storageType FS \
-characterSet AL32UTF8 \
-memoryPercentage 40 \
-listeners LISTENER

#tnsnames.ora
SRC=/vagrant/env/tnsnames.ora
DEST=$ORACLE_HOME/network/admin/tnsnames.ora
sudo cp $SRC $DEST
sudo chown oracle:oinstall $DEST
sudo chmod 0644 $DEST

#oratab
SRC=/vagrant/env/etc/oratab
DEST=/etc/oratab
sudo cp $SRC $DEST
sudo chown oracle:oinstall $DEST
sudo chmod 0644 $DEST


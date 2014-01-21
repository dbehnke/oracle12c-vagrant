#!/bin/bash

export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1

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

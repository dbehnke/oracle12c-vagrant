#Oracle 12c Vagrant 

Updated for 12.1.0.1 with 12.1.0.2 January CPU

Follwing these instructions will create a VirtualBox VM, Install Oracle 12cR1 software, Patch it, and then create a container database with one pluggable database.

## Prerequisites

### VirtualBox

http://virtualbox.com

### Packer

http://packer.io

### Vagrant

http://vagrantup.com

### Oracle Linux 6.5

1. Download Oracle Linux 6.5 DVD ISO
2. Rename and move it to packer/oracle_linux_6.5.iso 

### Oracle 12cR1

1. Download Database Install files (1 and 2) - http://www.oracle.com/technetwork/database/enterprise-edition/downloads/database12c-linux-download-1959253.html
2. Place the zip archives in database_installer/

### Oracle 12cR1 CPU Patches

http://support.oracle.com

1. Download patch 17552800
2. Download patch 6880880
3. Place 17552800 at patches/p17552800_121010_Linux-x86-64.zip
4. Place 6880880 at patches/p6880880_121010_Linux-x86-64.zip

## Build Vagrant Box Image Using Packer

  $ cd {project root}
  $ cd packer
  $ ./buildbox.sh

## Import into Vagrant

  $ cd {project root}
  $ cd packer
  $ ./importbox.sh

## Run Vagrant Box

  $ cd {project root}
  $ vagrant up
  $ vagrant ssh

## Run Oracle 12c Installation Script

  [vagrant@oracle12c ~]$ sudo /vagrant/scripts/oracle12c-install.sh
  
## Connect to Database

  Default password for sys, system is vagrant - Port 1521 - service cdb12c (for container), pdb (for pluggable database)

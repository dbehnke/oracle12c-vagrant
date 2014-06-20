#Oracle 12c Vagrant

Updated for 12.1.0.1 with 12.1.0.1.3 April 15 2014 PSU

Patch 18031528: DATABASE PATCH SET UPDATE 12.1.0.1.3

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

1. Download Patch 18031528: DATABASE PATCH SET UPDATE 12.1.0.1.3
2. Download patch 6880880
3. Place 18031528 at patches/p18031528_121010_Linux-x86-64.zip
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

    [vagrant@vagrant-ol6 ~]$ sudo /vagrant/scripts/oracle12c-install.sh

## Connect to Database

  Default password for sys, system is vagrant - Port 1521 - service cdb12c (for container), pdb (for pluggable database)

## Verifying Patch was Installed

    $ su - oracle

    [oracle@oracle12c ~]$ /u01/app/oracle/product/12.1.0/db_1/OPatch/opatch lsinventory

    Oracle Interim Patch Installer version 12.1.0.1.0
    Copyright (c) 2012, Oracle Corporation.  All rights reserved.


    Oracle Home       : /u01/app/oracle/product/12.1.0/db_1
    Central Inventory : /u01/app/oraInventory
       from           : /u01/app/oracle/product/12.1.0/db_1/oraInst.loc
    OPatch version    : 12.1.0.1.0
    OUI version       : 12.1.0.1.0
    Log file location : /u01/app/oracle/product/12.1.0/db_1/cfgtoollogs/opatch/opatch2014-06-20_15-12-23PM_1.log

    Lsinventory Output file location : /u01/app/oracle/product/12.1.0/db_1/cfgtoollogs/opatch/lsinv/lsinventory2014-06-20_15-12-23PM.txt

    --------------------------------------------------------------------------------
    Installed Top-level Products (1):

    Oracle Database 12c                                                  12.1.0.1.0
    There are 1 products installed in this Oracle Home.


    Interim patches (1) :

    Patch  18031528     : applied on Fri Jun 20 14:53:35 UTC 2014
    Unique Patch ID:  17262469.1
    Patch description:  "Database Patch Set Update : 12.1.0.1.3 (18031528)"
       Created on 18 Mar 2014, 14:50:40 hrs PST8PDT
       Bugs fixed:
         17716305, 17034172, 16694728, 16855202, 17439871, 16320173, 17462687
         17082983, 16313881, 16715647, 17362796, 17777061, 16450169, 16392068
         17761775, 16977973, 14197853, 16712618, 17552800, 17922172, 17441661
         16524071, 16856570, 18362376, 16410570, 13866822, 16372203, 16849982
         16837842, 16459685, 16101465, 18393024, 16802693, 16978185, 16845022
         16195633, 17042658, 14536110, 17983206, 17579911, 16787973, 16850996
         17311728, 16838328, 16178562, 17391312, 17244462, 16503473, 16935643
         18126350, 17039360, 14355775, 17721717, 17489214, 16362358, 16994576
         16928832, 16864359, 17080436, 16679874, 18031528, 16788832, 16585173
         15986012, 18099539, 17467075, 14852021, 16191248, 17174391, 17830435
         17249820, 16946990, 16589507, 16924879, 16173738, 16874123, 17797453
         16784143, 15987992, 17343514, 17346196, 17324822, 16495802, 16859937
         16590848, 17316776, 17068536, 16986421, 16910001, 16527374, 16730813
         16663303, 17490498, 17897716, 16186165, 16675739, 16170787, 16457621
         16524968, 17032726, 16543323, 18355572, 17981677, 17005047, 17442449
         16795944, 16668226, 16070351, 16698577, 17088068, 16621274, 17330580
         16888264, 16448848, 16863422, 16465158, 16634384, 17443671, 16816103
         16910734, 16517900, 16911800, 16825779, 16936008, 17019974, 16707927
         16347904, 17273253, 17263661, 17325413, 16902138, 17179261, 17810688
         16465149, 17468141, 17226980, 17184677, 16689109, 16705020, 16682595
         16864864, 16972213, 16721594, 16946613, 16964279, 16855292, 17205719
         17026503, 16964686, 16674842, 16757934, 16864562, 15996344, 16842274
         17000176, 16769019, 17572525, 17659488, 16485876, 16709437, 17289787
         16919176, 17217040, 16613964, 16796277, 16462834, 17421502, 18092561
         16617325, 17308691, 16921340, 16483559, 16057129, 16733884, 16784167
         16286774, 16822629, 16660558, 17596344, 17954431, 17570606, 16674666
         16697600, 16993424, 17797837, 17716565, 16772060, 16991789, 16790307
         16275522, 17491753, 16603924, 16427054, 16227068, 16784901, 16479182
         13521413, 17478811, 16836849, 16007562, 16663465, 16551086, 17027533
         16675710, 16406802, 17437634, 16433745, 17610418, 17465741, 17171530
         16523150, 16212405, 16741246, 16930325, 16443657



    --------------------------------------------------------------------------------

    OPatch succeeded.

#!/bin/bash

cd {$HOME}
cp /vagrant/patches/ocm.rsp .
rm -r -f patch
mkdir patch
cd patch
mkdir 1
cd 1
unzip /vagrant/patches/p6880880_121010_Linux-x86-64.zip
cd ../
mkdir 2
cd 2
unzip /vagrant/patches/p19121550_121010_Linux-x86-64.zip
cd 19121550
../../1/OPatch/opatch apply -ocmrf ${HOME}/ocm.rsp

#you should apply datapatch if database was created before patches
#cd ../../1/OPatch
#./datapatch

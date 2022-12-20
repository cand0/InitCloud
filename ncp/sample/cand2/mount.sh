#!/bin/bash
yum -y install nfs-utils
systemctl start rpcbind.service
systemctl enable rpcbind.service
mkdir /mnt/nas
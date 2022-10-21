#! /bin/bash

sudo apt install openssl -y
sudo apt install proftpd -y

mdpc1=$(perl -e 'print crypt("kalimac", "salt")')
mdcp11=$(perl -e 'print crypt("secondbreakfirst", "salt")')

sudo useradd -m -p $mdpc1 Merry
sudo useradd -m -p $mdpc2 Pippin

cd /etc/proftpd
cp proftpd.conf proftpd.conf.save
echo "<Anonymous ftp>

User ftp
Group nogroup
UserAlias anonymous ftp 
DirFakeUser on ftp 
DirFakeGroup on ftp
RequireValidShell off
Max Clients 10
DisplayLogin welcome.msg
DisplayChdir .message

<Directory *>
<Limit WRITE>
AllowAll
</Limit>
</Directory>

<Directory incoming>
<Limit READ WRITE>
</Limit>
</Directory>
</Anonymous>

">> proftpd.conf

sudo systemctl restart proftpd
sudo systemctl status proftpd

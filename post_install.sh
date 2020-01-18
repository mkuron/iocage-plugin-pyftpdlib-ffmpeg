#!/bin/sh

curl -L https://files.pythonhosted.org/packages/27/64/06a574350c79873e908fa9f48b617e7961de50fc468acc0a05d76771bce9/pyftpdlib-1.5.5.tar.gz | tar xzf -
cd pyftpdlib-1.5.5
python3 setup.py install
cd ..

curl -L https://files.pythonhosted.org/packages/5a/8d/27969852f4e664525c3d070e44b2b719bc195f4d18c311c52e57bb93614e/iso-639-0.4.5.tar.gz | tar xzf -
cd iso-639-0.4.5
python3 setup.py install
cd ..

cp ftpserver.rc /etc/rc.d/ftpserver
chmod +x /etc/rc.d/ftpserver

sysrc -f /etc/rc.conf cron_enable="NO"
sysrc -f /etc/rc.conf ftpserver_enable="YES"

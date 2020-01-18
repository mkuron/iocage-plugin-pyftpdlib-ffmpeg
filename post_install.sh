#!/bin/sh

portsnap fetch
portsnap extract
export ALLOW_UNSUPPORTED_SYSTEM=1

mkdir -p /var/db/ports/ftp_py-pyftpdlib
echo "OPTIONS_FILE_UNSET+=EXAMPLES" >> /var/db/ports/ftp_py-pyftpdlib/options
echo "OPTIONS_FILE_UNSET+=OPENSSL" >> /var/db/ports/ftp_py-pyftpdlib/options
echo "OPTIONS_FILE_UNSET+=SENDFILE" >> /var/db/ports/ftp_py-pyftpdlib/options

echo "BUILD_ALL_PYTHON_FLAVORS=yes" >> /etc/make.conf

cd /usr/ports/ftp/py-pyftpdlib
make install FLAVOR=py36
make clean

mkdir -p /var/db/ports/devel_py-pip
echo "OPTIONS_FILE_UNSET+=DOCS" >> /var/db/ports/devel_py-pip/options

cd /usr/ports/devel/py-pip
make install FLAVOR=py36
make clean

python3 -m pip install iso-639

sysrc -f /etc/rc.conf cron_enable="NO"

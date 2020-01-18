# Install

```
git clone https://github.com/mkuron/iocage-plugin-pyftpdlib-ffmpeg.git pyftpdlib-ffmpeg
cd pyftpdlib-ffmpeg
iocage fetch -P -n pyftpdlib-ffmpeg.json ip4_addr="vnet0|192.168.200.23/24" vnet=on defaultrouter=192.168.200.1
iocage stop pyftpdlib-ffmpeg
iocage fstab pyftpdlib-ffmpeg -a "/CUSTOM/Skripte /scripts nullfs ro 0 0"
iocage fstab pyftpdlib-ffmpeg -a "/CUSTOM/Filme /data nullfs ro 0 0"
iocage start pyftpdlib-ffmpeg
./mdns.py &
```

# Remove

All data is stored outside the jail, so it remains intact for later use.

```
iocage stop pyftpdlib-ffmpeg
iocage destroy pyftpdlib-ffmpeg
```
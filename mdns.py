#!/usr/local/bin/python
from middlewared.client import Client

import pybonjour
import select
import socket
import threading


def register(name, regtype, port, host=None):
    sdRef = pybonjour.DNSServiceRegister(name=name,
                                         interfaceIndex=0,
                                         regtype=regtype,
                                         port=port,
                                         host=host,
                                         callBack=None)
    try:
        try:
            while True:
                ready = select.select([sdRef], [], [])
                if sdRef in ready[0]:
                    pybonjour.DNSServiceProcessResult(sdRef)
        except KeyboardInterrupt:
            pass
    finally:
        sdRef.close()


def registerHost(host ,ip):
    sdRef = pybonjour.DNSServiceCreateConnection()
    pybonjour.DNSServiceRegisterRecord(sdRef,
                                       pybonjour.kDNSServiceFlagsUnique,
                                       fullname=host,
                                       rrtype=pybonjour.kDNSServiceType_A,
                                       rdata=socket.inet_aton(ip))
    try:
        try:
            while True:
                ready = select.select([sdRef], [], [])
                if sdRef in ready[0]:
                    pybonjour.DNSServiceProcessResult(sdRef)
        except KeyboardInterrupt:
            pass
    finally:
        sdRef.close()


def main():
    client = Client()

    try:
        hostname = socket.gethostname().split(".")[0]
    except IndexError:
        hostname = socket.gethostname()

    name = "DVD-Server"
    host = hostname + "-2121.local"
    port = 2121
    ip = '192.168.200.23'
    
    t = threading.Thread(target=register,
                         args=(name, '_ftp._tcp.', port, host))
    t.daemon = False
    t.start()
    t = threading.Thread(target=registerHost,
                         args=(host, ip))
    t.daemon = False
    t.start()

if __name__ == "__main__":
    main()

#!/usr/bin/python
#coding=utf-8
import socket
import signal

global s

def handler(signo, frame):
    print '\nhandler'
    s.close()

signal.signal(signal.SIGINT,handler)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 2008))
s.listen(2008)
while True:
        a, addr = s.accept();

    data = a.recv(1024)
    print a
    print  data
    a.close()


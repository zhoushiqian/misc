#!/usr/bin/python
#coding=utf-8
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('0.0.0.0',5234))
while True:
    data = s.recv(1024)
    print data

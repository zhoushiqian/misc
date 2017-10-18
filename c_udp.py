#!/usr/bin/python
#coding=utf-8
import socket
host='127.0.0.1'
port= 5234
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.sendto(b'hello,this is a test info !',(host,port))


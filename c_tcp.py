#!/usr/bin/python
#coding=utf-8
import socket
c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.connect(('127.0.0.1', 2008))
c.send('hi boy')
c.close()


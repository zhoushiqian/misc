#!/usr/bin/python
#coding=utf-8
import threading
global num
num = 0
def fun_1(num):
    print num

def fun_2(num):
    print num



if __name__ == '__main__':
    threading.Thread(target=fun_1,1 )
    threading.Thread(target=fun_2,2 )


#!/usr/bin/python
#coding=utf-8
import multiprocessing
import os
import signal
import time

def sig_exit(signo, data):
    global exit
    exit = 1

def free_child(signo, data):
    global p
    print 'free'
    p.join()


def fun():
    print 'child %d' % os.getpid()
    time.sleep(20)

if __name__ == '__main__':
    exit = 0
    print 'parent %d' % os.getpid()
    p = multiprocessing.Process(target=fun, args=())
    p.start()
    signal.signal(signal.SIGINT, sig_exit)
    signal.signal(signal.SIGUSR1,free_child)
    while True:
        print 'exit %d' % exit
        if exit == 1:
            print 'exit?'
            break
        else:
            print 'goon'
            time.sleep(1)
    p.join()

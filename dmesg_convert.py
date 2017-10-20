#!/usr/bin/python
#coding=utf-8
import os
import sys
import time
import datetime

def get_second(line):
    strs=  line.split('] <')
    time0 = strs[0]
    end = strs[1]
    time1 = time0.split('[')
    begin = time1[0]
    time2 = time1[1].strip()
    s = int(float(time2))
    return (s, time2.split('.')[1])
 


if __name__ == '__main__':
    log_path = os.path.join(os.path.abspath('.'), sys.argv[1])
    log = open(log_path, 'r')
    out_log = open(os.path.join(os.path.abspath('.'), 'new_' + sys.argv[1]), 'w')
    first_line = log.readline()
    timestring =  first_line.replace('[',' ').replace(']', ' ').strip()
    start_time = time.mktime(time.strptime(timestring, '%Y-%m-%d %H:%M:%S'))
    begin =  get_second(log.readline())[0]
    log.close()

    log = open(log_path, 'r')
    log.readline()
#    for line in log.readlines():
    while True:
        line = log.readline()
        if line:
            seconds, point =  get_second(line)
            seconds = seconds - begin + start_time
            time_struct = time.localtime(seconds)
            str_time = time.strftime('%Y-%m-%d %H:%M:%S', time_struct) + '.' + point
            line_split =  line.split('>[') 
            out_str = line_split[0] + '>[' + str_time + '] <' +  line.split('] <')[1]
            #print out_str,
            out_log.write(out_str)
        else:
            break

    log.close()
    out_log.close()

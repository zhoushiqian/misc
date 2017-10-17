#!/bin/bash
old=`cat /tmp/3333  | awk 'NR == 4 {print $2}'`
found_000979=`curl http://hq.sinajs.cn/list=f_000979 2> /dev/null| awk -F, '{print $2}'`
echo -n "000979   " > /tmp/3333
echo "10241.05*$found_000979" | bc >> /tmp/3333

found_000311=`curl http://hq.sinajs.cn/list=f_000311 2> /dev/null| awk -F, '{print $2}'`
echo -n "000311   " >> /tmp/3333
echo "47387.40*$found_000311" | bc >>/tmp/3333

found_501301=`curl http://hq.sinajs.cn/list=f_501301 2> /dev/null| awk -F, '{print $2}'`
echo -n "501301   " >> /tmp/3333
echo "18226.62*$found_501301" | bc >>/tmp/3333



echo -n "total     " >> /tmp/3333

echo "10241.05*$found_000979+47387.40*$found_000311+18226.62*$found_501301" | bc >>/tmp/3333
new=`cat /tmp/3333  | awk 'NR == 4 {print $2}'`
echo -n "change   " >> /tmp/3333
echo "$new-$old" | bc >> /tmp/3333
t1="每日净值 "
t2=`date +%D`
title=${t1}${t2}
cat /tmp/3333 | mailx -s "$title"   test@qq.com

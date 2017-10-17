#!/bin/bash
#adb devices -l | awk 'NR > 1 {print $1}'
#deviceno=0
#read -p "Enter your chose:" deviceno 
#let deviceno++
#device=`adb devices -l | awk -v dev=$deviceno 'NR == dev {print $1}'| awk '{print $1}'`
#echo $device
pwd=`pwd`
echo "$*" | grep shell > /dev/null 2>&1
if [ $? == '0' ];then
	#myadb root > /dev/null 2>&1
	stty -icanon -echo -echoe intr ^0;
	myadb $*
	stty sane
else
	echo "$*" | grep push > /dev/null 2>&1
	if [ $? == '0' ];then
		myadb root > /dev/null 2>&1
		myadb wait-for-device && myadb remount >/dev/null 2>&1
		work_dir=`dirname $2`
		cd $work_dir
		myadb push `basename $2` $3
		cd $pwd
	else
		myadb $*
	fi
fi

#! /bin/sh
#进程名字修改成实际路径
PRO_NAME=/root/workspace/Sync4oss/Debug/Sync4oss
WLAN=ra0
  
while true ; do
  
# 休息10秒以确保要看护的程序运行起来了，这个时间因实际情况而定
  sleep 10
#    用ps获取$PRO_NAME进程数量
  NUM=`ps aux | grep ${PRO_NAME} | grep -v grep |wc -l`
#  echo $NUM
#    少于1，重启进程
  if [ "${NUM}" -lt "1" ];then
    echo "${PRO_NAME} was killed"
	# --> 定向输出当前日期时间到文件，添加到文件尾端，如果没有文件，则创建这个文件
        date >> ./Daemon4Sync.log
	# --> 定向输出信息,添加到文件尾端
        echo "Sync4oss encountered a problem and terminate accidentally! See log for details." >> ./Daemon4Sync.log
    ${PRO_NAME} -i ${WLAN}
#    大于1，杀掉所有进程，重启
  elif [ "${NUM}" -gt "1" ];then
    echo "more than 1 ${PRO_NAME},killall ${PRO_NAME}"
    killall -9 $PRO_NAME
    ${PRO_NAME} -i ${WLAN}
  fi
#    kill僵尸进程
  NUM_STAT=`ps aux | grep ${PRO_NAME} | grep T | grep -v grep | wc -l`
  
  if [ "${NUM_STAT}" -gt "0" ];then
    killall -9 ${PRO_NAME}
    ${PRO_NAME} -i ${WLAN}
  fi
done
  
exit 0

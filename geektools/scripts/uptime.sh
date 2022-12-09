boottime=`sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g'`
unixtime=`date +%s`
timeAgo=$(($unixtime - $boottime))
uptime=`awk -v time=$timeAgo 'BEGIN { hours = int(time / 60 / 60 % 24); days = int(time / 60 / 60 / 24); printf("%.0f days, %.0f hours", days, hours); exit }'`
echo $uptime
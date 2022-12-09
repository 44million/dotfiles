user=`whoami`
h=`date +%H`

if [ $h -lt 12 ]; then
  echo 滋 Goodmorning ${user}!
elif [ $h -lt 18 ]; then
  echo 盛 Good afternoon ${user}!
else
  echo   Goodnight ${user}!
fi

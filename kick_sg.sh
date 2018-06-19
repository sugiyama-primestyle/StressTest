#!/bin/bash
#set -x

MSG1="Usage: ./`basename $0` <同時アクセス数> <リクエスト数> <ヘッダー1or2or3 > <URLリスト> <間隔>"
MSG2="ヘッダー\n1:Content-Type:application/json;charset=utf-8\n2:Content-Type:application/x-www-form-urlencoded\n3:Content-Type:text/html"

#[ $# -lt 3 ] && echo ${MSG} && exit 1

[ "$1" = "-h" ] && echo -e "${MSG1}\n${MSG2}" && exit 0

#同時アクセス数
[ "$1" = ""  ] && CONCURRENT="-c 1" || CONCURRENT="-c $1"

#リクエスト数
[ "$2" = ""  ] && REPS="-r 1" || REPS="-r $2"

# ヘッダー
case $3 in
 1) HEADER="--header=Content-Type:application/json;charset=utf-8";;
 2) HEADER="--header=Content-Type:application/x-www-form-urlencoded";;
 3) HEADER="--header=Content-Type:text/html";;
 *) echo ${MSG} && exit 2
esac

# URLリスト
[ "$4" = ""  ] && URL_LIST="http://localhost/" || URL_LIST="--file=$4"


# 間隔
[ "$5" = ""  ] && DELAY=--delay=1 || DELAY=--delay=$5

echo "command"
echo "siege ${CONCURRENT} ${REPS} ${HEADER} ${URL_LIST} ${DELAY} --log=`date '+%Y%m%d'`_result.log"
echo
date
siege ${CONCURRENT} ${REPS} ${HEADER} ${URL_LIST} ${DELAY} --log=`date '+%Y%m%d'`_result.log

exit 0

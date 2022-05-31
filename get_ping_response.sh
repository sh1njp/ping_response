#!/bin/bash -x

## ping
## ./get_ping_response.sh [table name] [destination] [count]

DB="db4"
HOST="localhost"
ROOM="none"

## table name
NAME="${1}"
## ping destination
DST="${2}"
## ping clount
COUNT="${3}"

RESULT=`fping -c ${COUNT} ${DST} 2>&1 | tail -1`


ping_xmt=`echo ${RESULT} | awk -F"[ /%]" '{print $8}'`
ping_rcv=`echo ${RESULT} | awk -F"[ /%]" '{print $9}'`
ping_loss=`echo ${RESULT} | awk -F"[ /%]" '{print $10}'`
ping_min=`echo ${RESULT} | awk -F"[ /%]" '{print $16}'`
ping_avg=`echo ${RESULT} | awk -F"[ /%]" '{print $17}'`
ping_max=`echo ${RESULT} | awk -F"[ /%]" '{print $18}'`


curl -i -XPOST "http://localhost:8086/write?db=${DB}" \
  --data-binary "${NAME},host=${HOST},room=${ROOM} ping_xmt=${ping_xmt},ping_rcv=${ping_rcv},ping_loss=${ping_loss},ping_min=${ping_min},ping_avg=${ping_avg},ping_max=${ping_max}"

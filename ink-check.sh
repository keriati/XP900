#!/bin/sh

CURL="/usr/bin/curl"
EPSON_URL="https://<PRINTER_IP>/PRESENTATION/HTML/TOP/PRTINFO.HTML"
PUSHGATEWAY_URL="https://<Prometherus Pushgateway URL>/metrics/job/epson_ink_level"

RESPONSE=`$CURL $EPSON_URL -k`

B_LEVEL=`echo "$RESPONSE" | grep -m 1 "IMAGE/Ink_K.PNG" | cut -d " " -f 4 | cut -d "=" -f2 | sed "s/'//g"`
C_LEVEL=`echo "$RESPONSE" | grep -m 1 "IMAGE/Ink_C.PNG" | cut -d " " -f 4 | cut -d "=" -f2 | sed "s/'//g"`
Y_LEVEL=`echo "$RESPONSE" | grep -m 1 "IMAGE/Ink_Y.PNG" | cut -d " " -f 4 | cut -d "=" -f2 | sed "s/'//g"`
M_LEVEL=`echo "$RESPONSE" | grep -m 1 "IMAGE/Ink_M.PNG" | cut -d " " -f 4 | cut -d "=" -f2 | sed "s/'//g"`
PB_LEVEL=`echo "$RESPONSE" | grep -m 2 "IMAGE/Ink_K.PNG" | tail -n1 | cut -d " " -f 4 | cut -d "=" -f2 | sed "s/'//g"`


PAYLOAD="# TYPE ink_level gauge\nink_level{color=\"black\"} $B_LEVEL\nink_level{color=\"cyan\"} $C_LEVEL\nink_level{color=\"yellow\"} $Y_LEVEL\nink_level{color=\"magenta\"} $M_LEVEL\nink_level{color=\"photoblack\"} $PB_LEVEL"

#echo $PAYLOAD
echo $PAYLOAD | $CURL --data-binary @- $PUSHGATEWAY_URL
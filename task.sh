#!/bin/bash
cd /root/dump1090
./dump1090 --interactive --net
ps -eaf | grep dump1090 | grep -v grep
if [ $? -eq 1 ]
then
echo `date "+%G-%m-%d %H:%M:%S"`" dump1090            restart"
echo "------------------------------------------------------------------------"
systemctl restart dump1090-fa
systemctl restart dump1090
systemctl restart dump1090-mutability
else
echo `date "+%G-%m-%d %H:%M:%S"`" dump1090            running"
echo "------------------------------------------------------------------------"
fi

sleep 10
ps -eaf | grep dump1090 | grep -v grep
if [ $? -eq 1 ]
then
echo `date "+%G-%m-%d %H:%M:%S"`" dump1090            restart"
echo "------------------------------------------------------------------------"
sleep 10
else
echo `date "+%G-%m-%d %H:%M:%S"`" dump1090            running"
echo "------------------------------------------------------------------------"
fi

ps -eaf | grep send_message.py | grep -v grep
# if not found - equals to 1, start it
if [ $? -eq 1 ]
then
python -O /root/get_message/send_message.py &
echo `date "+%G-%m-%d %H:%M:%S"`" send_message            restart"
echo "------------------------------------------------------------------------"
else
echo `date "+%G-%m-%d %H:%M:%S"`" send_message            running"
echo "------------------------------------------------------------------------"
fi

ps -eaf | grep get_ip.py | grep -v grep
# if not found - equals to 1, start it
if [ $? -eq 1 ]
then
python /root/get_message/get_ip.py
echo `date "+%G-%m-%d %H:%M:%S"`" get_ip            restart"
echo "------------------------------------------------------------------------"
else
echo `date "+%G-%m-%d %H:%M:%S"`" get_ip            running"
echo "------------------------------------------------------------------------"
fi


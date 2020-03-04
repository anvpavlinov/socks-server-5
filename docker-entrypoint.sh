#!/bin/bash

if [ `id -u` -ge 10000 ]; then
	cp /etc/passwd /tmp/passwd
	cat /tmp/passwd | sed -e "s/^ss5:.*$/ss5:x:`id -u`:`id -g`::\/home\/ss5:\/sbin\/nologin/g" > /etc/passwd
	rm /tmp/passwd
	chown -R ss5:root /var/log/ss5
	chown -R ss5:root /var/run/ss5
fi

ss5 -t -u ss5

trap "kill `cat /var/run/ss5/ss5.pid`; exit" KILL INT

"$@"

wait

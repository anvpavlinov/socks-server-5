#!/bin/bash

ss5 -t 

trap "kill `cat /var/run/ss5/ss5.pid`; exit" KILL INT

"$@"

wait

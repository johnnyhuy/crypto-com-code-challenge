#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
N='\033[0m'

if [ ! -f ./access.log ]; then
    echo -e "${Y}Access log does not exist, unzipping...${N}"
    gunzip -qq -k access.log.gz
fi

echo -e "Top 10 hosts in access.log are:"
echo -e "$G"
echo -e "    Requests | Host\n"

# Lazy grep the first section of the line and sort by unique count
# Then reverse sort and grab the top 10
grep -o -E "^[0-9\.\:A-z]+" ./access.log | sort | uniq -c | sort -r  | head -n 10

echo -e "$N"

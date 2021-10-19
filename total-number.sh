#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
N='\033[0m'

if [ ! -f ./access.log ]; then
    echo -e "${Y}Access log does not exist, unzipping...${N}"
    gunzip -qq -k access.log.gz
fi

# Look for the most common pattern in a line - lazy grep
# Include both IPv4 and IPv6
count=$(grep -E "[0-9\.\:A-z]+\s\-\s(\-|[A-z]+)" ./access.log | wc -l)

echo -e "Total number of requests in access.log is ${G}$count${N}"

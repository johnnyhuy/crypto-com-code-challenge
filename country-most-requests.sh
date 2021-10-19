#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
N='\033[0m'

if [ ! -f access.log ]; then
    echo -e "${Y}Access log does not exist, unzipping...${N}"
    gunzip -qq -k access.log.gz
fi

if [ -f country-requests.log ]; then
    echo -e "${Y}Country requests log exists, clearing to reprocess data...${N}"
    rm -f country-requests.log
fi

echo -e "${Y}Processing data...${N}"
while read line; do
    whois $(echo $line | grep -o -E "^[0-9\.\:A-z]+") | grep -iE ^country: | awk '{print $2}' | tail -n 1 >> country-requests.log
done < access.log

top_country=$(cat country-requests | sort | uniq -c | sort -r  | head -n 1)

echo -s "Top country with the most requests is ${G}${top_country}${N}"

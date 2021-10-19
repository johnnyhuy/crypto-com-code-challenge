#!/bin/bash

Y='\033[0;33m'
G='\033[0;32m'
N='\033[0m'

if [ ! -f access.log ]; then
    echo -e "${Y}Access log does not exist, unzipping...${N}"
    gunzip -qq -k access.log.gz
fi

# Clear the log file if it rerun it
if [ -f country-requests.log ]; then
    echo -e "${Y}Country requests log exists, clearing to reprocess data...${N}"
    rm -f country-requests.log
fi

# Do a whois and get the country
# Pipe country names into a temporary file
echo -e "${Y}Processing data...${N}"
while read line; do
    whois $(echo $line | grep -o -E "^[0-9\.\:A-z]+") | grep -iE ^country: | awk '{print $2}' | tail -n 1 >> country-requests.log
done < access.log

# Do sorting to get the count of each country
# Get the most requested country
top_country=$(cat country-requests.log | sort | uniq -c | sort -r  | head -n 1 | grep -o -E "[A-z]+$")

echo -e "Top country with the most requests is ${G}${top_country}${N}"

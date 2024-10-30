#!/bin/bash

COUNT=10

echo -e "\n=== TOP ${COUNT} IP ADDR - HIGH REQUEST ===\n"
awk '{print $1}' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} PATH MOST REQUESTED ===\n"
awk '{print $7}' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} STATUS CODE ===\n"
grep -oE ' [1-5][0-9]{2} ' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNTS} USER AGENTS ===\n"
awk -F'"' '{print $6}' nginx-access.log | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNT

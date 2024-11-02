#!/bin/bash

COUNT=10
PATHL=/home/matutev/gitclones/devops/nginx-log-analyser/nginx-access.log

echo -e "\n=== TOP ${COUNT} IP ADDR - HIGH REQUEST ===\n"
awk '{print $1}' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} PATH MOST REQUESTED ===\n"
awk '{print $7}' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} STATUS CODE ===\n"
grep -oE ' [1-5][0-9]{2} ' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNTS} USER AGENTS ===\n"
awk -F'"' '{print $6}' $PATHL | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNT

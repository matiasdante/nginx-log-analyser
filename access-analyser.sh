#!/bin/bash
echo "=== ADD NGINX LOG PATH ==="
read PATHL

if [[ ! -f "$PATHL" ]]; then
    echo "ERROR: The file doesn't exist."
    exit 1
fi

echo "=== HOW MANY RESULTS? ==="
read COUNT

if ! [[ "$COUNT" =~ ^[0-9]+$ ]] || [[ "$COUNT" -le 0 ]]; then
  echo "ERROR: Cant be a float number or a string"
  exit 1
fi

echo -e "\n=== TOP ${COUNT} IP ADDR - HIGH REQUEST ===\n"
awk '{print $1}' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} PATH MOST REQUESTED ===\n"
awk '{print $7}' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNT} STATUS CODE ===\n"
grep -oE ' [1-5][0-9]{2} ' $PATHL | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNT}

echo -e "\n=== TOP ${COUNTS} USER AGENTS ===\n"
awk -F'"' '{print $6}' $PATHL | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNT

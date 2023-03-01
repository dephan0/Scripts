#!/usr/bin/env bash
set -eo pipefail

PRINTER_IP='192.168.1.26'
response=$(curl -s --connect-timeout 3 "http://${PRINTER_IP}/etc/mnt_info.csv")
NF=$(printf '%s' "$response" | head -n 1 | awk -F, '{ print NF - 1 }') # number of fields
first_line=$(printf '%s' "$response" | head -n 1 | tr -d \")
second_line=$(printf '%s' "$response" | tail -n 1 | tr -d \")

for i in $(seq $NF); do
    printf '%s' "${first_line}" | awk -F, -v i=$i '{ printf "%s : ", $i }'
    printf '%s' "${second_line}" | awk -F, -v i=$i '{ printf "%s\n", $i }'
done

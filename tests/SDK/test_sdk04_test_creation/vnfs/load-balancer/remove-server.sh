#!/bin/bash

ip=$1
echo "show servers state" | socat stdio /var/run/hapee-lb.sock | while IFS= read -r line
do
  current_ip=$(echo "$line" | cut -d" " -f6)
  if [ "$ip" == "$current_ip" ]; then
    server_name=$(echo "$line" | cut -d" " -f4)
    echo "set server webservers/${server_name} state maint" | socat stdio /var/run/hapee-lb.sock
    exit 0
  fi
done
if [[ $? -eq 0 ]]; then
    exit 0
else
    exit 1
fi


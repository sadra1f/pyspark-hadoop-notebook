#!/bin/bash

sed -e 's/127\.0\.0\.[0-9].*/#&/g' /etc/hosts 1>/tmp/.temp-hosts &&
    cat /tmp/.temp-hosts >/etc/hosts &&
    rm /tmp/.temp-hosts

exec "$@"

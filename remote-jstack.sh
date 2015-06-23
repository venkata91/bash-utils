#!/bin/bash remote-jstack.sh

ssh root@$1 jstack -l -F $2 | tee $3


#!/bin/bash
echo "Grepping for the string --> $1"
for i in `find . -name "*.jar"`; do echo $i; jar tvf $i | grep -i "$1"; done

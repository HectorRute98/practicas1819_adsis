#!/bin/bash
if [ $(id -u) -eq 0 ];then
  echo "BIEN!"
  exit 0
else 
  echo "MAL"
  exit 1
fi

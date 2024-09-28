#! /bin/bash
while [ true ]
do
    curl http://kcdporto.demo.diegomarques.dev -s | grep "Welcome from"
    sleep 2
done
#!/bin/bash


sleep 120;
response=$(curl -s -w "\n%{http_code}" http://10.0.0.4/clickCount/rest/healthcheck)
response=(${response[@]})
if [ ${response[0]} == "ok" ]; then
echo “Success”
else
exit 1 
fi
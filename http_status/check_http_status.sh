#!/bin/bash

function show_usage(){
        echo "Usage: check_http_status <site-url>"
}

if [[ $# -ne 1 ]]; then
        show_usage
        exit 0
fi

site=$1

response=$(
    curl $site \
        --write-out %{http_code} \
        --silent \
        --output /dev/null \
)

if [[ $response -ge 400 ]]; then
	#statements
	echo "CRITICAL - $response"
	exit 2
elif [[ $response -ge 300 && $response -lt 400 ]]; then
	#statements
	echo "WARNING - $response"
	exit 1
elif [[ $response -lt 300 && $response -gt 0  ]]; then
	#statements
	echo "OK - $response"
else
	echo "UNKNOWN- $response"
exit 3

fi
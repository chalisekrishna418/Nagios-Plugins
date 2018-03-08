#!/bin/bash

function show_usage(){
        echo "Usage: show_mem <host> <snmp_version> <comunity_string>"
}

if [[ $# -ne 5 ]]; then
        show_usage
        exit 0
fi

host=$1
snmp_version=$2
community_string=$3
warning_level=$4
critical_level=$5

total_ram_oid=.1.3.6.1.4.1.2021.4.5.0
free_ram_oid=.1.3.6.1.4.1.2021.4.6.0

total_ram=`/usr/local/nagios/libexec/check_snmp -H $host -P $snmp_version -C $community_string -o $total_ram_oid | cut -f 4 -d " " | sed 's/[^0-9]*//g'`
free_ram=`/usr/local/nagios/libexec/check_snmp -H $host -P $snmp_version -C $community_string -o $free_ram_oid | cut -f 4 -d " " | sed 's/[^0-9]*//g'`

used_ram=$[ total_ram - free_ram ]
used_ram_percent_raw=$[ used_ram * 100 ]
used_ram_percent=$[ used_ram_percent_raw / total_ram ]

if [[ $used_ram_percent -ge $critical_level ]]; then
	#statements
	echo "CRITICAL - $used_ram_percent"
	exit 2
elif [[ $used_ram_percent -ge $warning_level ]]; then
	#statements
	echo "WARNING - $used_ram_percent"
	exit 1
elif [[ $used_ram_percent -gt 0 && $used_ram_percent -lt $warning_level ]]; then
	#statements
	echo "OK - $used_ram_percent"
else
	echo "UNKNOWN- $used_ram_percent"
exit 3

fi

git.ebpearls.com 2c upUXMlLBMOPGgmlK 40 100
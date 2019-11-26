#!/bin/bash
date=$(date +%d%m%Y-%H%M)
div="**************************"
echo "Ports and connections analysis"
lsusb > ports_$date.txt
lspci > pci_$date.txt

echo "UDP/TCP connections"
netstat -t -u -l > active_ports_$date.txt

echo "Interface list"
netstat -i > interfaces_$date.txt

echo "Route tables"
netstat -r > routetable_$date.txt

echo "Host analysis"
host_name=$(cat /etc/hostname)
host_o=$(cat /etc/hosts)
echo "$host_name \n $div \n $host_o" > host_info_$date.txt

echo "System analysis"
info_os=$(lsb_release -a)
linux_version=$(cat /proc/version)
info_cpu=$(lscpu)
echo "$info_so \n $div \n $linux_version $div \n $info_cpu" > systeminfo_$date.txt

echo "Scheduled tasks"
for user in $(cut -f1 -d : /etc/passwd); do
	s=$(crontab -u $user -l);
	echo "$user \n $s $div" >> schd_tasks_$date.txt;
done

echo "Directory Analysis"
ls -ltcR / > dir_list_mod_time_$date.txt

echo "Environment variables"
printenv > env_var_$date.txt

echo "IPConfig"
ifconfig > ifconfig_$date.txt
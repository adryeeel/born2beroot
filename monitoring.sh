#!bin/bash

echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(lscpu | grep 'Socket(s):' | awk '{print $2}')"
echo "#vCPU : $(nproc --all)"
echo "#Memory Usage: $(free -m | awk 'BEGIN { FS = " "; }; NR == 2 { printf("%d/%dMB (%.2f%%)", $3, $2, $3/$2 * 100) }')"
echo "#Disk Usage: $(df -BM | awk 'BEGIN { disk_size = 0; disk_usage }; NR > 1 { disk_size += $2; disk_usage += $3 } END { printf("%d/%.0fGb (%.2f%%)", disk_usage, disk_size / 1024, disk_usage / disk_size * 100) }')"
echo "#CPU load: $(top -n 1 -b | grep 'Cpu(s)' | awk '{ printf("%.1f%%", $2) }')"
echo "#Last boot: $(who -b | awk '{print $3, $4}')"

if (which lvdisplay > /dev/null) then
	echo "#LVM use: yes"
else
	echo "#LVM use: no"
fi

echo "#Connections TCP : $(ss | awk 'BEGIN { count = 0 } $1 == "tcp" { count += 1 } END { print count , "ESTABLISHED" }')"
echo "#User log: $(who | wc -l)"
echo "#Network: $(ip addr show scope global | awk 'BEGIN { mac = ""; ip = "" } /inet / {split($2, ipArr, "/"); ip = ipArr[1] }; /ether/ { mac = $2 } END { printf("IP %s (%s)", ip, mac) }')"
echo "#Sudo : $((36#$(cat /var/log/sudo/seq))) cmd"

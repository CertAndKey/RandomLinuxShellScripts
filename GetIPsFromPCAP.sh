#!/bin/bash


if [ $# -eq 0 ];
then
  echo "please supply a file"
  echo "EXAMPLE: ./GetIPsFromPCAP.sh file.txt"
  exit 1
elif [ $2 ];
then
  echo "Too many arguments: $@"
  echo "EXAMPLE: ./GetIPsFromPCAP.sh file.txt"
  exit 1
fi

tshark -r $1 -T fields -e ip.addr > ips.txt
sort ips.txt | uniq > ips_no_dupe.txt
#sed -i 's/<ip_to_filter>//g' ips_no_dupe.txt
sed -i 's/,//g' ips_no_dupe.txt
rm ips.txt
sort ips_no_dupe.txt | uniq > ips.txt
rm ips_no_dupe.txt
cat ips.txt
rm ips.txt

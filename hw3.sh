#!/bin/bash

# Problem 1

echo 2.1 Average Packet Size
cut -d "," -f5,6 --output-delimiter " " flow.csv | awk '{packets+=$1; bytes+=$2}; END {print "AVG: "bytes/packets"bytes per packets"}'

# Problem 2



echo 2.2.1 Duration
tail -n +2 flow.csv |cut -d "," -f7,8 --output-delimiter " " | 
	awk '{start=$1; end=$2}; {print end-start}' > "p2.csv"

sort -n p2.csv | uniq -c > aaa.csv

cut -d "," -f2,3 --output-delimiter " " aaa.csv | 
		awk '{count+=$1; duration=$2; print count/873733, duration}' | tr " " , > "fin2_2_1.csv"

#fin2_2_1.csv is plotted via gnuplot

#rm aaa.csv
#rm p2.csv

echo 2.2.2 Size

# output flow durations into a csv, do a uniq -c to count all unique number of octets
# then plot

tail -n +2 flow.csv | cut -d "," -f5,6  --output-delimiter " " |
	awk '{pkt=$1; bytes=$2; print bytes*pkt}' | tr " " , > "p22size.csv"

sort -n p22size.csv | uniq -c | cut -d "," -f2,3 --output-delimiter " " |
	awk '{count+=$1; size=$2; print count/873733, size}' | tr " " , > "fin2_2_2.csv"

#fin2_2_2.csv is plotted

#rm p22size.csv

echo 2.3: Traffic Summary

echo Top 10 Source Ports
echo    " port     bytes"

tail -n +2 flow.csv | cut -d "," -f5,6,16 --output-delimiter " " |\
	awk '{thing[$3]+=$1*$2}; END\
			{for ( i in thing )
				print i, thing[i]
			}' | sort -nr -k2 | head -n 10 | column -t


echo Top 10 Receiver Ports
echo    " port     bytes"

tail -n +2 flow.csv | cut -d "," -f5,6,17 --output-delimiter " " |\
	awk '{thing[$3]+=$1*$2}; END\
			{for ( i in thing )
				print i, thing[i]
			}' | sort -nr -k2 | head -n 10 | column -t

echo 2.4 Aggregate the traffic volumes based on the source IP prefix
# 5:dpkts, 6:doctets, 11:srcaddr, 21:src_mask

#tail -n +2 flow.csv | cut -d "," -f5,6,11,21 --output-delimiter " " | head -n 600 |
#	awk '{ip=$3"/"$4; print ip,$1*$2}' |
#	awk '{cmd="ipcalc -n "$1;
#			cmd | getline result;
#			close(cmd)
#			print result","$2}' | sed -r s/^.{8}// > bbb.csv

	awk -F, '{Arr[$1]+=$2; total+=$2}; END {for (i in Arr) print i" "Arr[i]}' bbb.csv | sort -k 2 -nr -b | tr " " , |
	awk -F, '{print $1","$2*100/2385611441856}' temp.csv > result2_4.csv
	
	# 2385611441856 is the number of bytes overall

	echo top 0.1 percent
	cut -d "," -f1,2 --output-delimiter " " result2_4.csv | head -n 3 | 
		awk '{total+=$2} END{print total " percent of total traffic"}'
	echo top 1 percent
	cut -d "," -f1,2 --output-delimiter " " result2_4.csv | head -n 33 | 
		awk '{total+=$2} END{print total " percent of total traffic"}'
	echo top 10 percent
	cut -d "," -f1,2 --output-delimiter " " result2_4.csv | head -n 329 | 
		awk '{total+=$2} END{print total " percent of total traffic"}'

echo 2.5 WSU Traffic

	cut -d "," -f1,2 --output-delimiter " " result2_4.csv |
		awk '{if ($1==134.121.0.0) print "wSU: "$2 " percent of total traffic"}'

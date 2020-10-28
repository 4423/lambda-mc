#!/bin/sh
# ./test.sh > result.csv 2>&1

echo "n,gentime,exectime,memsize"

i=0
while [ $i -lt 11 ]
do
	n=0
	while [ $n -lt 101 ]
	do
		echo -n $n,
		(/usr/bin/time -f ',%M' ./bench.out $n)
		n=`expr $n + 1`
	done
	i=`expr $i + 1`
done
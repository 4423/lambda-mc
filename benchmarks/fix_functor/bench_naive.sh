#!/bin/sh

rm result.txt

for n in `seq 0 10`
do
    # prepare result file
    RESULT_FILE=result$n.txt
    rm $RESULT_FILE
    echo -n '' > $RESULT_FILE
    # 1. num of functor apllication
    # 2. execution time of generated code [s]
    # 3. memory usage [KB]
    
    # compile translated code
    make naive

    for i in `seq 0 100`
    do
        echo $n "-" $i
        
        # run bench
        echo $i | tr '\n' '\t' >> $RESULT_FILE
        /usr/bin/time -f '%M' ./bench.out $i 2>&1 | tr '\n' '\t' >> $RESULT_FILE
        echo '' >> $RESULT_FILE
    done

    # clean
    make clean
done

# calculate the average and output as result.txt
python3 avg.py
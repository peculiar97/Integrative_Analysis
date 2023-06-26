#!/bin/bash
for i in idr_ind/*;
do
    samp=`basename ${i%_idr*}`;
    echo "Processing sample ${samp}";
    #mkdir -p  ${samp};
    cd ${samp};
    for j in ../Exprs/*;
    do 
        exp=`basename ${j%.csv}`;
        mkdir -p ${samp}_${exp};
        BETA basic  -p ../$i -e $j -k O -g hg38 -n ${samp}_${exp}  --info 1,2,3 --da 1 -c 0.9 -o ${samp}_${exp} > screen_${samp}_${exp}.txt \
        2>&1;
        echo "........Checking for Genes in ${samp}_${exp}";
        if grep "IRF1"  ${samp}_${exp}/${samp}_${exp}_uptarget.txt; then
            echo "*********Found IRF1*******"
        else
            echo "********* NO IRF1 *******"
        fi
        if grep -E "IRF9|STAT[0-9]" ${samp}_${exp}/${samp}_${exp}_uptarget.txt; then
            echo  "********Found IRF9 or STAT******"
        fi
        echo "Finished ${samp}_${exp%_LRT*}";
    done;
    cd ..;
done

#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N jobName
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q phylo
#$ -pe fill 1
#$ -P communitycluster

x=0
while [ $x -le 100]
do

    echo $x
    x=$(($x+1)
    sleep 1

done


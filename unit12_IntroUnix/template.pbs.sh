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




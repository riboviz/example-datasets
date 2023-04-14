#!/bin/bash -ue
cutadapt --trim-n -O 1 -m 5 -a AGATCGGAAGAGCACACGTCTGAA             -o LK_S3_L001_R1_001_init10000_trim.fq LK_S3_L001_R1_001_init10000.fastq -j 0

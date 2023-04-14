#!/bin/bash -ue
hisat2 --version
hisat2 -p 1 -N 1 -k 1             --un nonrRNA.fq --no-unal             -x yeast_rRNA             -S rRNA_map.sam -U Rep2.fq

#!/bin/bash -ue
hisat2 --version
hisat2 -p 1 -k 2 --no-spliced-alignment --rna-strandness F --no-unal             --un unaligned.fq -x yeast_CDS_w_250             -S orf_map.sam -U nonrRNA.fq

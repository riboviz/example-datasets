#!/bin/bash -ue
python -m riboviz.tools.demultiplex_fastq             -1 LK_S3_L001_R1_001_init10000_extract_trim.fq -s EIRNA_2023_barcodes.tsv -o . -m 2

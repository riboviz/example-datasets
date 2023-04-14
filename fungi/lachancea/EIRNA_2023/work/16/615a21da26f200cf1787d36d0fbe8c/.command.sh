#!/bin/bash -ue
samtools --version
samtools view -b orf_map_clean.sam | samtools sort              -@ 1 -O bam -o orf_map_clean.bam -
samtools index orf_map_clean.bam

#!/bin/bash -ue
umi_tools dedup -I orf_map_clean.bam -S dedup.bam --output-stats=dedup_stats
samtools --version
samtools index dedup.bam

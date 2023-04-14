#!/bin/bash -ue
bedtools --version
bedtools genomecov -ibam Rep1.bam -trackline -bga -5             -strand + > plus.bedgraph
bedtools genomecov -ibam Rep1.bam -trackline -bga -5             -strand - > minus.bedgraph

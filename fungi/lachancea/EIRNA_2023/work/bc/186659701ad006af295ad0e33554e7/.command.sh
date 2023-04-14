#!/bin/bash -ue
bedtools --version
bedtools genomecov -ibam Rep3.bam -trackline -bga -5             -strand + > plus.bedgraph
bedtools genomecov -ibam Rep3.bam -trackline -bga -5             -strand - > minus.bedgraph

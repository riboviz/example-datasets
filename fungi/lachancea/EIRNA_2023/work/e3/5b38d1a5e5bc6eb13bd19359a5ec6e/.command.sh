#!/bin/bash -ue
Rscript --vanilla /exports/csce/eddie/biology/groups/wallace_rna/riboviz-david/riboviz/riboviz/rscripts/generate_stats_figs.R            --num-processes=1            --min-read-length=10            --max-read-length=50            --buffer=250            --primary-id=Name            --dataset=EIRNA_2023_LK_down            --hd-file=Rep2.h5            --orf-fasta-file=lachancea_kluyveri_cds_250nt_utr.fasta            --output-pdfs=true            --rpf=true            --output-dir=.            --output-metagene-normalized-profile=true            --t-rna-file=yeast_tRNAs.tsv            --codon-positions-file=yeast_codon_pos_i200.RData            --features-file=yeast_features.tsv            --orf-gff-file=lachancea_kluyveri_cds_250nt_utr.gff3            --asite-disp-length-file=yeast_standard_asite_disp_length.txt            --count-threshold=64

#!/bin/sh

#$ -P bio_wallace_rna_riboviz
#$ -N riboviz_lachancea_kluyveri
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 16
#$ -o $JOB_NAME-$JOB_ID-$HOSTNAME.o
#$ -e $JOB_NAME-$JOB_ID-$HOSTNAME.e



. /etc/profile.d/modules.sh

#!/usr/bin/env bash
export R_LIBS=/exports/csce/eddie/biology/groups/wallace_rna/Rlibrary_ICP
module load openmpi
module load igmm/apps/BEDTools
module load igmm/apps/bowtie
module load igmm/apps/hdf5
module load igmm/apps/HISAT2
module load igmm/apps/pigz
module load igmm/apps/R/4.1.3
module load anaconda
source activate riboviz

echo "Running riboviz on dataset: EIRNA_2023"


# presuming I'm in correct branch on riboviz

# move back up to riboviz folder (or nextflow won't run)
cd /exports/csce/eddie/biology/groups/wallace_rna/riboviz-david/riboviz/riboviz
echo "now in folder: ${PWD} ready to run"

# presuming .yaml config exists in $HOME/riboviz/riboviz/EIRNA_2023 AND it points to EIRNA_2023/input for files as required

# run nextflow validation:
nextflow run prep_riboviz.nf -params-file ../example-datasets/fungi/lachancea/EIRNA_2023_LK_3-samples_cds_250nt_utr_config.yaml -work-dir EIRNA_2023/work -ansi-log false --validate_only

# run nextflow:
nextflow run prep_riboviz.nf -params-file ../example-datasets/fungi/lachancea/EIRNA_2023_LK_3-samples_cds_250nt_utr_config.yaml -work-dir EIRNA_2023/work -ansi-log false

# hopefully success.
echo "nextflow riboviz EIRNA_2023 data run complete"

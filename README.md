# example-datasets - Example datasets to run with RiboViz.

This repository is for the configuration files and genome/annotation files needed to run the [riboviz](https://github.com/riboviz/riboviz) ribosome profiling pipeline on specific datasets. It aims to:

* provide specific example datasets for new users to try or to adapt
* share up-to-date tested example datasets between the riboviz development team

The main riboviz repository contains documentation of how to run riboviz in general.

## Start here

_This section will contain suggestions of example datasets to start with._

# What belongs in example-datasets

* config.yaml files that describe all parameters for the riboviz run
* trancriptome or ORFeome files needed:
  * .fasta files of transcript/extended-ORF sequences
  * .gff files that describe the CDS/ORF position within the fasta file 
* .fasta files of contaminants to exclude (rRNA, tRNA, etc)

Generally, the transcriptome fasta/gff files and contaminant fasta files would be referred to by multiple config.yaml files in the same species.

# What does not belong here

* read files, which are too big
  * fastq or fastq.gz
  * bam, sam, etc
* genome fasta files. Instead, please refer to a genome build or link to the file.
  * genome-centric gffs also probably do not belong here
* processed data files such as riboviz outputs
* everything else not specifically listed in "what belongs in example-datasets"

Please open an issue on github if there is something we have overlooked.

**Caution:** any repository should not exceed 1GB in size. GitHub's [What is my disk quota?](https://help.github.com/en/github/managing-large-files/what-is-my-disk-quota) comments "If your repository exceeds 1GB, you might receive a polite email from GitHub Support requesting that you reduce the size of the repository to bring it back down."

# Repository structure is loosely phylogenetic

The repository is organised roughly phylogenetically into subfolders, and then example datasets yaml files for each species are in the same folder, with fasta/gff files in a subfolder `annotation`.

We have organised the repository into top-level folders with kingdoms, and then within that organised by genus (e.g. `/fungi/neurospora`, `/animalia/homo`). Kingdom and genus names are *all lower case* to avoid confusion with weblinks. When we set up the repository, this seemed to provide a useful compromise providing human readability and easy navigability.

For example, for re-analysis of the yeast meiosis dataset from Brar 2012: are in `fungi/saccharomyces`:

* `fungi/saccharomyces/Brar_2012_Meiosis_allRPF_transcriptome_config.yaml`
* `fungi/saccharomyces/annotation` for the gff and fasta files (needs elaboration)

## Top-level directories are kingdoms, with an artificial one for simulated data

Each of these directories contains a README.md file with more detailed information

### animalia

animals (humans, mice, flies, worms, etc.)

### archaea

Not populated until we become aware of a published archaeal ribosome profiling dataset

### bacteria

eubacteria

### fungi 

yeasts, mushrooms, moulds, etc.

### plantae

cress, grasses, trees, etc.

### protista

eukaryotes that aren't animals, plants, or fungi (toxoplasma, plasmodium, etc).

This may be convenient, despite protista being a dated and polyphyletic category.
Please file a github issue to suggest a change.

### simulated

artificial datasets that don't come from a complete real genome


# Submitting an example dataset - DRAFT

## config.yaml

## annotation files

## pull request

# example-datasets - Example datasets to run with RiboViz.

This repository is for the configuration files and genome/annotation files needed to run the [riboviz](https://github.com/riboviz/riboviz) ribosome profiling pipeline on specific datasets. It aims to:

* provide specific example datasets for new users to try or to adapt
* share up-to-date tested example datasets between the riboviz development team

The main riboviz repository contains documentation of how to run riboviz in general.

# Table of contents

* [Start here - DRAFT](#starthere)
* [Contents and structure of example-datasets](#contentsstructure)
* [How to submit an example dataset](#howtosubmit)


<a name="starthere"/>
# Start here - DRAFT

_This section will contain suggestions of example datasets to start with._


<a name="contentsstructure"/>
# Contents and structure of example-datasets

## What belongs in example-datasets

* config.yaml files that describe all parameters for the riboviz run
* trancriptome or ORFeome files needed:
  * .fasta files of transcript/extended-ORF sequences
  * .gff files that describe the CDS/ORF position within the fasta file 
* .fasta files of contaminants to exclude (rRNA, tRNA, etc)

Generally, the transcriptome fasta/gff files and contaminant fasta files would be referred to by multiple config.yaml files in the same species.

## What does not belong here

* read files, which are too big
  * fastq or fastq.gz
  * bam, sam, etc
* genome fasta files. Instead, please refer to a genome build or link to the file.
  * genome-centric gffs also probably do not belong here
* processed data files such as riboviz outputs
* everything else not specifically listed in "what belongs in example-datasets"

Please open an issue on github if there is something we have overlooked.

**Caution:** any repository should not exceed 1GB in size. GitHub's [What is my disk quota?](https://help.github.com/en/github/managing-large-files/what-is-my-disk-quota) comments "If your repository exceeds 1GB, you might receive a polite email from GitHub Support requesting that you reduce the size of the repository to bring it back down."

## Repository structure is loosely phylogenetic

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

archaea (Sulfolobus, Thermococcus, etc.)

### bacteria

eubacteria (E.coli, B. subtilis, etc)

### fungi 

yeasts, mushrooms, moulds, etc.

### plantae

cress, grasses, trees, etc.

### protista

eukaryotes that aren't animals, plants, or fungi (toxoplasma, plasmodium, etc).

This may be convenient, despite protista being a dated and polyphyletic category.
Please file a github issue to suggest a change.

### simulated

Artificial datasets that don't come from a complete real genome.


<a name="howtosubmit"/>
# How to submit an example dataset

We request that example datasets are submitted when they have been tested thoroughly, i.e. riboviz runs on the example dataset on relevant .fastq-format data. Please submit by forking the repository, and putting in a pull request for that contains only:

* config.yaml files that describe all parameters for the riboviz run, and IF NEEDED:
* trancriptome or ORFeome files needed:
  * .fasta files of transcript/extended-ORF sequences
  * .gff files that describe the CDS/ORF position within the fasta file 
* .fasta files of contaminants to exclude (rRNA, tRNA, etc)

The .fasta/.gff files would **not** be needed if example-datasets already had an analysis of another dataset on the same transcriptome, so please check first.


## config.yaml

The `config.yaml` file should contain **all** parameters needed to run riboviz. This is described in [prep-riboviz-config.md](https://github.com/riboviz/riboviz/blob/master/docs/user/prep-riboviz-config.md).

If your example dataset runs riboviz on published data in archives such as GEO/SRA/ENA, please ensure that config.yaml fastq filenames correspond to the accession numbers of the relevant SRA/ENA files.

Please begin the `config.yaml` with a `provenance` entry providing metadata on the riboviz run, the authors, the data source, and the version of riboviz that ran on the dataset, for example:

```
provenance:
  authors:
  - author: John Smith III
    email: John.Smith.III@ed.ac.uk
  - author: ...
    email: ...
  website: https://www.ed.ac.uk/some-bio-project
  date: 2020-04-01
  riboviz-version: TAG | COMMIT
  reference: Genome-Wide Analysis in Vivo of Translation with Nucleotide Resolution Using Ribosome Profiling, Ingolia et al 2009
  DOI: 10.1126/science.1168978
  notes: >
    Re-analysis of data from Ingolia 2009 to an updated yeast transcriptome.
```

We are currently (May 2020) reviewing the format of this in issue [#riboviz166](https://github.com/riboviz/riboviz/issues/166), so the format may change.

## annotation files

Annotation files (.fasta files of transcript/extended-ORF sequences, .gff files that describe the CDS/ORF position within the fasta file), should ideally be checked with [check_fasta_gff.py](https://github.com/riboviz/riboviz/blob/master/riboviz/check_fasta_gff.py), which currently checks if start and stop codons are as expected. You can submit files with non-ATG start codons or in-frame stops if you have good reason to do so, `check_fasta_gff.py` is a diagnostic not a prescription. 

We are currently working on improving specification and testing for annotation files, see [#riboviz174](https://github.com/riboviz/riboviz/issues/74).

## contaminant files 

This is a .fasta-format file of everything that you want ignored in the downstream riboviz analysis. It will generally encompass ribosomal rRNA from your species of interest, perhaps also transfer RNA and other abundant non-coding RNA sequences.

## pull request

When your example dataset is complete, please put in a pull request to the master branch and we will review.

We aim to implement automatic checking using the configuration validation option for nextflow, see issue [#riboviz172](https://github.com/riboviz/riboviz/issues/172).


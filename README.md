# Example datasets to run with RiboViz.

This **example-datasets** repository is for the configuration files and genome/annotation files needed to run the [riboviz](https://github.com/riboviz/riboviz) ribosome profiling pipeline on specific datasets. It aims to:

* provide specific example datasets for new users to try or to adapt
* share up-to-date tested example datasets between the riboviz development team

The main riboviz repository contains documentation of how to run riboviz in general.

# Table of contents

* [Start here](#starthere)
* [Contents and structure of example-datasets](#contentsstructure)
* [How to submit an example dataset](#howtosubmit)


<a name="starthere"/>

# Start here

Start by installing riboviz ([installation instructions](https://github.com/riboviz/riboviz/blob/master/docs/user/install.md)), and test that it works by [running the vignette](https://github.com/riboviz/riboviz/blob/master/docs/user/run-vignette.md).

To use one of these example datasets, you need to download two kinds of files.
First, the configuration files and annotation files from this example-datasets repository, which you can download individually from github or by `git clone`.
See [documentation on configuration files](https://github.com/riboviz/riboviz/blob/master/docs/user/prep-riboviz-config.md) for the details.
Second, you need to download the raw read data in fastq, or gzipped fastq, format.
A few of the datasets have specific links to download data in the header of the configuration files. 
Most datasets here have fastq filenames that begin "SRR", indicating that they are stored on the [short read archive (SRA)](https://www.ncbi.nlm.nih.gov/sra) and mirrored on the [european nucleotide archive (ENA)](https://www.ebi.ac.uk/ena/).

We are planning to add functionality to riboviz for direct download from SRA/ENA, but for now you have to follow their instructions on downloading data prior to running riboviz.

## A small simulated dataset

Simulated data can be useful to test that code is working properly because it has "known" size and behaviour.
We have some example simulated data that you can run using [simulated/mok/Mok-simYAL5_config.yaml](simulated/mok/Mok-simYAL5_config.yaml).
The description and a download link to the (7.4MB) fastq files are found in the configuration file.
This uses 5 genes from _S. cerevisiae_ yeast.

## A medium-sized real dataset

We recommend trying a 6-sample example from _S. cerevisiae_ yeast, [Brar_2012_Meiosis_RPF_6-samples_CDS_w_250utrs_config.yaml](/fungi/saccharomyces/Brar_2012_Meiosis_RPF_6-samples_CDS_w_250utrs_config.yaml).
Budding yeast has a small 6000-gene genome so this is a friendly size of dataset to start.
These data are a subset of 6 samples from the paper [High-resolution View of the Yeast Meiotic Program Revealed by Ribosome Profiling (Brar et al. 2012)](https://doi.org/10.1126/science.1215110).

The files needed for this dataset are described in more detail below as [an example of an example dataset](#examplestructure).

<a name="contentsstructure"/>

# Contents and structure of example-datasets

## What belongs in example-datasets

* config.yaml files that describe all parameters for the riboviz run
* trancriptome or ORFeome files needed:
  * .fasta files of transcript/extended-ORF sequences
  * .gff files that describe the CDS/ORF position within the fasta file 
* .fasta files of contaminants to exclude (rRNA, tRNA, etc)
* if needed, a specialized A-site displacement length file `asite_disp_length.txt` (see [riboviz configuration documentation](https://github.com/riboviz/riboviz/blob/master/docs/user/prep-riboviz-config.md)). For example, for _E. coli_ bacteria,  [Escherichia_coli_asite_disp_length.txt](/bacteria/escherichia/annotations/Escherichia_coli_asite_disp_length.txt)

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

<a name="examplestructure"/>

### An example of an example dataset from brewer's yeast

For example, for re-analysis of the yeast meiosis dataset from Brar 2012, aligning to  an approximate dataset with CDS flanked by 250nt UTRs at both ends, are in `fungi/saccharomyces`:

* `fungi/saccharomyces/Brar_2012_Meiosis_RPF_6-samples_CDS_w_250utrs_config.yaml`
* `fungi/saccharomyces/annotation` for the annotation gff and fasta files: 
  - `Saccharomyces_cerevisiae_yeast_CDS_w_250utrs.fa` - fasta file of approximate transcripts
  - `Saccharomyces_cerevisiae_yeast_CDS_w_250utrs.gff3` - gff file of locations of ORFs on those transcripts
  - `Saccharomyces_cerevisiae_yeast_CDS_w_250utrs_annotation_provenance.txt` - describes the provenance of these (where those files came from)
* `fungi/saccharomyces/contaminants` for the contaminants fasta files:
  - `Saccharomyces_cerevisiae_yeast_rRNA_R64-1-1.fa`
  - `Saccharomyces_cerevisiae_yeast_rRNA_R64-1-1-fasta_provenance.txt` - describes the provenance of the fasta file

## Top-level directories are kingdoms, with an artificial one for simulated data

Each of these directories contains a README.md file with more detailed information on the datasets conatined therein.

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

We welcome community contributions!

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

Please begin the `config.yaml` with a `provenance` entry providing metadata on the riboviz run, the authors of the file, the version of riboviz that ran on the dataset, and the data source including publication reference and DOI, for example:

```
provenance:
  authors: # people who put together this config.yaml file
  - author: John Smith III
    email: John.Smith.III@ed.ac.uk
  - author: ...
    email: ...
  website: https://www.ed.ac.uk/some-bio-project
  date: 2020-04-01
  riboviz-version: TAG | COMMIT
  GEO: GSExxxxxxx # gene expression omnibus references for dataset, if relevant
  reference: Genome-Wide Analysis in Vivo of Translation with Nucleotide Resolution Using Ribosome Profiling, Ingolia et al 2009
  DOI: 10.1126/science.1168978
  notes:  Re-analysis of data from Ingolia 2009 to an updated yeast transcriptome.
```

## annotation files

Annotation files (.fasta files of transcript/extended-ORF sequences, .gff files that describe the CDS/ORF position within the fasta file), should be placed within
They should be checked with [check_fasta_gff.py](https://github.com/riboviz/riboviz/blob/master/riboviz/tools/check_fasta_gff.py), which currently checks if start and stop codons are as expected. This can be run as follows:

```console
$ python -m riboviz.tools.check_fasta_gff -f FASTA -g GFF
```

For example,

```console
$ python -m riboviz.tools.check_fasta_gff -f data/yeast_CDS_w_250utrs.fa \
    -g data/yeast_CDS_w_250utrs.gff3 
```

You can submit files with non-ATG start codons or in-frame stops if you have good reason to do so, `check_fasta_gff.py` is a diagnostic not a prescription. 

We are currently working on improving specification and testing for annotation files, see [#riboviz174](https://github.com/riboviz/riboviz/issues/74).

## contaminant files 

This is a .fasta-format file of everything that you want ignored in the downstream riboviz analysis. It will generally encompass ribosomal rRNA from your species of interest, perhaps also transfer RNA and other abundant non-coding RNA sequences.

## provenance files

These are .txt format files that describe provenance or metadata covering where the annotation and contaminants come from. Ideally they should include data on repositories, genome releases, references, etc.
These are in separate files, because .fasta files do not generally accept comments in the header.

For an example, see: `fungi/saccharomyces/annotation/Saccharomyces_cerevisiae_yeast_CDS_w_250utrs_annotation_provenance.txt`

## pull request

When your example dataset is complete, please put in a pull request to the master branch and we will review.

We aim to implement automatic checking using the configuration validation option for nextflow, see issue [#riboviz172](https://github.com/riboviz/riboviz/issues/172).


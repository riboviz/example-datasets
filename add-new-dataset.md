# How to set up a new dataset 

A how-to-guide to adding a new dataset for riboviz processing into example-datasets, including for new species.
For more information on using riboviz, see [riboviz documentation](https://github.com/riboviz/riboviz#use-riboviz).

# Table of contents

* [Setting up a new species](#newspecies)
* [Adding a dataset for an existing species](#existingspecies)


<a name="newspecies"/>


# Setting up a new species

**For species where annotations are not already available on example-datasets**

Some species already have transcript annotations set up in example-datasets, meaning it is quicker and easier to add new datasets for them.
The species already present in example-datasets include; *Escherichia coli*, *Candida albicans*, *Cryptococcus neoformans*, *Saccharomyces cerevisiae* and many more.
If the species you want to study is not already on example-datasets then it will take more time to set up, but the key steps are outlines below.

Note that all annotations are imperfect, and your biological question may require a transcript annotation different from the ones already present.
The steps to add a new annotation are the same as adding a new species.

**Contents:**

1. Find annotation data for the species you want to study.
2. Create a genus folder in example-datasets if needed.
3. Download or create contaminants fasta file.
4. Download or create transcriptome annotation fasta and gff files.
5. Check annotation files
6. Add your first dataset.

**1. Find annotation data for the species you want to study**

Unless you have generated new annotation data yourself, you will find this on public databases of genomes and annotations. 
Some top choices are:

* [EMBL-EBI Ensembl](http://www.ensembl.org/) and its sister sites for [Fungi](https://fungi.ensembl.org/), [Bacteria](http://bacteria.ensembl.org/), [Plants](http://plants.ensembl.org/), and [Protists](http://protists.ensembl.org/) contain many genomes and annotations.
* [NCBI genomes](https://www.ncbi.nlm.nih.gov/genome/) contains the genomes of over 60,000 organisms and can provide links to external resources focussing of individual species.
* Model organism databases are useful for specialised orgnaisms, such as [Saccharomyces, SGD](https://www.yeastgenome.org/) and [Schizosaccharomyces pombe, pombase](https://www.pombase.org/).  

**2. Create a genus folder in example-datasets**

Each genus has its own folder within the relevant Kingdom folder, as outlined in the example-datasets [README file](https://github.com/riboviz/example-datasets#repository-structure-is-loosely-phylogenetic).
The genus folder will eventually hold the `config.yaml` files for each dataset for species within that genus
Within the genus folder, an annotation and a contaminants folder need to be created.
These will hold the transcriptome gff and fasta, and the contaminant fasta respectively, along with the relevant provenance files.  

- Create a new branch in example datasets to work in.
- Within the branch, create a folder for your genus.
- Inside the genus folder, create an annotation and a contaminants folder. 

**3. Download contaminants fasta file**

The contaminants file is a fasta file containing the sequences of unwanted contaminant RNA sequence for the organism being studied. 
Some ribosomal RNA (rRNA) fragments are released from ribosome during the digestion step of ribosome profiling, so will typically be abundant in the data.
Other non-coding RNAs such as transfer RNA, snoRNAs, and so on, may also be useful to remove as contaminants.
Their sequences can typically be found and downloaded from a genome database in the .fasta format.

The contaminants fasta file can then be added to the contaminants folder, along with a provenance.txt file describing the origins and how it was created. 

- Find and download the contaminant/rRNA sequences for your organism in .fasta format
- Add the .fasta file to the contaminants folder with a helpful name such as `Genus_species_rRNA_tRNA.fasta`
- Create and add a provenance.txt file

**4. Download or create transcriptome annotation fasta and gff files**

Riboviz runs using transcriptome-centric annotation files rather than genome annotation files, as this reduces problems later on in the data analysis that would be caused by splicing and antisense/opposite-strand reads.
If transcriptome fasta and gff files are already available then great!
If not, you will have to create them.

You can try to create transcriptome files from genome fasta and gff files using the Rscript 'create_files_for_riboviz.R' available [here](https://github.com/riboviz/riboviz/blob/create_riboviz_style_cds_gff_acope3-278/rscripts/create_files_for_riboviz.R).
This code may need to be adapted to fit different research questions and is still in development, but is definitely a good starting point. 

This can be run using the command:

`Rscript --vanilla rscripts/create_files_for_riboviz.R `

and by adding arguments to specify the input fasta and gff, output files, the method of seperating sequences (i.e. by the gene name or sequence ID), etc.
```
"-i","--input",help="Input DNA sequences. Should contain genome (i.e. sequence of each chromosome) or transcripts. Should be file path",type="character"
"-g","--gff",help="GFF3 file corresponding to input DNA sequences.",type="character"
"--out_dir",help="Output directory for Riboviz-style CDS and GFF files. Will be created if does not exist.",type="character",default="./"
"--out_cds",help="Name of Riboviz-style CDS file",type="character",default="riboviz_cds.fasta"
"--out_gff",help="Name of Riboviz-style GFF3 file",type="character",default="riboviz_gff.gff3"
"-s","--seq_id",help="GFF column to use as the sequence ids",type="character",default="Name"
"-b","--buffer",help="Buffer to use for UTRs",type="integer",default=250
"--h5_file",help="File name for createing H5 file. If not initialized, file will not be created.",type="character",default=NULL
"--codon_data_file",help="File name for codon position .Rdata file. If not initialized, file will not be created.",type="character",default=NULL
"--num_cores",help="Number of cores to use for parallelizable processes.",type="integer",default=1
"--codons_exclude",help="Exclude the first n codons when creating codon_data_file, where n is specified by this argument",default=0
"--remove_trailing",help="Remove trailing info from names to be used for CDS, e.g. remove anything after '_' or '.'",type="character",default="_|\\."
"--filter_seq",help="A comma-separated list of filtering criteria to apply to the GFF3 file, e.g. 'type:CDS,orf_classification:Verified,orf_classification:Uncharacterized'. Use 'notNA' to filter values that are NA, e.g. 'orf_classification:!NA'.",type="character",default="type:CDS"
"--exons_preordered",help="Some GFF3 files have exons pre-ordered such that exon with start codon is listed first. Effects how multi-exon genes will be combined.",action="store_true"

```

These parameters allow the code to be adapted depending on the format of the GFF and fasta files, which is inconsistent between different file sources and databases.

Key qualities of transcriptome style fasta and gff files produced by `create_files_for_riboviz.R`:
- All coding sequences are on the positive/forward stranded 
- All coding sequences are flanked by a fixed-length buffer region
- Each transcript sequence is listed seperately in the fasta file, rather than being the full sequences of chromosomes
- For each transcript, the GFF will contain 3 features; the upstream buffer (approximate 5'UTR), the CDS, and the downstream buffer (approximate 3'UTR).

Once created, these annotation files can be uploaded to the annotation folder. 

- If available, download transcriptome gff and fasta files for the species of interest and add to annotation folder.
- If unavailable, download genome gff and fasta files and run through create_files_for_riboviz.R
- Add new files to annotation folder
- Create and add a provenance.txt file describing their origins and how they was created. 

**5. Check annotation files**

The gff file acts as a guide, and tells the pipeline where to find the start and stop codons for each transcript.
It is essential that these locations do actually match the location of the start and stop codon in the matched fasta file.
If not, riboviz will still run, but the read frame and counts per ORF will be wrong.

Annotation files can be checked using the riboviz tool [check_fasta_gff](https://github.com/riboviz/riboviz/blob/main/riboviz/tools/check_fasta_gff.py), which looks for start and stop codons in the fasta file using the positions provided by the GFF and provides details on the number of missing and unexpected features.
See [the documentation about how to use check_fasta_gff](https://github.com/riboviz/riboviz/blob/main/docs/user/check-fasta-gff.md).
It is likely that there will be a few issues present due to alternative start codons, frameshifts, and the presence of psuedogenes if not removed.

If there are issues present, then using a sequence viewer such as IGV or SnapGene can help highlight the cause.

If the gff and fasta files show few issues, the files are ready to test with a dataset, which you can add following the instructions below.

- Run GFF and fasta files through check_fasta_gff.
- Check outputs for unexpected issues.
- Investigate issues if present. 

**6. Add your first dataset**

To add a new dataset, follow the instructions described below in **Adding a dataset for an existing species.**

<a name="existingspecies"/>

# Adding a dataset for an existing species 

If the species you would like to study is available in example-datasets, the necessary annotation and contamination files are will be available in `example-datasets/kingdom/species/`. You will need to ensure that [riboviz is set up](https://github.com/riboviz/riboviz/blob/main/docs/user/install.md) and that the [vignette runs](https://github.com/riboviz/riboviz/blob/main/docs/user/run-on-eddie.md#run-a-vignette-of-the-riboviz-workflow) before adding your dataset.

**Contents:**

1. Components 
2. Testing
3. Troubleshooting

This documentation provides the user with some useful documentation which supplements the [documentation](https://github.com/riboviz/riboviz/blob/main/docs/user/run-on-eddie.md#run-a-full-size-example-dataset) available for adding new datasets. The linked documentation covers making annotation, contamination and input directories. Instructions for creating qsub job submission scripts and submitting of jobs is also covered. 

Desired structure:
```
W-Sc_2012/
contaminants/   annotation/   config.yaml   input/
```

**1. Components:** 

The scientific paper (if dataset is published) 
- Identify the scientific paper which is associated with the dataset of interest. The paper will contain a reference to the associated sequencing data, including the database  and the series accession numbers. 
- The methods section of the paper will either refer to a protocol or describe the adapter sequence used, as well as UMIs (Unique Molecular Identifiers) and/or barcodes which may have been used to generate the samples. This information is needed for the config.yaml file. 

The ribosome profiling samples 
- To find the fastq files for the samples associated with the dataset the series accession number can be searched for in the relevant database.
- Identify the ribosome profiling samples, some of the listed samples may be RNA-seq samples and should not be included. ([Instructions for downloading fastq files](https://github.com/riboviz/riboviz/blob/main/docs/user/run-on-eddie.md#download-fastq-data-files-from-the-short-read-archive-sra-initial-setup)).

The config.yaml file 
- Documentation for [configuring the config.yaml](https://github.com/riboviz/riboviz/blob/main/docs/user/prep-riboviz-config.md) file is available in addition to a wide variety of examples in [example-datasets](https://github.com/riboviz/example-datasets). It is recommended to use an existing config.yaml file as a guide.
- The majority of the parameters have default settings that are species-specific and can be modelled off of previous config.yaml files used for your species of interst, which are available in example-datasets. 
- Dataset-specific parameters include the adapter sequence, accession codes for the samples and the potential presence of UMIs and/or barcodes. Whether or not UMIs and/or barcodes are present can be hard to pinpoint. If in doubt set the UMIs configuration as FALSE, if UMIs are present the output files will show irregularities such as a lack of three-nucleotide periodicity. 
- It can be useful for other people to be able to access your work, if your work is open-science and the data has been published. To do this create a branch in example-datasets with a useful name linked to your issue ticket (e.g. W-Sc_2016-63 for Weinberg et al 2016 *Saccharomyces cerevisiae* dataset from issue ticket 63) which contains your config.yaml file. It is useful to link/name this branch in your issue ticket so that it is easy to find. 

**2. Testing:**

Downsampled data test (optional)
- Create downsampled data (e.g. 1000 reads) and complete a fast test on it, troubleshoot as necessary. 
- If succesful you can increase the sample size (e.g.100 000 reads) and complete another test before increasing to full sample size. This saves time by identifying and correcting any errors before proceeding with the time-consuming task of processing an entire dataset.   

Failure of the job to run through riboviz may be due to:
- Running the job script command from the wrong directory.
- Pathway errors, either due to typo's or incorrect pathways - these errors may be present in the config.yaml file or in the job script that you submitted.
- Checking `.nextflow.log` from `$HOME/riboviz/riboviz` to see where the job failed may provide further insights (further documentation can be found [here](https://github.com/riboviz/riboviz/blob/main/docs/user/prep-riboviz-run-nextflow.md#debugging). Errors may also have been encountered before so check previous issue tickets.

If the job is completed succesfully output files will be generated in an output folder. These output files should be checked to ensure that the parameters provided were correct.
- The read_lengths file can be checked to confirm that adapters have been removed succesfully – the read lengths are usually expected to be 28-32 nt (this may depend upon the protocol).
- 3nt periodicity on coding regions, and start and stop profiles can be checked by examining the 3nt_periodicity file.

The dataset has been processed correctly if the output files confirm the succesful removal of adapters and the presence of 3nt periodicity. You can then:
- Update the provenance section of the config.yaml file with the most recent commit before submitting a pull request containing your config.yaml file (do not submit your input or output files in this pull request). 
- Update the genus-level README.md so that it contains the name of your config.yaml file.

**3. Troubleshooting**

If necessary, troubleshooting can be carried out to diagnose the cause of any irregularities. Possible causes include contaminating sequences which were not removed when aligning to the contamination files or the presence/incorrect removal of UMIs. 
- Check the alignment of the reads. If random nucleotides are present in the read that were not removed, this would prevent the alignment of almost all reads (either to rRNA or mRNA), leading to a problem of no aligned reads.
- If there are no sensible alignments: find the overrepresented sequences by performing a FastQC analysis on the fastq input files (`$ module load igmm/apps/FastQC/0.11.9` if working from Eddie), check the FastQC report "Overrepresented sequences" section. Any overrepresented sequences are likely to be rRNA. You can then align to the reference genome by BLAST and check if there is a read structure of rRNAfragment-something-overrepresentedsequence. The something will be the length of the UMI.
- If there are no sensible alignments: try UMIs. Put in the best-guess length of UMI to the config.yaml ([examples here](https://github.com/riboviz/riboviz/blob/main/docs/user/prep-riboviz-config.md#examples)) (in another branch if helpful). Run through riboviz on a downsampled dataset. If there are sensible alignments and the output files look good you can scale up to the full dataset.
- If it still does not make sense: email the authors.  

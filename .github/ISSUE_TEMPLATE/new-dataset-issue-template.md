---
name: New dataset issue template
about: A template with checklist for adding a new dataset
title: Add new dataset DESCRIBE HERE
labels: ''
assignees: ''

---

Thanks for starting to add a new dataset to example-datasets! This issue template includes the key steps, see [add-new-dataset.md](https://github.com/riboviz/example-datasets/add-new-dataset.md). Please edit as needed for your dataset.

- [ ] Create a new branch of example-datasets with a helpful concise name, for example `cheng-entamoeba-123` if the dataset were generated by Dr. Cheng, from entamoeba, and the new issue ticket is number 123.
- [ ] Identify paper or data source - list and link
- [ ] Identify the species and strain used, check if example-datasets already has appropriate annotation and contaminant files.
- [ ] (if new species) Find annotation data for the species and strain elsewhere.
- [ ] (if new species *and* genus)  Create a genus folder in example-datasets.
- [ ] (if new species) Download or create contaminants fasta file.
- [ ] (if new species) Download or create transcriptome annotation fasta and gff files.
- [ ] (if new species) Check annotation files for consistency with `check_fasta_gff`.
- [ ] Identify the ribosome profiling samples from the dataset (some may be RNA-seq) - link database.
- [ ] Identify adapter sequence - provide sequence.
- [ ] Confirm or deny presence of UMIs and barcodes if used - describe if present.
- [ ] If UMIs are present, create UMI regular expression.
- [ ] Using information gathered, create config file.
- [ ] Download sample data.
- [ ] (optional) Create downsampled data and fast test run on that.
- [ ] Test run of full sized dataset.
- [ ] Look at results - check for 3nt periodicity in coding regions, most common read lengths being 28-32 nt, and clear start and stop profiles.
- [ ] Troubleshoot as necessary and discuss on issue ticket.
- [ ] Update genus-level README.md and provenance section of config file.
- [ ] Put in pull request to add to repository.

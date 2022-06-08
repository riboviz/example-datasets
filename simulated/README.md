# Simulated

Example riboviz workflows from simulated and otherwise artificial datasets, that don't come from a complete real genome.

These might be completely simulated datasets, or transcriptomes that are so radically downsampled that it doesn't make sense to include them in the folder with the original.

These might be used to test features of the pipeline.

## Structure

Since simulated datasets are not arranged by kingdom and genus, we cannot organise them phylogenetically. Inside the mok folder, the structure is maintained with the annotation and contaminats folders containing the needed files for riboviz. Anyway, t is important to notice that the sample fasta files containing the reads are in the mok folder together with the yaml (configuration files). To be able to run these datasets, the correspondent fasta file will have to be copied in the input folder.

Please organise directories `author/datasetinfo`, i.e. by author and then some brief information on the dataset(s), for example `sanchez/stalling_simulation_10genes`.

## mok

Simulated data from Amanda Mok, U.C. Berkeley, @amandamok.

* Mok-simYAL5_config.yaml (sample file: simRiboviz.fq.gz)
* Mok-tinysim_config.yaml (sample file: tiny_2genes.fq)

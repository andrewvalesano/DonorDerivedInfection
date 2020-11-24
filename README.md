# Analysis of sequences from a case of SARS-CoV-2 transmission by lung transplantation

This repository holds code and data for the analysis of six specimens from a case of SARS-CoV-2 transmission via lung transplantation. The code and data are provided here for reproducibility. Below is a map of the repository.

# Overview
--------

    project
    |- README          # The top level description of content. You are here.
    |
    |- data  
    |  |- metadata/   # Sample metadata for the specimens sequenced in this study.
    |  |- reference/  # Reference fasta files used in pipelines.
    |  |- raw/        # Raw data.
    |  |- treetime_analysis/        # Code and data from IQ-TREE and TreeTime.
    |- scripts/       # Code for figures presented in manuscript.
    |- pipelines/     # Snakemake files for processing fastq.
    
  --------

# Notes

Raw sequence reads are available at the Sequence Read Archive, BioProject accession PRJNA679980.

# Contact

If you have questions, please contact the [Lauring Lab](https://lauringlab.wordpress.com/contacts/).

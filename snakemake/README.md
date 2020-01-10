
# Background

Home page is https://snakemake.readthedocs.io

# Setup

source conda-install/etc/profile.d/conda.sh
conda create -n snakemake -c conda-forge bioconda::snakemake
conda activate snakemake

## Specific to this pipeline

* need to add CASA at the end of PATH
* conda install -c conda-forge python-casacore matplotlib
* apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# How it works

You need to write a Snakefile to define your pipeline in your working directory. Then do:

snakemake

and it will run the pipeline for you.

# Evaluation (1:bad, 5:good)

## Installation

Score: 3
Comments: It takes quite a long time to resolve dependencies with conda.

## Documentation

Score: 5
Comments: Great! Including examples to get started and diving deep into what's required to use it.

## Management of software dependencies

Score: 5
Comments: Integrated with conda and singularity.

## Visualize workflows

Score: 5
Comments: It comes with built-in functionality to plot the workflow to be executed.

## Interoperability

Score: 5
Comments: It can export the workflow to CWL!


## HPC support

Score: 5
Comments: The same workflow can be run on your laptop and on a HPC cluster.

## Cloud support

Score: 5
Comments: It works on Kubernetes-enabled clusters!


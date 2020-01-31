
# Background

Cromwell home page is https://cromwell.readthedocs.io

WDL home page is https://software.broadinstitute.org/wdl/

Tutorials: https://support.terra.bio/hc/en-us/sections/360007347652?name=wdl-tutorials

# Setup

```
source conda-install/etc/profile.d/conda.sh
conda create -n cromwell -c conda-forge cromwell
conda activate cromwell
```

## Specific to this pipeline

* need to add CASA at the end of PATH
* conda install -c conda-forge python-casacore matplotlib
* apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# How it works

You need to write a WDL file to define your pipeline (e.g. `myWorkflow.wdl`). You can validate it with:

```
womtool validate myWorkflow.wdl
```

It is also good practice to write an inputs file (e.g. `myWorflow_inputs.json`); then do:

```
cromwell run myWorkflow.wdl --inputs myWorkflow_inputs.json
```

You can also generate a template input file with:

```
womtool inputs myWorflow.wdl
```

which will require you to replace the placeholders with the actual inputs.

# Evaluation (1:bad, 5:good)

## Installation

Score: 5
Comments: Available in conda-forge!

## Documentation

Score: 5
Comments: Great! Including examples to get started and diving deep into what's required to use it.

## Management of software dependencies

Score: ?
Comments: ?

## Visualize workflows

Score: ?
Comments: ?

## Interoperability (CWL)

Score: ?
Comments: ?


## HPC support

Score: 5
Comments: The same workflow can be run on your laptop and on a HPC cluster.

## Cloud support

Score: 5
Comments: It does but I don't know the details yet.


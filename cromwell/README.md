
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

It is also good practice to define an additional `options.json` file to configure the workflow. See:

* https://cromwell.readthedocs.io/en/stable/wf_options/Overview/
* https://cromwell.readthedocs.io/en/stable/Configuring/#workflow-log-directory

# Evaluation (1:bad, 5:good)

## Installation

Score: 5
Comments: Available in conda-forge!

## Documentation

Score: 5
Comments: Great! Including examples to get started and diving deep into what's required to use it.

## Management of software dependencies

Score: 5
Comments: Integration with containers https://cromwell.readthedocs.io/en/stable/tutorials/Containers/

## Visualize workflows

Score: 3
Comments: By using 3rd party tools

## Interoperability (CWL)

Score: 5
Comments: Here it is https://cromwell.readthedocs.io/en/stable/LanguageSupport/

## HPC support

Score: 5
Comments: The same workflow can be run on your laptop and on a HPC cluster.

## Cloud support

Score: 5
Comments: This tool has been specially designed to work in cloud environments.

## Extra comments: data management

We have not included a specific section to talk about data management inside the workflow.
We assumed that all workflow management systems would work the same way in that sense.
However, after testing cromwell we can see that's not the case. Every time you run a workflow
with cromwell, it creates a new set of subdirectories where outputs and logs are dumped. This
create a series of problems:

* Say for example you have one step in your pipeline where you use wget to download data. Then,
every time you run the workflow, the data will be downloaded.

* If you have a 10-step pipeline and crashes in the 9th step, it looks like cromwell will
rerun everything from the 1st step. This is due to the default behaviour of creating a new set
of working subfolders for every new run. It was not clear whether you could modify this behaviour.

* You need to adapt your code to work with cromwell in order to pick up the input and output
location of the data. Again, that might not be a problem for new code but if you want to pipeline
existing code, that's a major headache that can be avoided with Snakemake and cgat-core.



# Background

Home page is https://airflow.apache.org/

# Setup

```
source conda-install/etc/profile.d/conda.sh
conda create -n airflow airflow
conda activate airflow
```

## Specific to this pipeline

* need to add CASA at the end of PATH
* conda install -c conda-forge python-casacore matplotlib
* apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# How it works

I am following the quick start guide:

https://airflow.apache.org/docs/stable/start.html

First, configure AIRFLOW_HOME environment variable accordingly, e.g.:

```
mktemp -d
cd </temp/folder>
mkdir airflow
export AIRFLOW_HOME=</temp/folder>/airflow
```

Now initialize installation:
```
# initialize the database
airflow initdb

# start the web server, default port is 8080
airflow webserver -p 2222 >& airflow/logs/webserver.log &

# start the scheduler
airflow scheduler >& airflow/logs/scheduler.log &

# visit localhost:2222 in the browser
```

Now, you need to write a Python script with the pipeline. See pipeline.py on this folder.

Place the pipeline.py into a subfolder:
```
mkdir airflow/dags
cp pipeline.py airflow/dags
```

You can now check that your pipeline is listed:
```
airflow list_dags --subdir airflow/dags
airflow list_tasks test_pipeline
airflow list_tasks test_pipeline --tree
```

You can test individual tasks:
```
airflow test test_pipeline wget_input_data 2020-02-05
```

Or run them:
```
airflow backfill test_pipeline -s 2020-02-05
```

# Evaluation (1:bad, 5:good)

Interesting resources:
* https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/
* https://github.com/jghoman/awesome-apache-airflow

## Installation

Score: 5
Comments: Available in conda (both the default and conda-forge channels)

## Documentation

Score: 5
Comments: Great! Including examples to get started and diving deep into what's required to use it.

## Management of software dependencies

Score: 1
Comments: 

## Visualize workflows

Score: 5
Comments: It comes with built-in functionality to plot the workflow to be executed.

## Interoperability

Score: 3
Comments: Via 3rd party tools https://www.biorxiv.org/content/10.1101/249243v2

## HPC support

Score: 3
Comments: Not with DRMAA API https://airflow.apache.org/docs/stable/executor/index.html

## Cloud support

Score: 5
Comments: Via an executor https://airflow.apache.org/docs/stable/executor/index.html

It is also integrated with major public cloud providers:
* https://airflow.apache.org/docs/stable/integration.html

## Extra comments: data management

We have not included a specific section to talk about data management inside the workflow.
We assumed that all workflow management systems would work the same way in that sense.
However, after testing cromwell we can see that's not the case. Every time you run a workflow
with cromwell, it creates a new set of subdirectories where outputs and logs are dumped. This
create a series of problems:

* Say for example you have one step in your pipeline where you use wget to download data. Then,
every time you run the workflow, the data will be downloaded again.

* If you have a 10-step pipeline and crashes in the 9th step, it looks like cromwell will
rerun everything from the 1st step. This is due to the default behaviour of creating a new set
of working subfolders for every new run. It was not clear whether you could modify this behaviour.

* You need to adapt your code to work with cromwell in order to pick up the input and output
location of the data. Again, that might not be a problem for new code but if you want to pipeline
existing code, that's a major headache that can be avoided with Snakemake and cgat-core.


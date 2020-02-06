
import luigi
import subprocess
import os
import sys
import re


def execute(statement):
    # cleaning up of statement
    # remove new lines and superfluous spaces and tabs
    statement = " ".join(re.sub("\t+", " ", statement).split("\n")).strip()
    if statement.endswith(";"):
        statement = statement[:-1]

    # always use bash
    os.environ.update(
        {'BASH_ENV': os.path.join(os.environ['HOME'], '.bashrc')})
    process = subprocess.Popen(statement,
                               shell=True,
                               stdin=sys.stdin,
                               stdout=sys.stdout,
                               stderr=sys.stderr,
                               env=os.environ.copy(),
                               executable="/bin/bash")

    # process.stdin.close()
    stdout, stderr = process.communicate()

    if process.returncode != 0:
        raise OSError(
            "Child was terminated by signal %i: \n"
            "The stderr was: \n%s\n%s\n" %
            (-process.returncode, stderr, statement))


class DownloadData(luigi.Task):

    def output(self):
        return luigi.LocalTarget("data/raw/TEST1_L.fits")

    def run(self):
        statement = '''
        mkdir -p data/raw &&
        wget http://www.e-merlin.ac.uk/distribute/support/TEST1_L.fits &&
        mv TEST1_L.fits data/raw
        '''
        execute(statement)

class ExecuteCasa(luigi.Task):

    def output(self):
        return luigi.LocalTarget("data/interim/TEST1_L.ms")

    def requires(self):
        yield DownloadData()

    def run(self):
        statement = '''
        mkdir -p data/interim &&
        casa --nologger --nogui -c ./src/casa_script.py
        '''
        execute(statement)

class ReadAmplitudes(luigi.Task):

    def output(self):
        return luigi.LocalTarget("data/interim/amp.npy")

    def requires(self):
        yield ExecuteCasa()

    def run(self):
        statement = '''
        python ./src/read_amplitudes.py -msfile data/interim/TEST1_L.ms
        '''
        execute(statement)

class PlotAmplitudes(luigi.Task):

    def output(self):
        return luigi.LocalTarget("report/images/amplitudes.png")

    def requires(self):
        yield ReadAmplitudes()

    def run(self):
        statement = '''
        mkdir -p report/images &&
        python ./src/plot_amplitudes.py
        '''
        execute(statement)

class LatexReport(luigi.Task):

    def output(self):
        return luigi.LocalTarget("report/my_report.pdf")

    def requires(self):
        yield PlotAmplitudes()

    def run(self):
        statement = '''
        cd report &&
        pdflatex my_report.tex &&
        pdflatex my_report.tex &&
        cd ..
        '''
        execute(statement)


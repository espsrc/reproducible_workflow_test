# Step 1
# Download some data to directory input
# Dependencies: 
# Input: 
# Output: data/interim/TEST1_L.fits
mkdir data
rm -r data/raw
mkdir data/raw
wget http://www.e-merlin.ac.uk/distribute/support/TEST1_L.fits
mv TEST1_L.fits data/raw

# Step 2
# Execute casa_script.py
# Dependencies: casa
# Input: data/raw/TEST1_L.fits
# Output: data/interim/TEST1_L.ms
rm -r data/interim
mkdir data/interim
rm -r output
mkdir output
casa --nologger --nogui -c ./src/casa_script.py


# Step 3 
# Use python-casacore to read amplitudes from MS and produce numpy file
# Dependencies: python, python-casacore, numpy
# Input: data/interim/TEST1_L.ms
# Output: data/interim/amp.npz
rm -r data/interim/amp.npz
python ./src/read_amplitudes.py -msfile data/interim/TEST1_L.ms

# Step 4
# Use python to produce some plots and latex report
# Dependencies: python, numpy, matplotlib
# Input: data/interim/amp.npz
# Output: report/images/amp.png
mkdir -p report/images
python ./src/plot_amplitudes.py

# Step 5 
# Produce a report with latex
# Dependencies: latex
# Input: report/images/amp.png
# Outputs: report/amp.pdf
cd report
pdflatex my_report.tex
pdflatex my_report.tex
cd ..

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

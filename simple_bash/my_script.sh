# Step 1
# Download some data to directory input
# Input: 
# Output: data/interim/TEST1_L.fits
mkdir data
rm -r data/raw
mkdir data/raw
wget http://www.e-merlin.ac.uk/distribute/support/TEST1_L.fits
mv TEST1_L.fits data/raw

# Step 2
# Execute casa_script.py
# Input: data/raw/TEST1_L.fits
# Output: data/interim/TEST1_L.ms
rm -r data/interim
mkdir data/interim
rm -r output
mkdir output
casa --nologger --nogui -c ./src/casa_script.py


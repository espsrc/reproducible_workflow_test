# Step 1
# Download some data to directory input
mkdir data
rm -r data/raw
mkdir data/raw
wget http://www.e-merlin.ac.uk/distribute/support/TEST1_L.fits
mv TEST1_L.fits data/raw

# Step 2
# Execute python script ./src/process_csv_file.py and produce a plot
rm -r data/interim
mkdir data/interim
rm -r output
mkdir output
casa --nologger --nogui -c ./src/casa_script.py


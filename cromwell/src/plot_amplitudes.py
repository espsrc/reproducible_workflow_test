import matplotlib.pyplot as plt
import numpy as np

infile = 'data/interim/amp.npy'
outfile = 'report/images/amplitudes.png'

# Read the data
amp = np.load(infile).flatten()

# Plot the data
plt.plot(amp, 'o')
plt.savefig(outfile)

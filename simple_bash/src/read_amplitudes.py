import numpy as np
import argparse
import casacore.tables.table as tbl


def get_amplitudes(msfile):
    print('Reading Data...')
    t = tbl(msfile)
    data = t.getcol('DATA')
    amp = np.absolute(data)
    t.close()
    return amp


def get_args():
    '''This function parses and returns arguments passed in'''
    # Assign description to the help doc
    description = 'Select dataset'
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('-msfile', dest='msfile', help='path to single-source MS')
    args = parser.parse_args()
    return args

def save_amplitudes(amp):
    outfile = './data/interim/amp.npz'
    print('Saving amplitudes to file: {}'.format(outfile))
    np.save(outfile, amp)

if __name__ == '__main__':
    args = get_args()
    msfile = args.msfile
    amp = get_amplitudes(msfile)
    save_amplitudes(amp)


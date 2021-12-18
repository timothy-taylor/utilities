from scipy.io.wavfile import read
import matplotlib.pyplot as plt
import numpy as np

(fs, x) = read('filename.wav');
    # returns samplerate and an array of samples
x.size
    # how many samples in the file
x.size/fs
    # number of samples / samplerate = length in seconds
x.size/float(fs)
    # length in seconds, as decimal
t = np.arange(x.size)
    # creates a ranged array from 0 to the given value
time = t / float(fs)
    # make it in seconds
plt.plot(time, x)
plt.show()

np.max(x)
    # biggest value
np.max(abs(x))
    # since sounds oscillate around 0, you want absolute value

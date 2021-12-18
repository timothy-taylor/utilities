# python3.9 -m pip install numpy matplotlib scipy
import numpy as np
import matplotlib.pyplot as plt

A = .8                             # amplitude
f0 = 1000                          # frequency
phi = np.pi/2                      # phase
fs = 44100                         # sampling rate
t = np.arange(-.002, .002, 1.0/fs) # an array of discrete points
x = A * np.cos(2 * np.pi * f0 * t + phi)

plt.plot(t, x)
plt.axis([-0.002, 0.002, -0.8, 0.8])
plt.xlabel('time')
plt.ylabel('amplitude')

plt.show()

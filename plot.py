import matplotlib.pyplot as plt
import numpy as np

data = np.loadtxt('data.txt')

plt.plot(data[:,0], data[:, 1])
plt.xlabel('X axis')
plt.ylabel('Y axis')
plt.savefig('myplot.png')

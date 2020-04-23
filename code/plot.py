from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 unused import

import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np


fig = plt.figure()
ax = fig.gca(projection='3d')

weights = []
biases = []

with open("data.txt", "r") as f:
	buff = f.read()
	matrices = buff.split("\n\n")[:-1]
	i = 0
	while i < len(matrices):
		weights.append(np.array([[float(y) for y in x.split("\t")[:-1]] for x in matrices[i].split("\n")]))
		i+=1
		biases.append(np.array([[float(y) for y in x.split("\t")[:-1]] for x in matrices[i].split("\n")]))
		i+=1

sigmoid = lambda x : 1 / (1 + np.exp(-x))

def feedForward(input):
	global weights, biases;

	layerc = input.copy()
	for i in range(len(weights)):
		layerc = sigmoid(weights[i] @ layerc + biases[i])

	return layerc

print(feedForward(np.array([[0], [0]])))
print(feedForward(np.array([[0], [1]])))
print(feedForward(np.array([[1], [0]])))
print(feedForward(np.array([[1], [1]])))

# Make data.
X = np.arange(-10, 11, 0.2)
Y = np.arange(-10, 11, 0.2)
Z = np.array([[feedForward(np.array([[x], [y]]))[0][0] for y in Y] for x in X])
X, Y = np.meshgrid(X, Y)

# Plot the surface.
surf = ax.plot_surface(X, Y, Z,
                       linewidth=0, antialiased=False)

# Customize the z axis.
ax.set_zlim(-1.01, 1.01)
ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

# Add a color bar which maps values to colors.
fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()
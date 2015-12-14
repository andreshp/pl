################################################################################
# Author: Andrés Herrera Poyatos
# University of Granada, ETSIIT
# Models of Computation, LEX
# A simple plot command for bash based on lex and gnuplot.
################################################################################

# Python's program which builds an example .csv file to be plotted.

import sys
import os

# Variables needed for the process.
example = open("example.csv",'w')
width = 5
points = 100
lines = 10
separation = 0.5

# Function to plot.
def f(a, b, x):
    return a*b / (1 + x*x)

# For each point, a line is added to example with the corresponding y
# coordinates of each line.
for i in range(0, points+1):
    values = [ (float(i) / points) * width ]
    for j in range(1,lines+1):
        values.append(f(j, separation, values[0] - width / 2))
    example.write(",".join(map(str,values)) + "\n")

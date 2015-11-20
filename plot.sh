#!/bin/bash

################################################################################
# Author: Andrés Herrera Poyatos                                                
# University of Granada, ETSIIT                                                 
# Models of Computation, LEX                                                    
# A simple plot command for bash based on lex and gnuplot.                      
################################################################################

# Scrit that plots an image with gnuplot.
# The image is generated from example.csv

#---------------------------------- Plot --------------------------------------#

gnuplot << END

# Set the separator for the csv standard.
set datafile separator ","
# Set the terminal to plot a png image.
set terminal pngcairo enhanced font 'Verdana,10'
set border linewidth 1.5

# Style and line color.
# Function which passes rgb to gnuplot scale.
rgb(r,g,b) = r * 2**16 + g * 2**8  + b
set style line 1 lc rgb (rgb(61,76,61)) lt 1 lw 6 pt 7 pi 0 ps 0.5
set style line 2 lc rgb (rgb(41,136,59)) lt 1 lw 6 pt 7 pi 0 ps 0.5
set style line 3 lc rgb (rgb(119,195,124)) lt 1 lw 6 pt 7 pi 0 ps 0.5
set style line 4 lc rgb (rgb(39,254,29)) lt 1 lw 6 pt 7 pi 0 ps 0.5
set pointintervalbox 0

# Set the image name.
set output 'example.png'

# Set the tittle and the labels.
# Set the plot range (set offsets <left>, <right>, <top>, <bottom>)
set offsets graph 0, 0, 0.05, 0.05

# Plot the data.
plot 'example.csv' using 1:2 title "mi linea 1" with linespoints ls 1, 'example.csv' using 1:3 title "mi linea 2" with linespoints ls 2, 'example.csv' using 1:4 title "mi linea 3" with linespoints ls 3, 'example.csv' using 1:5 title "mi linea 4" with linespoints ls 4,

END

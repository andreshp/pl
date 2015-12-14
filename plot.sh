#!/bin/bash

################################################################################
# Author: Andrés Herrera Poyatos                                                
# University of Granada, ETSIIT                                                 
# Models of Computation, LEX                                                    
# A simple plot command for bash based on lex and gnuplot.                      
################################################################################

# Scrit that plots an image with gnuplot.
# The image is generated from the files:
# example.csv 

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
set style line 1 lc rgb (rgb(204,61,61)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 2 lc rgb (rgb(204,146,61)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 3 lc rgb (rgb(175,204,61)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 4 lc rgb (rgb(89,204,61)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 5 lc rgb (rgb(61,204,118)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 6 lc rgb (rgb(61,204,204)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 7 lc rgb (rgb(61,118,204)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 8 lc rgb (rgb(89,61,204)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 9 lc rgb (rgb(175,61,204)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set style line 10 lc rgb (rgb(204,61,146)) lt 1 lw 2 pt 7 pi 0 ps 0.5
set pointintervalbox 0

# Set the image name.
set output 'example.png'

# Set the tittle and the labels.
unset key
# Set the plot range (set offsets <left>, <right>, <top>, <bottom>)
set offsets graph 0, 0, 0.05, 0.05

# Plot the data.
plot 'example.csv' using 1:2 with linespoints ls 1, 'example.csv' using 1:3 with linespoints ls 2, 'example.csv' using 1:4 with linespoints ls 3, 'example.csv' using 1:5 with linespoints ls 4, 'example.csv' using 1:6 with linespoints ls 5, 'example.csv' using 1:7 with linespoints ls 6, 'example.csv' using 1:8 with linespoints ls 7, 'example.csv' using 1:9 with linespoints ls 8, 'example.csv' using 1:10 with linespoints ls 9, 'example.csv' using 1:11 with linespoints ls 10,

END

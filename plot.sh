#!/bin/bash

################################################################################
# Author: Andrés Herrera Poyatos                                                
# University of Granada, ETSIIT                                                 
# Models of Computation, LEX                                                    
# A simple plot command for bash based on lex and gnuplot.                      
################################################################################

# Scrit that plots an image with gnuplot.
# The image is generated from the files:
# example2.csv example.csv 

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
set style line 1 lc rgb (rgb(61,61,76)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 2 lc rgb (rgb(26,33,85)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 3 lc rgb (rgb(60,58,95)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 4 lc rgb (rgb(12,16,104)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 5 lc rgb (rgb(48,58,114)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 6 lc rgb (rgb(90,89,123)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 7 lc rgb (rgb(31,39,132)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 8 lc rgb (rgb(83,76,142)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 9 lc rgb (rgb(6,9,151)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 10 lc rgb (rgb(56,70,161)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 11 lc rgb (rgb(114,111,170)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 12 lc rgb (rgb(29,38,179)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 13 lc rgb (rgb(88,106,189)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 14 lc rgb (rgb(153,153,198)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 15 lc rgb (rgb(57,73,208)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 16 lc rgb (rgb(134,126,217)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 17 lc rgb (rgb(20,27,226)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 18 lc rgb (rgb(93,114,236)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 19 lc rgb (rgb(174,171,245)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set style line 20 lc rgb (rgb(52,68,255)) lt 1 lw 10 pt 7 pi 0 ps 0.5
set pointintervalbox 0

# Set the image name.
set output 'example2.png'

# Set the tittle and the labels.
unset key
set xlabel "Axis X"
set ylabel "Axis Y"
# Set the plot range (set offsets <left>, <right>, <top>, <bottom>)
set offsets graph 0, 0, 0.05, 0.05

# Plot the data.
plot 'example2.csv' using 1:2 with linespoints ls 1, 'example2.csv' using 1:3 with linespoints ls 2, 'example2.csv' using 1:4 with linespoints ls 3, 'example2.csv' using 1:5 with linespoints ls 4, 'example2.csv' using 1:6 with linespoints ls 5, 'example2.csv' using 1:7 with linespoints ls 6, 'example2.csv' using 1:8 with linespoints ls 7, 'example2.csv' using 1:9 with linespoints ls 8, 'example2.csv' using 1:10 with linespoints ls 9, 'example2.csv' using 1:11 with linespoints ls 10, 'example.csv' using 1:2 with linespoints ls 11, 'example.csv' using 1:3 with linespoints ls 12, 'example.csv' using 1:4 with linespoints ls 13, 'example.csv' using 1:5 with linespoints ls 14, 'example.csv' using 1:6 with linespoints ls 15, 'example.csv' using 1:7 with linespoints ls 16, 'example.csv' using 1:8 with linespoints ls 17, 'example.csv' using 1:9 with linespoints ls 18, 'example.csv' using 1:10 with linespoints ls 19, 'example.csv' using 1:11 with linespoints ls 20,

END

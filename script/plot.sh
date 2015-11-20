#!/bin/bash

################################################################################
# Authors: SCI2S
# University of Granada, ETSIIT
# SHS Project - Transportation Planning Systems - Auriga
################################################################################

# Scrit that plots the images associated to an execution.
# The result is an image with the

#-------------------------------- Variables -----------------------------------#

DATA1=$1
OUTPUT=$2
TITLE=$3
XLABEL=$4
YLABEL=$5
WIDTH=$6
#LEGEND1=$3

echo $DATA1
echo $OUTPUT
echo $TITLE
echo $WIDTH

#---------------------------------- Plot --------------------------------------#

gnuplot<<END

# Set the separator for the csv standard.
set datafile separator ","

# Set the terminal to plot a png image.
set terminal pngcairo enhanced font 'Verdana,10'
set border linewidth 1.5

# Style and line color.
set style line 1 lc rgb "blue" lt 1 lw $WIDTH pt 7 pi 0 ps 0.5
set pointintervalbox 0

# Set the image name.
set output '$OUTPUT'

# Set the tittle and the labels.
set title "$TITLE" enhanced font 'Verdana,14'
set xlabel "$XLABEL"
set ylabel "$YLABEL"

# Set the plot range (set offsets <left>, <right>, <top>, <bottom>)
set offsets graph 0, 0, 0.05, 0.05

# Plot the data.
plot "$DATA1" title '$LEGEND1' with linespoints ls 1

END

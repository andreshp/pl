# `pl`

A command line interface for gnuplot.

## What can `pl` do for you?

[Gnuplot](http://www.gnuplot.info/) is a very powerfull language to make plots. However, it is very complex and, consecuently, it is difficult to make good plots without previous experience. `pl` tries to solve this issue providing a simple command to make plots in just a line of code.

`pl` supports 2D plots and generates images in png, such as the following one:

![](https://github.com/andreshp/pl/blob/master/images/example.png)

You only has to pass the file with the data as an argument and `pl` will do the plot for you! For example, the previous image was plotted using `pl example.csv -t "An example with pl" -x "X Axis" -y "Y Axis"`.

*The command `pl -e` provides the file example.csv.*

## Instalation

1. You can clone the repository with `git clone` or download the [zip file](https://github.com/andreshp/pl/archive/master.zip).
2. The code needs to be compiled using make, which will ask you to install the dependencies that you don't have already installed.
3. If you want to use `pl` as an usual bash command, you should add the bin directory to the global variable PATH. To accomplish this, add the following line of code to your .bashrc file:

~~~
PATH=$PATH:<absolute path to /pl/bin/>
~~~

## Examples and parameters

`pl` uses [LEX](http://dinosaur.compilertools.net/lex/) to detect each parameter in lineal time. Consecuently, the parameters can be given in any order and the program will receive the formats that he is expecting to. Thus, the two following lines of code are equivalents:

~~~
pl example.csv -t "An example with pl" -x "X Axis" -y "Y Axis"
pl -y "Y Axis" example.csv -x "X Axis" -t "An example with pl"
~~~

### Files with data

`pl` can plot multiple files at the same file. The files passed to `pl` must contain at least two columns separated by a delimiter. The first column contains the abscissas of the points to plot. Each of the other columns must contain an ordinate for each abscissa, defining a point which will be plotted by `pl`. The points in the same column represent a function and are plotted with the same color. For example, the following one is a file with 4 lines:

~~~
0,0,1,2,3
1,0,1,2,3
2,0,1,2,3
3,0,1,2,3
~~~

If it is plotted using `pl lines1.csv`, then we obtain the following image:

![](https://github.com/andreshp/pl/blob/master/images/lines1.png)

The previous file follows the csv standard. However, you could use a different delimiter than a comma with the parameter `-d <character>`.

These kinds of graphics are very useful comparing algorithms' performance. However, algorithms' data could be in various files with different abscissas' values. `pl` accepts multiple files as arguments, plotting all the data in one image. Let's consider another file with lines:

~~~
0,0.5,1.5,2.5,3.5
0.5,0.5,1.5,2.5,3.5
2.5,0.5,1.5,2.5,3.5
3,0.5,1.5,2.5,3.5
~~~

Then, we can plot both files at the same time (`pl lines1.csv lines2.csv`):

![](https://github.com/andreshp/pl/blob/master/images/both_lines.png)

Note that we could have used regular expressions in bash to simplify the input: `pl *.csv`.

If your file name does not contains a dot, then you must pass it using the parameter `-f filename`.

### Simple configurations

- **-o \<file name\>** Sets the name of the plotted image.

- **-t \<title\>** Sets the image's title. You can provide a word or a text line between " ".

- **-x \<x label\>** Sets the image's label for the x axis. You can provide a word or a text line between " ".

- **-y \<y label\>** Sets the image's label for the y axis. You can provide a word or a text line between " ".

- **-l** The program will take the first entry in each column as the legend. If there is no label for the x axis, then the first entry in the abscissas' column will be used instead.

For example, you can use `pl lines_legend.csv -o my_plot.png -l -t "Some lines with legend." -y "Y Axis"` to plot:

~~~
X Axis,Line 1, Line 2, Line 3, Line 4
0,0,1,2,3
1,0,1,2,3
2,0,1,2,3
3,0,1,2,3
~~~

![](https://github.com/andreshp/pl/blob/master/images/my_plot.png)

### Lines' style
-s <style>
Sets the style of the plotted lines. You can choose among points, lines and linespoints (chosen by default). Possible uses are:
-l points, -l lines, -l linespoints or, respectively, -lp, -ll, -llp


-w <line width>
Sets the line's width to the chosen integer, starting at 0. It is set to 2 by default.


### Colors used in the images

- -c <color name>
Plots the image with variations of the color chosen. You can choose among: blue, cyan, green, magenta, red and yellow.

- -c <R,G,B>
Plots the image with variations of the color chosen. You must provide a tuple R,G,B with the color's RGB representation. Each value is an integer between 0 and 255.

For example, this would be the result of

### Others parameters

- **-k** Keeps a script plot.sh with the code to make the plot from bash.

- For more information about the parameters you can use `pl -h`.

## AUTHOR

Andrés Herrera Poyatos

## LICENSE

The MIT License (MIT)
Copyright (c) 2015 Andrés Herrera Poyatos

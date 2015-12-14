# `pl`

A command line interface for gnuplot.

## What can `pl` do for you?

[Gnuplot](http://www.gnuplot.info/) is a very powerfull language to make plots. However, it is very complex and, consecuently, it is difficult to make good plots without previous experience. `pl` tries to solve this issue providing a simple bash command to make plots in just a line of code.

`pl` supports 2D plots, generating images in png such as the following one:

![](https://github.com/andreshp/pl/blob/master/images/example.png)

You only has to pass the file with the data as an argument and `pl` will do the plot for you! For example, the previous image was plotted using `pl example.csv -t "An example with pl" -x "X Axis" -y "Y Axis"`.

## Instalation

1. You can clone the repository with `git clone` or download the [zip file](https://github.com/andreshp/pl/archive/master.zip).
2. The code needs to be compiled using make, which will ask you to install the dependencies that you don't have already installed.
3. If you want to use `pl` as an usual bash command, you should add the bin directory to the global variable PATH. To accomplish this, add the following line of code to your .bashrc file:

~~~
PATH=$PATH:<absolute path to /pl/bin/>
~~~

##

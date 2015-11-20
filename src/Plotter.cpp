////////////////////////////////////////////////////////////////////////////////
// Author: Andrés Herrera Poyatos
// University of Granada, ETSIIT
// Models of Computation, LEX
// A simple plot command for bash based on lex and gnuplot.
////////////////////////////////////////////////////////////////////////////////

/**
 * @file Plotter.cpp
 * @brief Plotter's methods implementation.
 *
 * See "Plotter.h" for a deeper description.
 */

#include "Plotter.h"

/////////////////////////////// PRIVATE METHODS ////////////////////////////////

//----------------------------- buildPlotScript ------------------------------//

void Plotter::buildPlotScript() {

    // Open a new file for the script.
    ofstream out(script_name.c_str());
    if(!out){
        throw logic_error("It was not possible to open the file " + script_name);
    }

    // Open the data to count the number of columns and search for legend.
    ifstream data(file_name.c_str());
    if(!data){
        throw logic_error("It was not possible to open the file " + file_name);
    }

    // Count the number of columns in the data.
    string first_line;
    getline(data, first_line);
    number_columns = count(first_line.begin(), first_line.end(), delimiter) + 1;

    out << "#!/bin/bash" << endl << endl;

    out << "################################################################################" << endl;
    out << "# Author: Andrés Herrera Poyatos                                                " << endl;
    out << "# University of Granada, ETSIIT                                                 " << endl;
    out << "# Models of Computation, LEX                                                    " << endl;
    out << "# A simple plot command for bash based on lex and gnuplot.                      " << endl;
    out << "################################################################################" << endl << endl;

    out << "# Scrit that plots an image with gnuplot."  << endl;
    out << "# The image is generated from " + file_name << endl << endl;

    out << "#---------------------------------- Plot --------------------------------------#" << endl << endl;

    out << "gnuplot << END" << endl << endl;

    out << "# Set the separator for the csv standard." << endl;
    out << "set datafile separator \"" << delimiter << "\"" << endl;

    out << "# Set the terminal to plot a png image." << endl;
    out << "set terminal pngcairo enhanced font 'Verdana,10'" << endl;
    out << "set border linewidth 1.5" << endl << endl;

    out << "# Style and line color." << endl;
    out << "# Function which passes rgb to gnuplot scale." << endl;
    out << "rgb(r,g,b) = r * 2**16 + g * 2**8  + b" << endl;

    // Compute the colors for the plot.
    // If there is no base color, then colors are computed varying the hue.
    vector<Color> selected_colors;
    if (base_color == NULL)
        selected_colors = ColorAlgorithms::generateColorsHue(number_columns-1);
    // Else, the base color is computing varying the brightness.
    else
        selected_colors = ColorAlgorithms::generateColorsBrightness(*base_color, number_columns-1);

    for (int i = 1; i < number_columns; i++){
        out << "set style line " << i << " lc rgb (rgb(" << selected_colors[i-1].getRed() << "," << selected_colors[i-1].getGreen() << "," << selected_colors[i-1].getBlue() << ")) lt 1 lw " << line_width << " pt 7 pi 0 ps 0.5" << endl;
    }
    out << "set pointintervalbox 0" << endl << endl;

    out << "# Set the image name." << endl;
    out << "set output '" << output_name << "'" << endl << endl;

    out << "# Set the tittle and the labels." << endl;

    if (title.size() > 0)
        out << "set title \"" << title << "\" enhanced font 'Verdana,14'" << endl;

//    out << "set xlabel "$XLABEL"" << endl;
//    out << "set ylabel "$YLABEL"" << endl << endl;

    out << "# Set the plot range (set offsets <left>, <right>, <top>, <bottom>)" << endl;
    out << "set offsets graph 0, 0, 0.05, 0.05" << endl << endl;

    out << "# Plot the data." << endl;
    out << "plot";
    for (int i = 1; i < number_columns; i++){
        out << " \'" << file_name << "\' using 1:" << i+1 << " title \"mi linea " << i << "\" with linespoints ls " << i;
        if (i < number_columns+1){
            out << ",";
        }
    }
    out << endl;

    out << endl << "END" << endl;

}

//-------------------------------- checkData ---------------------------------//

void Plotter::checkData() {
    if (file_name.size() == 0)
        throw runtime_error("A file with the data is needed. Use the parameter -f <file name>.");
    if (output_name.size() == 0)
        output_name = file_name_no_extensions + ".png";
}

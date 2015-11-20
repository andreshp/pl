////////////////////////////////////////////////////////////////////////////////
// Author: Andrés Herrera Poyatos
// University of Granada, ETSIIT
// Models of Computation, LEX
// A simple plot command for bash based on lex and gnuplot.
////////////////////////////////////////////////////////////////////////////////

/**
 * @file Plotter.h
 * @brief Include file for the Plotter class.
 *
 * Declaration of the Plotter class, which will plot the images according to the
 * saved data.
 */

#ifndef __PLOTTER__
#define __PLOTTER__

#include <algorithm>    // count
#include <cstdlib>      // system
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdexcept>    // exceptions
#include <string>

#include "Color.h"

using namespace std;

/**
 * @brief Enum which indicates the style of the plot.
 *
 * The style can be:
 * - Lines: The data determines lines, where the points are no plotted.
 * - Points: Just the points are plotted.
 * - Linespoints: Both lines and points are plotted.
 */
enum Style { LINES, POINTS, LINESPOINTS};

/**
 * @brief Class which collects all the information needed to plot a file.
 *        Afterwards, it can build a bash file with the code needed to do the plot.
 */
class Plotter {

    private:

        /**
         * @brief Base color for the plotter.
         */
        Color *base_color;

        /**
         * @brief Delimiter used in the data.
         *
         * It is , by default.
         */
        char delimiter;

        /**
         * @brief Vector with the name of the files to plot.
         */
        vector<string> file_names;

        /**
         * @brief Name of the file to plot without extensions.
         */
        string file_name_no_extensions;

        /**
         * @brief Indicate if the file data has a first line with the legend names.
         */
        bool has_legend;

        /**
         * @brief Width of the lines.
         *
         * It is 2 by default.
         */
        int line_width;

        /**
         * @brief Number of columns in the data.
         *
         * It is assigned a value in the method checkData().
         */
        int number_columns;

        /**
         * @brief Name of the png image generated as output.
         */
        string output_name;

        /**
         * @brief Name of the script which will produce the image.
         */
        string script_name;

        /**
         * @brief Style of the plot.
         */
        Style style;

        /**
         * @brief Title of the image.
         */
        string title;

        /**
         * @brief Label for the x axix.
         */
        string xlabel;

        /**
         * @brief Label for the y axix.
         */
        string ylabel;

        /**
         * @brief Build a bash script which can be runed to plot the image.
         */
        void buildPlotScript();

        /**
         * @brief Check if the data saved is enough to generate the image.
         *
         * If a needed variable is not initialised, then it thows an error.
         * If a not initialised variable can be infered, then it does so.
         */
        void checkData();

        /**
         * @brief Compute the largest substring starting at 0 with no extension or '.' character.
         * @param name String to which the computation is applied.
         * @return Largest substring starting at 0 with no extension.
         */
        string nameWhitoutExtensions(string name){
            int pos = name.find('.');
            if (pos == string::npos)
                return name;
            else
                return string(name.begin(),name.begin()+pos);
        }

    public:

        /**
         * @brief Constructor for the plotter.
         *
         * It initializes all the attributes to the values assigned by default.
         */
        Plotter() {
             base_color = 0;
             delimiter = ',';
             has_legend = false;
             line_width = 2;
             number_columns = 1;
             script_name = "plot.sh";
             style = LINESPOINTS;
        }

        /**
         * @brief Class destructor. base_color is deleted.
         */
        ~Plotter() {
            delete base_color;
        }

        /**
         * @brief Add a name of a file to plot.
         */
        inline void addFileName(string file_name) {
            file_names.push_back(file_name);
            if (file_name_no_extensions.size() == 0)
                file_name_no_extensions = nameWhitoutExtensions(file_name);
        }

        /**
         * @brief Add the name of a set of files to plot.
         */
        inline void addFileNames(vector<string> file_names) {
            for (int i = 0; i < file_names.size(); i++)
                addFileName(file_names[i]);
        }

        /**
         * @brief Plot the image.
         *
         * It uses the function buildPlotScript to generate a bash script which
         * is executed afterwards.
         */
        inline void plot() {
            checkData();
            buildPlotScript();
            system( ("bash " + script_name).c_str() );
        }

        /**
         * @brief Set the base color to plot the data.
         */
        inline void setBaseColor(int r, int g, int b) {
            base_color = new Color(r,g,b);
        }

        /**
         * @brief Set the base color to plot the data.
         */
        inline void setBaseColor(string color_name) {
            if (color_name == "red")
                base_color = new Color(255,0,0);
            else if (color_name == "yellow")
                base_color = new Color(255,255,0);
            else if (color_name == "green")
                base_color = new Color(0,255,0);
            else if (color_name == "cyan")
                base_color = new Color(0,255,255);
            else if (color_name == "magenta")
                base_color = new Color(255,0,255);
            else{
                base_color = new Color(0,0,255);
            }
         }

         /**
          * @brief Set the delimiter used in the data.
          */
         inline void setFileDelimiter(char delimiter) {
             this->delimiter = delimiter;
         }

         /**
          * @brief Set has_legend attribute to true.
          */
         inline void setLegend() {
             has_legend = true;
         }

         /**
          * @brief Set the image's line width.
          */
         inline void setLineWidth(int line_width) {
             this->line_width = line_width;
         }

         /**
          * @brief Set the name of the output file.
          */
         inline void setOutputName(string output_name) {
             this->output_name = output_name;
         }

         /**
          * @brief Set the image's style.
          */
         inline void setStyle(string style) {
             if (style == "lines" || style == "l")
                this->style = LINES;
             else if (style == "points" || style == "p")
                this->style = POINTS;
             else
                this->style = LINESPOINTS;
         }

         /**
          * @brief Set the image's title.
          */
         inline void setTitle(string title) {
             this->title = title;
         }

         /**
          * @brief Set the image's xlabel.
          */
         inline void setXLabel(string xlabel) {
             this->xlabel = xlabel;
         }

         /**
          * @brief Set the image's ylabel.
          */
         inline void setYLabel(string ylabel) {
             this->ylabel = ylabel;
         }

};

#endif

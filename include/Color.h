////////////////////////////////////////////////////////////////////////////////
// Author: Andrés Herrera Poyatos
// University of Granada, ETSIIT
// Models of Computation, LEX
// A simple plot command for bash based on lex and gnuplot.
////////////////////////////////////////////////////////////////////////////////

/**
 * @file Color.h
 * @brief Include file for the Color class.
 *
 * It contains algorithms to select a given number of colors.
 */

#ifndef __COLOR__
#define __COLOR__

#include <algorithm>    // count
#include <cstdlib>      // system
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdexcept>    // exceptions
#include <vector>

using namespace std;

/**
 * @brief Class which represents a color in both the RGB and HSV scheme.
 *
 * The values for RGB are between 0 and 255. 0,0,0 is white and 255,255,255 is black.
 * The HSV scheme is a 3-tuple (Hue, Saturation, Value) in [0,1]^3.
 */
struct Color {

    /**
     * @brief Value for red color.
     */
    int r;

    /**
     * @brief Value for green color.
     */
    int g;

    /**
     * @brief Value for blue color.
     */
    int b;

    /**
     * @brief Hue's value in [0,1].
     */
    double h;

    /**
     * @brief Saturation's value in [0,1].
     */
    double s;

    /**
     * @brief HSV value in [0,1].
     */
    double v;

    /**
     * @brief Constructor for the class.
     *
     * Obtain the values in rgb and convert them to HSV too.
     */
    Color(int r, int g, int b);

    /**
     * @brief Constructor for the class.
     *
     * Obtain the values in hsv (Hue, Saturation, Value) and convert them to RGB too.
     */
    Color(double h, double s, double v);

    /**
     * @brief Get the red color's value.
     */
    inline int getRed() {
        return r;
    }

    /**
     * @brief Get the green color's value.
     */
    inline int getGreen() {
        return g;
    }

    /**
     * @brief Get the blue color's value.
     */
    inline int getBlue() {
        return b;
    }

    inline Color mean(Color other) {
        return Color((r+other.r) / 2, (g+other.g) / 2, (b+other.b) / 2);
    }
};

/**
 * @brief Class which contains algorithms to generate different colors.
 */
class ColorAlgorithms {
    public:

        /**
         * @brief Gold number less 1.
         */
        static const double golden_ratio =  0.618033988749895;

        /**
         * @brief Compute a sucesion of colors based on the given one (base_color).
         * @param base_color Base color for the sucesion.
         * @param number_colors Number of colors to generate.
         * @return Vector with the generated colors.
         */
        static vector<Color> generateColors(Color base_color, int number_colors);

        /**
         * @brief Compute a given number of different colors varying the hue.
         * @param number_colors Number of colors to generate.
         * @return Vector with the generated colors.
         */
        static vector<Color> generateColorsHue(int number_colors);

        /**
         * @brief Compute a sucesion of colors based on the given one (base_color) but varying the brightness.
         * @param base_color Base color for the sucesion.
         * @param number_colors Number of colors to generate.
         * @return Vector with the generated colors.
         */
        static vector<Color> generateColorsBrightness(Color base_color, int number_colors);

        /**
         * @brief Compute a random color.
         */
        static Color randomColor() {
            return Color(rand() % 256, rand() % 256, rand() % 256);
        }
};

#endif

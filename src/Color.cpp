////////////////////////////////////////////////////////////////////////////////
// Author: Andrés Herrera Poyatos
// University of Granada, ETSIIT
// Models of Computation, LEX
// A simple plot command for bash based on lex and gnuplot.
////////////////////////////////////////////////////////////////////////////////

/**
 * @file Color.cpp
 * @brief Color's methods implementation.
 *
 * See "Color.h" for a deeper description.
 */

#include "Color.h"

///////////////////////////////// Color Class //////////////////////////////////

//----------------------------- RGB Constructor ------------------------------//

Color::Color(int r, int g, int b) {

    // Assign the HSV values.
    this->r = r;
    this->g = g;
    this->b = b;

    // min = min(r,g,b)
    int m = min(min(r,g),b);

    // max = max(r,g,b)
    int M = max(max(r,g),b);

    // Chroma is the distance from the hexagon center to the point projection.
    // It can be understood as color insensity.
    int chroma = M - m;

    // The value is the maximum of the rgb coordinates normalized.
    // It is related to lightness. In HSL model, the lightness is (m+M) / 2.
    this->v = (double)M / 255;

    // If chroma is 0, then the Hue is undefined, the color is neutral.
    if (chroma == 0) {
        // The saturation is 0.
        this->s = 0;

        // The Hue is undefined.
        this->h = 0;
    }
    else {
        // Note that M must be greater than 0 since chroma > 0.
        // Now we can define the saturation as the chroma normalized
        this->s = ((double)chroma / M);

        // Now we can compute the Hue of the color.
        // The hue is the angle of the color projection in the hexagon.
        // The hexagon has 6 vertices corresponding to red, magenta, blue, cyan, green and yellow.
        // Note that theese colors are (1,0,0), (1,0,1), (0,0,1), (0,1,1), (0,1,0) and (1,1,0) in rgb.

        // To compute the hue we find out which is the nearest vertice and then
        // find the angle with respect the next two other vertices.
        // Afterwards, the angle corresponding to the nearest vertice is added.
        // Note that as a consensus the hue of red is 0 degrees, the hue of green is 120 degrees and the hue of blue is 240 degrees.
        if (r == M)
            this->h = (double)(g - b) / chroma;             // between yellow & magenta
        else if(g == M)
            this->h = 2 + (double)(b - r ) / chroma;         // between cyan & yellow
        else
            this->h = 4 + (double) (r - g) / chroma;          // between magenta & cyan

        // If the hue is negative (between blue and red) then we add 6 to make it a positive degree.
        if (this->h < 0)
            this->h += 6;

        // The hue now is normalised to [0,1]
        this->h /= 6;
    }
}

//----------------------------- HSV Constructor ------------------------------//

Color::Color(double h, double s, double v) {

    // Assign the HSV values.
    this->h = h; // Hue
    this->s = s; // Saturation
    this->v = v; // Value

    // Obtain the variables needed for the RGB conversion.
    int h_i = h * 6; // Nearest color in the hexagon.
    double h_f = h * 6 - h_i; // determines the angle of the color corresponding to the other 2 nearest vertices.

    // v - chroma = min(r,g,b)
    int p = 255 * v * (1 - s);
    // v - h_f * chroma
    int q = 255 * v * (1 - h_f * s  );
    // v - (1 - h_f) * chroma
    int t = 255 * v * (1 - (1 - h_f) * s);

    // Assign the RGB values.
    switch (h_i) {
        case 0: // Red
        {
            r = 255*v; // Principal
            g = t; // Secondary - Right
            b = p; // min(r,g,b)
            break;
        }
        case 1: // Yellow
        {
            r = q; // Secondary - Left
            g = 255*v; // Principal
            b = p; // min(r,g,b)
            break;
        }
        case 2: // Green
        {
            r = p; // min(r,g,b)
            g = 255*v; // Principal
            b = t; // Secondary - Right
            break;
        }
        case 3: // Cyan
        {
            r = p; // min(r,g,b)
            g = q; // Secondary - Left
            b = 255*v; // Principal
            break;
        }
        case 4: // Blue
        {
            r = t; // Secondary - Left
            g = p; // min(r,g,b)
            b = 255*v; // Principal
            break;
        }
        case 5: // Magenta
        {
            r = 255*v; // Principal
            g = p; // min(r,g,b)
            b = q; // Secondary - Left
            break;
        }
    }
}

/////////////////////////////// ColorAlgorithms ////////////////////////////////

//----------------------------- generateColors ------------------------------//

vector<Color> ColorAlgorithms::generateColors(Color base_color, int number_colors) {

    Color current_color((1+base_color.r) / 2, (1+base_color.g) / 2, (1+base_color.b) / 2);
    vector <Color> chosen_colors;
    //((double) rand()) / RAND_MAX

    for (int i = 0; i < number_colors; i++){
        chosen_colors.push_back(randomColor().mean(base_color));
        current_color.r = (current_color.r + golden_ratio) + ((current_color.r + golden_ratio) <= 1? 0 : -1);
        current_color.g = (current_color.g + golden_ratio) + ((current_color.g + golden_ratio) <= 1? 0 : -1);
        current_color.b = (current_color.b + golden_ratio) + ((current_color.b + golden_ratio) <= 1? 0 : -1);
    }

    return chosen_colors;
}

//---------------------------- generateColorsHue -----------------------------//

vector<Color> ColorAlgorithms::generateColorsHue(int number_colors) {

    // Initial value for saturation.
    double saturation = 0.7;

    // Number of colors per value.
    static const int colors_per_value = 6;

    // Initial value.
    double value = 0.8;

    vector <Color> chosen_colors;

    // Add the number of colors to the vector. The hue is distributed uniformly in [0,1].
    for (int i = 0; i < number_colors; i++){
//        cout << (double) i / number_colors << "," << saturation << "," << value << endl;
        Color new_color((double) i / number_colors, saturation, value);
//        cout << new_color.r << "," << new_color.g << "," << new_color.b << endl;
        chosen_colors.push_back(new_color);

        // Update value
//        if ( (i+1) % colors_per_value == 0)
//            value += (1-value)*0.5;

        // Update saturation
//        if ( (i+1) % colors_per_value == 0 )
//            saturation += (1-saturation) * 0.5;

    }

    return chosen_colors;
}

//------------------------- generateColorsBrightness -------------------------//

vector<Color> ColorAlgorithms::generateColorsBrightness(Color base_color, int number_colors) {

    // Initial saturation.
    double saturation = 0;
    double hue = base_color.h;

    vector <Color> chosen_colors;

    // Add the number of colors to the vector. The hue is distributed uniformly in [0,1].
    for (int i = 0; i < number_colors; i++){
        chosen_colors.push_back(Color( 0.95 * base_color.h + 0.05 * hue, 0.2 + 0.8 * saturation, 0.3 + 0.7*(double) i / (number_colors-1)));

        saturation += golden_ratio;
        hue += golden_ratio;

        if (saturation > 1)
            saturation -= 1;
        if (hue > 1)
            hue -= 1;
    }

    return chosen_colors;
}

    ////////////////////////////////////////////////////////////////////////////
    // Author: Andrés Herrera Poyatos
    // University of Granada, ETSIIT
    // Models of Computation, LEX
    // A simple plot command for bash based on lex and gnuplot.
    ////////////////////////////////////////////////////////////////////////////

    //----------------------- Declarations Section ---------------------------//

%{

#include <fstream>
#include <iostream>
#include <string>
#include <stdexcept>

#include "Plotter.h"

using namespace std;

/**
 * @brief Boolean which tells if there is an error in the input.
 */
bool error = false;

/**
 * @brief Length of a parameters indicator. They are "-x", where x is a fixed char.
 */
const int parameter_length = 2;

/**
 * @brief The plotter which collects all the information.
 */
Plotter pl;

/**
 * @brief Obtain a string from the imput with no blancs.
 */
string parseInput(char* input, int size);

/**
 * @brief Converts a string of the form r,g,b to the rgb tuple with the values.
 * @param rgb String with a rgb tuple writen as r,g,b or (r,g,b).
 * @param red Variable where the red value will be saved.
 * @param green Variable where the green value will be saved.
 * @param blue Variable where the blue value will be saved.
 */
void stringToRGB(string &rgb, int &red, int &green, int &blue);

/**
 * @brief Split a string in words by a delimiter, returning a vector with the words obtained.
 * @param s String to split.
 * @param delim Delimiter which determines how the string is splitted. It is a space by default.
 * @return Vector with the words.
 */
vector<string> split(const string &s, char delim = ' ');
%}

letter              [a-zA-Z]
digit               [0-9]
number              {digit}+
space               [ \t]*
other_characters    [!#$%&'\*\+-\/=?\^_`{\|}~.]

delimiter           ["']
character           {letter}|{digit}|{other_characters}
char_delimited      {delimiter}({character}|{space}){delimiter}
char                {character}|{char_delimited}

word                ({letter}|{digit}|{other_characters})+

line                ({delimiter}({word}|{space})+{delimiter})

color_name          (cyan|blue|green|magenta|red|yellow)
color_rgb           \(?{number},{number},{number}\)?

style               (lines|points|linespoints|l|p|lp)

%%

    /*-------------------------- Rules Section -------------------------------*/

-c{space}{color_name}     {pl.setBaseColor(parseInput(yytext, yyleng));        }

-c{space}{color_rgb}      {int red, green, blue;
                           string rgb = parseInput(yytext, yyleng);
                           stringToRGB(rgb, red, green, blue);
                           pl.setBaseColor(red, green, blue);                  }

-d{space}{char}      {pl.setFileDelimiter(parseInput(yytext, yyleng)[0]);      }

-e                   {system( ("python3 " + getSelfPath() + "/script/example.py").c_str() ); exit(0); }

-f{space}{word}      {pl.addFileName(parseInput(yytext, yyleng));              }
-f{space}{line}      {pl.addFileNames(split(parseInput(yytext, yyleng)));       }

-h                   {pl.help(); exit(0);                                      }

-k                   {pl.keepPlotFile();                                       }

-l                   {pl.setLegend();                                          }

-kl                   {pl.keepPlotFile(); pl.setLegend();                      }

-o{space}{word}      {pl.setOutputName(parseInput(yytext, yyleng));            }

-s{space}{style}     {pl.setStyle(parseInput(yytext, yyleng));                 }

-t{space}{word}      {pl.setTitle(parseInput(yytext, yyleng));                 }
-t{space}{line}      {pl.setTitle(parseInput(yytext, yyleng)); }

-w{space}{number}    {pl.setLineWidth(atoi(parseInput(yytext, yyleng).c_str()));}

-x{space}{word}      {pl.setXLabel(parseInput(yytext, yyleng));                }
-x{space}{line}      {pl.setXLabel(parseInput(yytext, yyleng));}

-y{space}{word}      {pl.setYLabel(parseInput(yytext, yyleng));                }
-y{space}{line}      {pl.setYLabel(parseInput(yytext, yyleng));}

{word}\.{word}       {pl.addFileName((string)yytext);}

{space}              {}
.                    {cout << "Error, the next code is not recognized: "; ECHO; cout << endl; error = true;}

%%

//--------------------------- Procedures Section -----------------------------//

// Point to other file which will be analyzed afterwards.
int yywrap() {
    return 1;
}

// Implementation of the parse input procedure.
string parseInput(char* input, int size) {
    int pos = parameter_length;
    while (pos < size && (input[pos] == ' ' || input[pos] == '\t' || input[pos] == '\n' || input[pos] == '"' || input[pos] == '\''))
        pos++;

    string new_input((string) &input[pos]);

    if (new_input[new_input.size()-1] == '"' || new_input[new_input.size()-1] == '\'')
        return new_input.substr(0,new_input.size()-1);

    return new_input;
}

// Implementation of the split procedure.
vector<string> split(const string &s, char delim) {
    vector<string> elems;
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}

// Implementation of the stringToRGB function.
void stringToRGB(string &rgb, int &red, int &green, int &blue) {
    // Parse the parenthesis.
    if (rgb[0] == '(')
        rgb = rgb.substr(1, rgb.size() - 1);
    if (rgb[rgb.size()-1] == ')')
        rgb = rgb.substr(0, rgb.size() - 1);

    // Find the first comman in the string.
    // The first comma separates the red from the other colors.
    int first_comma = rgb.find(',');

    // Compute the red value.
    red = atoi(string(rgb.begin(), rgb.begin()+first_comma).c_str());

    // Remove the red value and the first comma.
    string gb = rgb.substr(first_comma+1);

    // Compute the second comma position.
    int second_comma = gb.find(',');
    // Obtain the green value.
    green = atoi(string(gb.begin(), gb.begin()+second_comma).c_str());
    // Obtain the blue value.
    blue = atoi(gb.substr(second_comma+1).c_str());
}

// Main program. The arguments are analyzed and, afterwards, the plotter build the image.
int main (int argc, char *argv[]) {

    // Initializes random number generator
    srand(time(0));

    // Proccess arguments to call lex from them.
    if (argc > 1 && argv[1]){

        string input = "", arg;
        int find_blanc;

        // Concatenate the input in one string.
        for (int i = 1; i < argc; i++){
            arg = string(argv[i]);
            find_blanc = arg.find(' ');

            if (find_blanc != string::npos) {
                if (arg[0] != '-')
                    input += "\"" + arg + "\"" + ' ';
                else
                    input += arg.substr(0,2) + "\"" + arg.substr(2) + "\"" + ' ';
            }
            else input = input + arg + ' ';
        }

        yy_scan_string(input.c_str());
        yylex();
    }
    else{
        cout << "Enter pl -h to see the help menu." << endl;
        exit(1);
    }

    // If the input has an error, then the user is told to repair it.
    if (error == true) {
        cout << "Please, check the input since there are lexical errors." << endl;
        exit(1);
    }

    pl.plot();

    return 0;
}

    ////////////////////////////////////////////////////////////////////////////
    // Author: Andrés Herrera Poyatos
    // University of Granada, ETSIIT
    // Models of Computation, LEX
    // A simple plot command for bash based on lex and gnuplot.
    ////////////////////////////////////////////////////////////////////////////

    //----------------------- Declarations Section ---------------------------//

%{

#include <iostream>
#include <fstream>
#include <string>
#include <stdexcept>

#include "Plotter.h"

using namespace std;

// Const variables
const int parameter_length = 2;

// The plotter which collects all the information.
Plotter pl;

/**
 * @brief Converts an integer to string.
 * @param x Integer to convert.
 * @return String with the integer.
 */
string to_string(int x);

%}

letter              [a-zA-Z]
digit               [0-9]
number              {digit}+
space               [ \t]+
other_characters    [!#$%&'\*\+-\/=?\^_`{\|}~]

delimiter           ["']
character           {letter}|{digit}|{other_characters}
char_delimited      {delimiter}({character}|{space}){delimiter}

word                ({letter}|{digit}|{other_characters})+

line                ({delimiter}({word}|{space})+{delimiter})

color_name          (cyan|blue|green|magenta|red|yellow)
color_rgb           number,number,number
%%

    /*-------------------------- Rules Section -------------------------------*/

-c{color_name}            {pl.setBaseColor((string) &yytext[parameter_length]);   }
-c{space}{color_name}     {pl.setBaseColor((string) &yytext[parameter_length+1]); }

-d{character}             {pl.setFileDelimiter((char)yytext[parameter_length]);   }
-d{space}{character}      {pl.setFileDelimiter((char)yytext[parameter_length+1]); }
-d{char_delimited}        {pl.setFileDelimiter((char)yytext[parameter_length+1]); }
-d{space}{char_delimited} {pl.setFileDelimiter((char)yytext[parameter_length+2]); }

-f{space}{word}      {pl.setFileName((string)&yytext[parameter_length+1]);     }
-f{word}             {pl.setFileName((string)&yytext[parameter_length]);       }

-o{space}{word}      {pl.setOutputName((string)&yytext[parameter_length+1]);   }
-o{word}             {pl.setOutputName((string)&yytext[parameter_length]);     }

-w{space}{number}    {pl.setLineWidth(atoi(&yytext[parameter_length+1]));      }
-w{number}           {pl.setLineWidth(atoi(&yytext[parameter_length]));        }

-t{space}{word}      {pl.setTitle((string)&yytext[parameter_length+1]);        }
-t{word}             {pl.setTitle((string)&yytext[parameter_length]);          }
-t{space}{line}      {pl.setTitle(((string)&yytext[parameter_length+1]).substr(1, yyleng - parameter_length-3));    }
-t{line}             {pl.setTitle(((string)&yytext[parameter_length]).substr(1, yyleng - parameter_length-2));      }

{space}              {}
.                    {cout << "Error, the next code is not recognized: "; ECHO; cout << endl;}

%%

//--------------------------- Procedures Section -----------------------------//

// Point to other file which will be analyzed afterwards.
int yywrap() {
    return 1;
}

/**
 * @brief Converts an integer to string.
 * @param x Integer to convert.
 * @return String with the integer.
 */
string to_string(int x){
return "";//    return dynamic_cast< std::ostringstream & >( ( std::ostringstream() << std::dec << x ) ).str();
}


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
            cout << arg << endl;
            find_blanc = arg.find(' ');
            if (find_blanc != string::npos) {
                if (arg[0] != '-')
                    input += "\"" + arg + "\"" + ' ';
                else
                    input += arg.substr(0,2) + "\"" + arg.substr(2) + "\"" + ' ';
            }
            else input = input + arg + ' ';
            cout << input << endl;
        }

        yy_scan_string(input.c_str());

        yylex();
    }
    else{
        cout << "Enter pl -h to see the help menu." << endl;
    }

    pl.plot();

    return 0;
}

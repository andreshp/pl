################################################################################
# Authors: Andrés Herrera Poyatos
# University of Granada
# Models of Computation - A plot command for bash based on lex and gnuplot.
################################################################################

# Makefile for the Timetabling-Vehicle Scheduling solution.

#-------------------------------- Variables -----------------------------------#

# Compiler and Flags:

CXX=g++
CC=$(CXX)
CPPFLAGS=-c -g
CXXFLAGS=-I$(INCLUDE)
LDFLAGS=-L$(LIB)
LOADLIBS=-lutilities -lalgorithms
ARFLAGS=rvs

# Directories:

BIN=./bin
DOC=./doc
INCLUDE =./include
OBJ=./obj
SCRIPT=./script
SRC=./src

# Modules, Source Code and Executables:

EXECUTABLE=pl

#---------------------------------- Rules -------------------------------------#

# Compile the whole project.
compile: check_gnuplot make_directories $(BIN)/$(EXECUTABLE) final_comments

# Check if gnuplot is installed. If it is not, then tell the user to install it.
check_gnuplot:
	@if [ ! "`dpkg -l | grep -E '^ii' | grep " gnuplot "`" ]; then \
		echo "The program gnuplot is required.\nPlease, install it using the following command:\n"; \
		echo "sudo apt-get install gnuplot\n"; \
		exit 2; \
	fi

# Check if lex is installed. If it is not, then tell the user to install it.
check_lex:
	@if [ ! "`dpkg -l | grep -E '^ii' | grep " flex "`" ]; then \
		echo "The program flex is required.\nPlease, install it using the following command:\n"; \
		echo "sudo apt-get install flex\n"; \
		exit 2; \
	fi

# Make all the directories.
make_directories:
	@echo "Building all the directories..."
	mkdir -p $(BIN)
	mkdir -p $(OBJ)

final_comments:
	@echo "\nIf you want to use pl as an usual bash command, then add the following code to your .bashrc file:"
	@echo "PATH=\$$PATH:`pwd`/bin"

# Build the executable file
$(BIN)/$(EXECUTABLE): $(OBJ)/main.o $(OBJ)/Plotter.o $(OBJ)/Color.o
	@echo "Building the executable $@..."
	$(CC) -g -o $(BIN)/$(EXECUTABLE) $^

# Build the object main.o
$(OBJ)/main.o: $(SRC)/Parser.c
	@echo "Building the module $@..."
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $(SRC)/Parser.c

# Build the object Plotter.o
$(OBJ)/Plotter.o: $(INCLUDE)/Plotter.h $(SRC)/Plotter.cpp
	@echo "Building the module $@..."
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $(SRC)/Plotter.cpp

# Build the object Color.o
$(OBJ)/Color.o: $(INCLUDE)/Color.h $(SRC)/Color.cpp
	@echo "Building the module $@..."
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $(SRC)/Color.cpp

# Obtain the code Parser.c
$(SRC)/Parser.c: $(SRC)/plot.l
	@echo "Parsing the lex code $<..."
	$(MAKE) check_lex
	lex -o $@ $<

# Clean the files .o, .a and the executables.
clean:
	@echo "Cleaning the files .o, .a and the executables..."
	rm $(OBJ)/*.o $(BIN)/*

# Makes the doxygen documentation.
document:
	doxygen $(DOC)/doxys/Doxyfile

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
INCLUDE =./include
LIB=./lib
OBJ=./obj
SRC=./src
DOC=./doc
SCRIPTS=./scripts

# Modules, Source Code and Executables:

EXECUTABLE=pl

OBJECTS=$(OBJ)/main.o

#---------------------------------- Rules -------------------------------------#

# Compile the whole project.
compile: make_directories $(BIN)/$(EXECUTABLE)

# Make all the directories.
make_directories:
	@echo "Building all the directories..."
	mkdir -p $(BIN)
	mkdir -p $(INCLUDE)
	mkdir -p $(LIB)
	mkdir -p $(OBJ)
	mkdir -p $(SRC)
	mkdir -p $(DOC)

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
	lex -o $@ $<

# Clean the files .o, .a and the executables.
clean:
	@echo "Cleaning the files .o, .a and the executables..."
	rm $(OBJ)/*.o $(BIN)/* $(LIB)/*.a

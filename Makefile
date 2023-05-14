CC := cc
MY_COMPILER := custom_compiler
SRC_FOLDER := ./samples
SOURCES := $(wildcard $(SRC_FOLDER)/*.c)
TARGET := $(MY_COMPILER)


# Setup bison / flex if not installed yet.
setup:
	sudo apt install -y bison flex


# Build the compiler.
build:
	lex lex.l
	yacc -d yacc.y
	$(CC) lex.yy.c y.tab.c -o $(MY_COMPILER)


# Build the test files in the samples folder
$(SOURCES): $(TARGET)
	-./$(MY_COMPILER) $@

# Compile all test files
test: $(SOURCES)

# Clean up the clutter.
clean:
	rm -f lex.yy.c y.tab.c y.tab.h $(MY_COMPILER)

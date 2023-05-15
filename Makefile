CC := cc
MY_COMPILER := custom_compiler
SRC_FOLDER := ./samples
SOURCES := $(wildcard $(SRC_FOLDER)/*.c)
TARGET := $(MY_COMPILER)


# Setup bison / flex if not installed yet.
setup:
	# Ubuntu
	#sudo apt install -y bison flex
	# Arch Linux
	sudo pacman -S bison flex libc++ clang llvm


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

# Generate Assembly and Link it using ld
assembly:
	# 使用clang產生中間表示型式。
	clang -S -emit-llvm $(SRC_FOLDER)/sample3.c
	# 使用opt最佳化中間表示型式。
	opt -S -globalopt -loop-simplify -mem2reg sample3.ll
	# 使用llc將中間表示型式轉換為組合語言
	llc sample3.ll
	# 使用as將組合語言轉換為目的檔
	as sample3.s -o sample3.o
	# 使用ld連結函式庫並設定程式進入點，產生執行檔。
	ld sample3.o -e main -o sample3
	# 執行
	./sample3

# Clean up the clutter.
clean:
	rm -f lex.yy.c y.tab.c y.tab.h *.ll *.s *.o $(MY_COMPILER)

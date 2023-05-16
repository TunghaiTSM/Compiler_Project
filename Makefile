CC := cc
MY_COMPILER := custom_compiler
SRC_FOLDER := ./samples
SOURCES := $(wildcard $(SRC_FOLDER)/*.c)
TARGET := $(MY_COMPILER)
# -lc = LIBC = /usr/lib/libc.so
LD_DYNAMIC_OPTIONS := -dynamic-linker /lib/ld-linux-x86-64.so.2 /usr/lib/crt1.o /usr/lib/crti.o sample3.o -lc /usr/lib/crtn.o


# Setup bison / flex if not installed yet.
setup-ubuntu:
	# Ubuntu
	sudo apt install -y bison flex clang llvm
setup-arch:
	# Arch Linux (comes with libc++ by default)
	sudo pacman -S bison flex clang llvm


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
	ld $(LD_DYNAMIC_OPTIONS) -o sample3
	# 執行
	./sample3

# Clean up the clutter.
clean:
	rm -f lex.yy.c y.tab.c y.tab.h *.ll *.s *.o sample3 $(MY_COMPILER)

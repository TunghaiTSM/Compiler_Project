# Compiler Final Project
## 簡報檔: https://www.overleaf.com/9127191685zyhsmfksqkkt

---
## System: Arch Linux

## Instructions:
### 1. `make setup-arch` (也有`make setup-ubuntu`)
- 安裝需要的軟體。
<img width="819" alt="image" src="https://github.com/pedestrianlove/Compiler_Project/assets/37164678/1faf40c2-514c-408a-8031-e7a7a61af23c">


### 2. `make build`
- 從yacc, lex檔案生成我們的編譯器。
<img width="1411" alt="image" src="https://github.com/TunghaiTSM/Compiler_Project/assets/37164678/ddf2bca5-cdba-48f9-9b31-7cc684d9087e">


### 3. `make test`
- 使用`samples/`資料夾下所列的範例程式進行我們產生的compiler測試。
<img width="659" alt="image" src="https://github.com/TunghaiTSM/Compiler_Project/assets/37164678/99987aa3-0810-4e34-a41e-92acb99df7cb">

- `sample3.c`會有錯誤是因為他加了標頭檔，無法被我們的編譯器識別。

### 3. `make assembly`
- 使用LLVM裡的`clang`及`llc`，生成組合語言。
- 我們使用`sample3.c`作為我們測試的對象:
```c
#include <stdio.h>
int main(void)
{
   int x=1;
   int y=2;
   int z=3;
   x=y+z;
   printf ("The value of x is: %d\n", x);
}
```
<img width="1027" alt="image" src="https://github.com/TunghaiTSM/Compiler_Project/assets/37164678/7030003f-ea2c-4296-bcc7-9e7bc5deb41b">
<img width="1308" alt="image" src="https://github.com/TunghaiTSM/Compiler_Project/assets/37164678/3338260e-882b-48e5-88de-9b67942e9dee">

- (請幫我補充至簡報內)一開始的時候我們並不知道如何使用ld這個指令，因此編譯出來的程式都會一直出現Segmentation Fault.但是當看了老師提供的教學之後，裡面提到的StackOverflow上的問答讓我們得以跟據其原理及我們系統的需求調整參數(另外還發現了-lc = /usr/lib/libc.so)

- Makefile
![image](https://github.com/pedestrianlove/Compiler_Project/assets/37164678/c6f569b6-8be1-4780-a031-e504f80aca91)
![image](https://github.com/pedestrianlove/Compiler_Project/assets/37164678/91405c63-621b-4a88-98b0-350d56651a38)


### 4. 收工，結束這回合。

---
## Resources:

### Gist discussion:
- https://gist.github.com/codebrainz/2933703

### Lex, Yacc files:
- https://www.quut.com/c/ANSI-C-grammar-l-2011.html
- https://www.quut.com/c/ANSI-C-grammar-y-2011.html

### Tutorial:
- https://home.gamer.com.tw/creationDetail.php?sn=4043752

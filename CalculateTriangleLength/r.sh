#/bin/bash

#Program name "Area of Triangle"
#Author: Minjae Kim
#Author email: gorgeous9802@csu.fullerton.edu
#Author CWID: 885206615
#Author class: CPSC240-09
#This file is the script file that accompanies the "Area of Triangle" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file producer.asm"
nasm -f elf64 -l producer.lis -o producer.o producer.asm

echo "Assemble the source file sin.asm"
nasm -f elf64 -l sin.lis -o sin.o sin.asm

echo "Compile the source file director.c"
gcc  -m64 -Wall -no-pie -o director.o -std=c2x -c director.c -lm

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o hm5.out sin.o producer.o director.o -std=c++11 -Wall -z noexecstack -lm

echo "Execute the program that calculate area of a triangle"
chmod +x hm5.out
./hm5.out

echo "This bash script will now terminate."
#/bin/bash

#Program name "Non-deterministic Random Numbers"
#Author: Minjae Kim
#Author email: gorgeous9802@csu.fullerton.edu
#Author CWID: 885206615
#Author class: CPSC240-09
#This file is the script file that accompanies the "Non-deterministic Random Numbers" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Compile the source file main.c"
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Assemble the source file executive.asm"
nasm -f elf64 -o executive.o executive.asm

echo "Assemble the source file isnan.asm"
nasm -f elf64 -o isnan.o isnan.asm

echo "Assemble the source file show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Assemble the source file normalize_array.asm"
nasm -f elf64 -o normalize_array.o normalize_array.asm

echo "Assemble the source file fill_random_array.asm"
nasm -f elf64 -o fill_random_array.o fill_random_array.asm

echo "Compile the source file sort.cpp"
g++  -m64 -Wall -no-pie -o sort.o -std=c++11 -c sort.cpp

echo "Linking the object modules to create an executable file"
g++ -m64 -no-pie -o hw5.out -std=c++11 show_array.o sort.o main.o executive.o fill_random_array.o isnan.o normalize_array.o

echo "Execute the program that calculate variance"
chmod +x hw5.out
./hw5.out

echo "This bash script will now terminate."
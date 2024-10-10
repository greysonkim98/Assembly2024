#/bin/bash

#Program name "Arrays"
#Author: Minjae Kim
#Author email: gorgeous9802@csu.fullerton.edu
#Author CWID: 885206615
#Author class: CPSC240-09
#This file is the script file that accompanies the "Arrays" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm -gdwarf

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm -gdwarf

echo "Assemble the source file input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm -gdwarf

echo "Assemble the source file compute_mean.asm"
nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm -gdwarf

echo "Compile the source file main.c"
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c -lm -g

echo "Compile the source file output_array.c"
gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c -lm -g

echo "Compile the source file compute_variance.cpp"
g++  -m64 -Wall -no-pie -o compute_variance.o -std=c++11 -c compute_variance.cpp -lm -g

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o Array.out input_array.o isfloat.o manager.o main.o compute_variance.o output_array.o compute_mean.o -std=c++11 -Wall -z noexecstack -lm

echo "Execute the program that calculate the variance"
chmod +x Array.out
gdb ./Array.out

echo "This bash script will now terminate."
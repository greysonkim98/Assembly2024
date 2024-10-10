#/bin/bash

#Program name "Triangles"
#Author: Minjae Kim
#Author email: gorgeous9802@csu.fullerton.edu
#Author CWID: 885206615
#Author class: CPSC240-09
#This file is the script file that accompanies the "Triangles" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file triangles.asm"
nasm -f elf64 -l triangles.lis -o triangles.o triangles.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file driver.c"
gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c -lm

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o triangles.out isfloat.o triangles.o driver.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program that calculate the thied side of triangle"
chmod +x triangles.out
./triangles.out

echo "This bash script will now terminate."

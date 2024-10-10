#/bin/bash

#Program name "Average Speed"
#Author: Minjae Kim
#Author email: gorgeous9802@csu.fullerton.edu
#Author CWID: 885206615
#Author class: CPSC240-09
#This file is the script file that accompanies the "Average Speed" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file average.asm"
nasm -f elf64 -l average.lis -o average.o average.asm

echo "Compile the source file driver.c"
gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o average.out average.o driver.o -std=c2x -Wall -z noexecstack

echo "Execute the program that calculate average speed"
chmod +x average.out
./average.out

echo "This bash script will now terminate."

#Faça um programa que calcule a seguinte equação:
#y = 3x2 - 5x + 13
#Armazene x no registrador $t5 com a instrução addi $t5, $zero, x, substituindo x pelo
#valor desejado, e sempre que precisar o valor de x, utilize o valor armazenado no
#registrador $t5.
#Armazene o resultado y no registrador $t6.
#Faça teste com diferentes valores positivos e negativos de x.
#Faça um teste substituindo a primeira instrução addi por uma instrução ori
#equivalente e responda, nos comentários, qual o resultado quando são usados números
#positivos e números negativos.

## t5 <= x
addi $t5, $zero, 2
## t6 <= y
## y = x(3x -5) + 13
## t6 <= 3x
sll $t6, $t5, 1
add $t6, $t6, $t5
## t6 <= 3x -5
addi $t6, $t6, -5
## t6 <= x(3x - 5)
mult $t6, $t5
mflo $t6
## t6 <= x(3x - 5) + 13
addi $t6, $t6, 13 


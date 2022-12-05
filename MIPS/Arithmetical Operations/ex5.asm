#Faça um programa que calcule a seguinte equação:
#y = 9x + 7/2x + 8
#Armazene x em $t1, com a instrução addi $t1, $zero, x, substituindo x pelo valor
#desejado, e sempre que precisar o valor de x, utilize o valor armazenado no
#registrador $t1.
#Armazene o quociente da divisão em $t4 e o resto em $t5.
#Responda o que acontece quando x = -4
##t1 <= x
addi $t1, $zero, 1
## t2 <= 9x + 7
sll $t2, $t1, 3
add $t2, $t1, $t2
addi $t2, $t2, 7
## t3 <= 2x + 8
sll $t3, $t1, 1
addi $t3, $t3, 8
## 9x + 7/2x + 8
div $t2, $t3
mflo $t4
mfhi $t5

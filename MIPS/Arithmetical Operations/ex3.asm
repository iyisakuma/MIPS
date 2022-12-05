#Escreva um programa que calcule o valor de
#4x - 2y + 3z (armazene os valores de x, y e z em $t1, $t2 e $t3,
#respectivamente) e coloque o resultado em $t7. Faça testes com alguns
#valores diferentes de x, y e z. Utilize apenas instruções já vistas na
#disciplina.

## x <= 1
addi $t1, $zero, 1
## y <= 2
addi $t2, $zero, 2
## z <= 3
addi $t3, $zero, 3

## x <= 4x
sll $t1, $t1, 2
## y <= 2y
sll $t2, $t2, 1
## t7 <= 3z
sll $t7, $t3, 1
add $t7, $t3, $t7
## t7 <= 3z +4x
add $t7, $t7, $t1
## t7 <= 4x - 2y + 3z
sub $t7, $t7, $t2
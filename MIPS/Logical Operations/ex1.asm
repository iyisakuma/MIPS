##Faça um programa que escreva o valor 0xDECADA70 no registrador
##$t1, incluindo um dígito hexadecimal por vez (isto é, insira letra por
##letra, individualmente) no registrador.

ori $t1, $zero, 0xD
sll $t1, $t1, 4
or $t1, $t1, 0xE
sll $t1, $t1, 4
or $t1, $t1, 0xC
sll $t1, $t1, 4
or $t1, $t1, 0xA
sll $t1, $t1, 4
or $t1, $t1, 0xD
sll $t1, $t1, 4
or $t1, $t1, 0xA
sll $t1, $t1, 4
or $t1, $t1, 0x7
sll $t1, $t1, 4
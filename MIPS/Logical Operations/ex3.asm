#Comece um programa pela instrução: ori $t1, $zero, 0x01. Usando
#apenas as instruções lógicas do tipo R (dois registradores como
#operandos) or, and e xor e instruções de shift (isto é, sem usar outras
#instruções ori além da inicial e nem instruções nor),
#escreva 0xFFFFFFFF em $t1. Procure usar o menor número de
#instruções possível.

##t1 <= ..0001
ori $t1, $zero, 0x01
##t2 <= ..0010
sll $t2, $t1, 1
## t1<= ..0011
or $t1, $t1, $t2
## t2 <= ..1100
sll $t2, $t1, 2
## t1 <= ..1111 (f)
or $t1, $t1, $t2
## t2 <= ..11110000(f0)
sll $t2, $t1, 4
## t1 <= ....11111111(00ff)
or $t1, $t1, $t2
## t2 <= (ff00)
sll $t2, $t1, 8
## t1 <= ffff
or $t1, $t1, $t2
## t2 <= ffff0000
sll $t2, $t1, 16
## t1 <= ffffffff
or $t1, $t2, $t1




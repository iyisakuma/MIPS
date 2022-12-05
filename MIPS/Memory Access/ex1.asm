#Faça um programa que calcule a seguinte equação:
#y = 32ab - 3a + 7b - 13
#Utilize endereços de memória para armazenar o valore de a, b e o resultado y. Cada
#valor deve ocupar 4 bytes na memória (.word), assim como para o resultado (.space
#4). Utilize as três primeiras posições da memória .data para armazenar,
#consecutivamente, a, b e y, iniciando o código com:
#	.data
#		a: .word 3
#		b: .word 5
#		y: .space 4

.data 
	a: .word 3
	b: .word 5
	y: .space 4
	
.text
	lui $t0, 0x1001
	lw $t1, 0($t0)
	lw $t2, 4($t0)
	## y <= 32ab
	mult $t1, $t2
	mflo $t3
	sll $t3, $t3, 5
	## y <= 32ab - 13
	subi $t3, $t3, 13
	## t4 <= 3a 
	sll $t4, $t1, 2
	sub $t4, $t4, $t1
	## y <= 32ab - 3a -13
	sub $t3, $t3, $t4
	## t4 <= 7b
	sll $t4, $t2, 3
	sub $t4, $t4, $t2
	## y <= 32ab - 3a + 7a -13
	add $t3, $t3, $t4
	sw $t3, 8($t0) 
	
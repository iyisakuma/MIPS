# Escreva um programa que inverta a ordem dos elementos de um vetor (.word) com 5
# posições. Por exemplo, a entrada: 1, 2, 3, 4, 5 deve produzir 5, 4, 3, 2, 1.
# A resposta deve ser o vetor de entrada modificado, e não um novo vetor na memória,
# ou seja, iniciando no endereço de memória 0x10010000.
.data 
	.word 5
	.word 1, 2, 3, 4, 5
.text
	INICIO:
		lui $t0, 0x1001 ##Ponteiro para o endereco
		lw $t1, 0($t0)	##Guarda o valor do tamanho
		li $t2, 0 ##Contador
	LER_MEMORIA:
		addi $t0, $t0, 4 ##Aponta para proxima memoria
		beq $t2, $t1, ESCREVE_MEMORIA
		lw $a0, 0($t0)
		jal PUSH_STACK
		addi $t2, $t2, 1 ##Contador ++
		j LER_MEMORIA
	ESCREVE_MEMORIA:
		lui $t0, 0x1001
	FOR_ESCREVE_MEMORIA:
		addi $t0, $t0, 4
		beq $t2, $zero, FIM
		jal POP_STACK ##Desempilha a pilha e guarda o valor no registrador $v1
		sw $v1, 0($t0) 
		addi $t2, $t2, -1
		j FOR_ESCREVE_MEMORIA
	POP_STACK:
		lw $v1, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	PUSH_STACK:
		addiu $sp, $sp, -4
		sw $a0, 0($sp)
		jr $ra
	FIM:
		li $v0, 10
		syscall
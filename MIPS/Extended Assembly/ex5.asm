.data
	tamanho: .word 7
	vetor1: .word -30, -23, 56, -43, 72, -18, 71
	vetor2: .word 45, 23, 21, -23, -82, 0, 69
	soma: .word 0, 0, 0, 0, 0, 0, 0
.text
PREPARACAO:
	#Ler o tamanho 
	lui $t0, 0x1001
	lw $t3, 0($t0) #t3 <= tamanho_vetor
	#Inicializacao de ponteiros para cada vetor 
	la $t1, vetor1
	la $t2, vetor2
	la $t0, soma
	#Inicializa um contador
	li $t4, 0
MAIN:
	slt $t5, $t4, $t3 #Seta 1 no registrador t5 se t4 for menor que t3
	beqz $t5 , FIM
	jal SOMA_VETOR
	addi $t4, $t4, 1
	j MAIN
SOMA_VETOR:
	lw $t6, 0($t1)
	lw $t7, 0($t2)
	add $t8, $t7, $t6
	sw $t8, 0($t0)
	#Ponteiros aponta para os proximos elementos
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	addi $t0, $t0, 4
	jr $ra
FIM:
	li $v0, 10
	syscall


# Solucao:
# No instante que encontrar uma desordem decrescente seta 0 na flag. Porem supoe inicialmente que 
# o vetor esteja ordenado
.data
	tamanho: .word 10
	vetor: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	
.text

	main:
		
		lui $t1, 0x1001 ## Ponteiro
		lw $t2, 0($t1) ## t2 <= tamanho do vetor
		addi $t3, $zero, 1  ## Contador
		addi $t0, $t0, 1 
		addi $t1, $t1, 4 ## aponta para o inicio do vetor
		
	loop:##leitura de vetores dois a dois 
		beq $t3, $t2, fim ## if(contador == tamanho_vetor)
		lw $t5, 0($t1)
		lw $t4, 4($t1) 
		slt $t0, $t5, $t4
		addi $t3, $t3, 1
		j loop 
	fim:
		nop
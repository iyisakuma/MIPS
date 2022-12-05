.data 
	String: .asciiz "Gosto muito do meu professor de AOC-I."
	
.text
	main:
		lui $t0, 0x1001 ##ponteiro
		addiu $t1, $zero, 32 ##SPACE ASCII
		
	loop:
		lbu $t2, 0($t0) ##Ler um caracter da string
		beq $t2, $zero, fim ##Fim da string / if ( t2 == \0)  
		bne $t2, $t1, prox_byte ## Não encontrou um espaço / if (t2 != SPACE)
		##Encontrou um SPACE
		##Pula uma espaço de byte
		move $t4, $t0
	desloca_1byte_esquerda:
		lbu $t3, 1($t4)
		sb $t3, 0($t4)
		addi $t4, $t4, 1
		bne $t3, $zero, desloca_1byte_esquerda
	prox_byte:
		addi $t0, $t0, 1
		j loop
	fim: nop 
	
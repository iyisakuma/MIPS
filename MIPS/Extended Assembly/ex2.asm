#Duas situações para atacar o problema:
# 1. Sempre início da String
# 2. Após um espaço


.data 
	String: .asciiz "meu professor eh muito bom"
	
.text
	main:
		lui $t0, 0x1001 ##ponteiro
		addiu $t1, $zero, 32 ##SPACE ASCII
		
		##Primeiro caracter
	 	lbu $t2, 0($t0)
	 	beq $t2, $zero, fim ## se for lido caracter nulo, pula para o fim
		j capitalize ##Capitaliza o primeiro caracter 
	 	
	 	##A partir do segundo caracter		
	loop:
		lbu $t2, 0($t0)
		beq $t2, $zero, fim
		addi $t0, $t0, 1
		bne $t2, $t1, loop ## if(t2 != SPACE)
		
		lbu $t2, 0($t0)  
		##Encontrado o proximo caracter
	capitalize:
		addiu $t2, $t2, -32
	 	sb $t2, 0($t0)
	 	j loop
	fim: nop 
	

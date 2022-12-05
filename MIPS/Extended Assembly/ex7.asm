.data 
	ENUNCIADO: .asciiz "Insira 3 valores para o calculo da media"
	PULA_LINHA: .byte 10
.text
	la $a0, ENUNCIADO
	li $v0, 4
	syscall
	la $a0, PULA_LINHA
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	li $v0, 5
	syscall
	move $a1, $v0
	li $v0, 5
	syscall
	move $a3, $v0
	jal CALCULA_MEDIA
	li $v0, 1
	move $a0, $v0
	syscall
	
	
	
	
CALCULA_MEDIA:
	add $v0, $a1, $a0
	add $v0, $v0, $a2
	div $v0, $v0, 3
	jr $ra
	
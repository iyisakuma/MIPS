#Escreva um programa que repetidamente pergunte ao usuário pelo número de
#quilômetros viajados e litros de gasolina consumidos e depois imprima o número de
#quilômetros por litro. Para sair do programa, o usuário deve digitar 0 como número
#de quilômetros.
#Armazene todos os números de quilômetros por litro na memória, iniciando pelo
#endereço 0x10010000.
.data
	RESPOSTAS: .space 32
	BEM_VINDO: .asciiz "Bem-vindo ao programa que calcula km por litros da sua viagem. "
	KM_PERCORRIDO: .asciiz "Quantos km(s) foram percorridos? Insira 0 para sair "
	LITROS_CONSUMIDOS: .asciiz "Quantos litros foram utilizados na viagem? "

.text
INICIO:
	#Ponteiro para inicio da memoria
	lui $t0, 0x1001
	li $v0, 4 
	la $a0, BEM_VINDO
	syscall
MENU:
	li $v0, 4 #Imprime uma string ($a0)
	la $a0, KM_PERCORRIDO
	syscall
	li $v0, 5 #Ler inteiro
	syscall
	move $t1, $v0
	beqz $t1, FIM
	li $v0, 4
	la $a0, LITROS_CONSUMIDOS
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	div $t3, $t1, $t2
	sw $t3, 0($t0)
	addi $t0, $t0, 4
	j MENU
FIM:
	li $v0, 10
	syscall
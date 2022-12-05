.data
	TAMANHO_TOTAL: .word 10
	TAMANHO_UTILIZADO: .word 0
	##Vetor que guarda os tamanhos de limites de nome, nro e obs, respectivamente
	LIMITES: .word 20, 11, 40
	TITULO: .asciiz "\nBem-vindo a sua agenda de contato!"
	MENU_OP: .asciiz "\nQue operação será realizada?\n\t1.Adicionar contato\n\t2.Consultar um contato\n\t3.Modificar um contato\n\t4.Excluir um contato\n\t5.Sair\nInsira a sua opcao: "
	MENU_UPDATE: .asciiz "\nO que você deseja mudar?\n\t1.Nome\n\t2.Número\n\t3.Obs\n\t4.Sair"
	INSIRA_NOME: .asciiz "\nInsira o nome(máx 20 caracteres): "
	INSIRA_NRO: .asciiz "\nInsira o número de telefone(max 11 caracteres): "
	INSIRA_OBS: .asciiz "\nInsira uma observação(max 40 caracteres): "
	NOME: .asciiz "\nNome: "
	NRO: .asciiz "\nNro: "
	OBS: .asciiz "\nObs: "
	REGISTRO: .asciiz "\nRegistro: "
	SUCCESS_UPDATE: .asciiz "\nModificado com sucesso!"
	QUAL_REGISTRO: .asciiz "\nQual registro sera modificado? "
	INSIRA: .asciiz "\n-> "
	##A cada 71 bytes é um contato
	##os primeiros 20 bytes dos 71 é reservado para o nome
	##De 20 a 31 bytes do 71 é reservado para o numero de telefone
	##De 32 a 71 é reservado para observação
	CONTATOS: .space 710
	NOME_BUSCADO: .space 20
	ERRO_TAMANHO_INSUFICIENTE: .asciiz "\nEspaço insuficiente, para inserir um novo dado será necessário excluir um."
	ERRO_OP_INVALIDA: .asciiz "\nOperação inválida."
	ERRO_SEM_CONTATO: .asciiz "\nAgenda vazia."
	ERRO_UPDATE: .asciiz "\nContato não encontrado" 
	ERRO_INDICE_MSG: .asciiz "\nIndice nao encontrado"
.text
	MAIN:
		li $v0, 4
		la $a0, TITULO
		syscall
	MENU:
		##Imprime o menu na tela
		li $v0, 4
		la $a0, MENU_OP
		syscall
		##Ler a operação da tela
		li $v0, 5
		syscall
		move $t1, $v0
		beq $t1, 5, FIM ##Se o usuário inserir 5 - Sair
		beq $t1, 1, ADICIONAR ##Se o usuário inserir 1 - Adicionar um contato
		beq $t1, 2, MOSTRAR_CONTATO ##Se o usuário inserir 2 - Mostrar contato
		beq $t1, 3, UPDATE_CONTATO
		beq $t1, 4, DELETE_CONTATO
		j ERRO_OPERACAO_INVALIDA
	ERRO_TAMANHO_EXCEDIDO:	
		##Imprime Erro tamanho excedido
		li $v0, 4
		la $a0, ERRO_TAMANHO_INSUFICIENTE
		syscall
		li $v0, 32##sleep
		li $a0, 1000##1s
		syscall
		j MENU
	ERRO_OPERACAO_INVALIDA:
		##Imprime Erro operação inválida
		li $v0, 4
		la $a0, ERRO_OP_INVALIDA
		syscall
		li $v0, 32##sleep
		li $a0, 1000##1s
		syscall
		j MENU
	ERRO_AGENDA_VAZIA:
		##Imprime Erro sem contato
		li $v0, 4
		la $a0, ERRO_SEM_CONTATO
		syscall
		li $v0, 32##sleep
		li $a0, 1000##1s
		syscall
		j MENU
	ERRO_CONTATO_NAO_ENCONTRADO:
		##Imprime Erro sem contato
		li $v0, 4
		la $a0, ERRO_UPDATE
		syscall
		li $v0, 32##sleep
		li $a0, 1000##1s
		syscall
		j MENU
	ERRO_INDICE :
	##Imprime Erro sem contato
		li $v0, 4
		la $a0, ERRO_INDICE_MSG
		syscall
		li $v0, 32##sleep
		li $a0, 1000##1s
		syscall
		j MENU
	ADICIONAR:	
		lw $t1, TAMANHO_TOTAL
		lw $t2, TAMANHO_UTILIZADO
		beq $t1, $t2, ERRO_TAMANHO_EXCEDIDO
		move $a0, $t2
		jal GRAVA_CONTATO
		j MENU
	GRAVA_CONTATO: ## recebe como parametro nro de contatos ja registrados
		##Calcula quantos bytes deve ser pulado para encontrar um endereço 
		## de contatos que pode ser escrito
		mul $t3, $a0, 71
		move $t2, $a0
		la $t1, CONTATOS
		##Avança n contatos existente
		add $t1, $t1, $t3
		##Imprime na tela para inserir o nome
		li $v0, 4
		la $a0, INSIRA_NOME
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t1
		li $a1, 20
		syscall
		addi $t1, $t1, 20 ##Avança para o campo de numero
		##Imprime na tela para inserir o numero
		li $v0, 4
		la $a0, INSIRA_NRO
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t1
		li $a1, 11
		syscall
		addi $t1, $t1, 11 ##Avança para o campo de obervacoes
		##Imprime na tela para inserir o contato
		li $v0, 4
		la $a0, INSIRA_OBS
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t1
		li $a1, 40
		syscall
		##Adiciona um no contador de contatos existente
		addi $t2, $t2, 1
		sw $t2, TAMANHO_UTILIZADO
		jr $ra
	MOSTRAR_CONTATO:
		lw $t2, TAMANHO_UTILIZADO
		beqz $t2, ERRO_AGENDA_VAZIA
		move $a0, $t2
		jal PERCORRE_CONTATO_E_MOSTRA
		j MENU
	PERCORRE_CONTATO_E_MOSTRA: ##recebe como paramentro o tamanho do contatos existentes
		move $t3, $a0
		la $t1, CONTATOS
		li $t2, 0 ##contador_contatos
	LOOP_PERCORRE_CONTATO_E_MOSTRA:
		beq $t2, $t3, FIM_PERCORRE_CONTATO_E_MOSTRA
		li $v0, 4
		la $a0, REGISTRO
		syscall
		li $v0, 1
		move $a0, $t2
		syscall
		li $v0, 4
		la $a0, NOME
		syscall
		li $v0, 4
		move $a0, $t1
		syscall
		addi $t1, $t1, 20
		
		li $v0, 4
		la $a0, NRO
		syscall
		li $v0, 4
		move $a0, $t1
		syscall
		addi $t1, $t1, 11
		li $v0, 4
		la $a0, OBS
		syscall
		li $v0, 4
		move $a0, $t1
		syscall
		addi $t2, $t2, 1
		##prox contato
		addi $t1, $t1, 40
		li $v0, 32##sleep
		li $a0, 500##0.5s
		syscall
		j LOOP_PERCORRE_CONTATO_E_MOSTRA
	FIM_PERCORRE_CONTATO_E_MOSTRA:
		jr $ra	
	UPDATE_CONTATO:
		lw $t2, TAMANHO_UTILIZADO
		beqz $t2, ERRO_AGENDA_VAZIA
		move $t1, $a0
		jal BUSCA_ENDERECO_CONTATO##Subrotina que retorna o indice do contato
		move $t1, $v0 ##Move o indice do contato a ser modificado para o registrador t1
		li $v0, 4
		la $a0, MENU_UPDATE
		syscall
		li $v0, 4
		la $a0, INSIRA
		syscall
		##Ler opção da tela
		li $v0, 5
		syscall
		move $t3, $v0
		beq $t3, 1, UPDATE_NOME
		beq $t3, 2, UPDATE_NUMERO
		beq $t3 3, UPDATE_OBS
		beq $t3, 4, MENU
		j ERRO_OPERACAO_INVALIDA
	BUSCA_ENDERECO_CONTATO: ##Retorna no v0 o indice do contato.
		lw $t2, TAMANHO_UTILIZADO
		li $v0, 4
		la $a0, QUAL_REGISTRO
		syscall
		li $v0, 4
		la $a0, INSIRA
		syscall
		li $v0, 5 ##Ler o numero de registro
		syscall
		move $t0, $v0
		slt $t1, $t0, $t2
		beqz $t1, ERRO_INDICE 
		jr $ra
	UPDATE_NOME:
		la $t0, CONTATOS
		mul $t1, $t1, 71
		add $t0, $t0, $t1
		li $v0, 4
		la $a0, INSIRA_NOME
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t0
		li $a1, 20
		syscall
		li $v0, 4
		la $a0, SUCCESS_UPDATE
		syscall
		li $v0, 32##sleep
		li $a0, 1000##3s
		syscall
		j MENU
	UPDATE_NUMERO:
		la $t0, CONTATOS
		mul $t1, $t1, 71
		add $t0, $t0, $t1
		addi $t0, $t0, 20 ##Avança para o campo dos numeros
		li $v0, 4
		la $a0, INSIRA_NRO
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t0
		li $a1, 11
		syscall
		li $v0, 4
		la $a0, SUCCESS_UPDATE
		syscall
		li $v0, 32##sleep
		li $a0, 1000##3s
		syscall
		j MENU
	UPDATE_OBS:
		la $t0, CONTATOS
		mul $t1, $t1, 71
		add $t0, $t0, $t1
		addi $t0, $t0, 31 ##Avança para o campo da obs
		li $v0, 4
		la $a0, INSIRA_OBS
		syscall
		##Ler o nome da tela
		li $v0, 8
		move $a0, $t0
		li $a1, 40
		syscall
		li $v0, 4
		la $a0, SUCCESS_UPDATE
		syscall
		li $v0, 32##sleep
		li $a0, 1000##3s
		syscall
		j MENU
	DELETE_CONTATO:
		lw $t2, TAMANHO_UTILIZADO
		beqz $t2, ERRO_AGENDA_VAZIA
		la $t3, CONTATOS
		jal BUSCA_ENDERECO_CONTATO##Subrotina que retorna o indice do contato
		move $t0, $v0 ##Indice
		mul $t1, $t0, 71
		add $t3, $t3, $t1 ##Endereço do contato para apagar
		addi $t0, $t0, 1
		sub $t0, $t2, $t0 ##Tamanho do contato - iundice (p saber quantos contatos precisa ser deslocado)
		mul $t4, $t0, 71 ##qnt de bytes
		bne  $t2, $t0, DELETE_NAO_ULTIMO 
	DELETE_ULTIMO_REGISTRO:
		addi $t2, $t2, -1
		sw $t2, TAMANHO_UTILIZADO
		j MENU
	DELETE_NAO_ULTIMO:
		addi $t2, $t2, -1
		sw $t2, TAMANHO_UTILIZADO
		addi $t2, $t3, 71	
	LOOP2:	beqz $t4, MENU ##Se o registro a ser apagado nao for o ultimo
		lbu $t0, ($t2)
		sb $t0, 0($t3)
		addi $t3, $t3, 1
		addi $t2, $t2, 1
		addi $t4, $t4, -1
		j LOOP2
		 
	FIM:
		li $v0, 10
		syscall

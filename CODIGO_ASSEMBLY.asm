
## Parte usada para declarar constantes para serem inicializadas ##
.data 
	msg1: .asciiz "  Valor insuficiente para compra "
	msg2: .asciiz "  Valor Suficiente "
	msg3: .asciiz "  Não há troco "
	msg4: .asciiz "  Há troco "
	msg5: .asciiz "  Valor pago(em centavos): R$ "
	msg6: .asciiz "  Valor do produto selecionado(em centavos): R$ "
	msg7: .asciiz "  Troco(em centavos): R$ "
	enter: .asciiz "\n"
	 
	ced20: .asciiz "  Quantidade de notas de 20: "
	ced10: .asciiz "  Quantidade de notas de 10: "
	ced5: .asciiz "  Quantidade de notas de 5: "
	ced2: .asciiz "  Quantidade de notas de 2: "
	mo1: .asciiz "  Quantidade de moedas de 1: "
	mo50: .asciiz "  Quantidade de moedas de 0,50: "
	mo25: .asciiz "  Quantidade de moedas de 0,25: "
	mo10: .asciiz "  Quantidade de moedas de 0,10: "
	mo5: .asciiz "  Quantidade de moedas de 0,05: "
	
.text #inicio dos textos
.globl main #para dizer que aa main � global

main: 
 # Total($t2) =  ($s0 * 20) + ($s1 * 10) + ($s2 * 5) + ($s3 * 2) + ($s4 * 1) + ($s5 * 0.5) + ($s6 * 0.25) + ($s7 * 0.10);
 # Para um melhor calculo, foi passado todos os valores para centavos.
 # R$20,00 = 2000 ... Então:
 # Total($t2) =  ($s0 * 2000) + ($s1 * 1000) + ($s2 * 500) + ($s3 * 200) + ($s4 * 100) + ($s5 * 50) + ($s6 * 25) + ($s7 * 10);

	#Armazenamento e multiplicação dos valores das cédulas e moedas em centavos

	li $s0, 1 #Quantidade de cédulas de R$20,00 inseridas.
	mul $s0, $s0, 2000 #multiplicando a quantidade de celulas pelo valor da nota em centavos
	
	li $s1, 1 #Quantidade de cédulas de R$10,00 inseridas.
	mul $s1, $s1, 1000 #multiplicando a quantidade de celulas pelo valor da nota em centavos
	
	li $s2, 1 #Quantidade de cédulas de R$5,00 inseridas.
	mul $s2, $s2, 500 #multiplicando a quantidade de celulas pelo valor da nota em centavos
	
	li $s3, 1 #Quantidade de cédulas de R$2,00 inseridas.
	mul $s3, $s3, 200 #multiplicando a quantidade de celulas pelo valor da nota em centavos
	
	li $s4, 1 #Quantidade de cédulas de R$1,00 inseridas.
	mul $s4, $s4, 100 #multiplicando a quantidade de moedas pelo valor da moeda em centavos
	
	li $s5, 1 #Quantidade de moedas de R$0,50 inseridas.
	mul $s5, $s5, 50 #multiplicando a quantidade de moedas pelo valor da moeda em centavos
	
	li $s6, 1 #Quantidade de moedas de R$0,25 inseridas.
	mul $s6, $s6, 25 #multiplicando a quantidade de moedas pelo valor da moeda em centavos
	
	li $s7, 1 #Quantidade de moedas de R$0,10 inseridas.
	mul $s7, $s7, 10 #multiplicando a quantidade de moedas pelo valor da moeda em centavos
	
	li, $k0, 5 # moeda de 5 centavos
	
	#Fazendo a soma de todos os valores inseridos
	add $t2, $s0, $s1 # significa: registradorTotal = registrador0 + registrador1
	add $t2, $t2, $s2 # significa: registradorTotal = registradorTotal + registrador2
	add $t2, $t2, $s3 # significa: registradorTotal = registradorTotal + registrador3
	add $t2, $t2, $s4 # significa: registradorTotal = registradorTotal + registrador4
	add $t2, $t2, $s5 # significa: registradorTotal = registradorTotal + registrador5
	add $t2, $t2, $s6 # significa: registradorTotal = registradorTotal + registrador6
	add $t2, $t2, $s7 # significa: registradorTotal = registradorTotal + registrador7
	
	#pegando o valor do produto em centavos
	li $t9, 3085 #R$30,85 - Valor do produto x100

	
## Começando o PRIMEIRO if para validação do valor para compra ##

	#if (total > produto)
	bgt $t2, $t9, pt1 # If total > produto vai para a pt1 do if 
	li $v0, 4
	la $a0, msg1 	# imprimindo a mensagem 1 que foi inicializada no .data
	li $t0, 1 	# t0 retorna a 1 quando o valor NÃO for suficienta para compra
	syscall 
	b pt3

pt1: 	#Primeira parte do if 1 
	li $v0, 4
	la $a0, msg2	# imprimindo a mensagem 2 que foi inicializada no .data
	li $t0, 0 	# t0 retorna a 0 quando o valor for suficienta para compra
	syscall	
		
		
## Começando o SEGUNDO if para validar se terá troco ou não ##

	li $v0, 4
	la $a0, enter 	# Pular linha entre as respostas.
	syscall
	
	#if (produto = total)
	beq $t2, $t9, pt2 # If total = produto vai para a pt3 do if 
	li $v0, 4
	la $a0, msg4	# imprimindo a mensagem 4 que foi inicializada no .data ("Há troco")
	syscall 
	b pt3

pt2: 	#Primeira parte do if 2
	li $v0, 4
	la $a0, msg3  	# imprimindo a mensagem 3 que foi inicializada no .data ("Não há troco")
	syscall	
	
	
pt3:	# Terceira parte do código

	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 	
	syscall
	

## Inicio do printf para imprimir o valor pago (em centavos) ##

	li $v0, 4	# inicio do printf
	la $a0, msg5 	# Imprimindo o valor pago
	syscall
	li $v0, 1
	move $a0, $t2	# Imprimindo o valor pago
	syscall		# Fim do printf
	
	
## Inicio do printf para imprimir o valor do produto (em centavos) ##
	
	li $v0, 4
	la $a0, enter 	# Pular linha entre as respostas.
	syscall
	
	li $v0, 4	# inicio do printf
	la $a0, msg6 	# Imprimindo o valor do produto (em centavos)
	syscall
	li $v0, 1
	move $a0, $t9 	# Imprimindo valor do produto
	syscall		# Fim do printf
	
	
## Inicio do printf para imprimir o troco (em centavos) ##
		# $t3 = Troco
	
	sub $t3, $t2, $t9 # Troco = total - produto
	
	li $v0, 4
	la $a0, enter 	# Pular linha entre as respostas.
	syscall
	
	li $v0, 4	# inicio do printf
	la $a0, msg7 	# Imprimindo o valor do troco (em centavos)
	syscall
	li $v0, 1
	move $a0, $t3	# Imprimindo o troco
	syscall		# Fim do printf
	

 # while para troco de nota 20 (2000 centavos)#
 # O Loop faz a condição e caso ela seja verdadeira, ele adiciona 1 ao registrador $a1 e depois subtrai o troco pela nota (no caso 2000)
 # Caso seja falso, ele vai para o proximo loop.
 # O MESMO SE REPETE PARA CADA BLOCO DE LOOP #
 
 #t3 3000
 
 	li $a1, 2000
 	li $a2, 1000
 	li $a3, 500
 	li $t4, 200
 	li $t5, 100
 	li $t6, 50
 	li $t7, 25
 	li $t8, 10
 	
 	li $s0, 0
 	li $s1, 0
 	li $s2, 0
 	li $s3, 0
 	li $s4, 0
 	li $s5, 0
 	li $s6, 0
 	li $s7, 0
 	li $t9, 0
 
 
	loop:
		blt $t3, $a1, loop2	# (Se Troco menor que 2000 então vá para o proximo loop e faça as condições dele)
	
		addi $s0, $s0, 1	# Qtd_cedula = Qtd_cedula + 1
		subi $t3, $t3, 2000	# Troco = troco - 2000
	
		j loop			# Retorna para a primeira linha do loop
		
	# while para troco de nota 10 (1000 centavos)#
	loop2:
		blt $t3, $a2, loop3	# (Se Troco menor que 1000 então vá para o proximo loop e faça as condições dele)
	
		addi $s1, $s1, 1
		subi $t3, $t3, 1000
	
		j loop			
		
		
	# while para troco de nota 5 (500 centavos)#
	loop3:
		blt $t3, $a3, loop4	# (Se Troco menor que 500 então vá para o proximo loop e faça as condições dele)
	
		addi $s2, $s2, 1
		subi $t3, $t3, 500
	
		j loop
	
	
	# while para troco de nota 2 (200 centavos)#
	loop4:
		blt $t3, $t4, loop5	# (Se Troco menor que 200 então vá para o proximo loop e faça as condições dele)
	
		addi $s3, $s3, 1
		subi $t3, $t3, 200
	
		j loop
		
		
	# while para troco de moeda 1 (100 centavos)#
	loop5:
		blt $t3, $t5, loop6	# (Se Troco menor que 100 então vá para o proximo loop e faça as condições dele)
	
		addi $s4, $s4, 1
		subi $t3, $t3, 100
	
		j loop
	
	
	# while para troco de moeda 0,50 (50 centavos)#
	loop6:
		blt $t3, $t6, loop7	# (Se Troco menor que 50 então vá para o proximo loop e faça as condições dele)
	
		addi $s5, $s5, 1
		subi $t3, $t3, 50
	
		j loop	
		
		
	# while para troco de moeda 0,25 (25 centavos)#
	loop7:
		blt $t3, $t7, loop8	# (Se Troco menor que 25 então vá para o proximo loop e faça as condições dele)
	
		addi $s6, $s6, 1
		subi $t3, $t3, 25
	
		j loop
	
	
	# while para troco de moeda 0,10 (10 centavos)#
	loop8:
		blt $t3, $t8, loop9	# (Se Troco menor que 10 então vá para o proximo loop e faça as condições dele)
	
		addi $s7, $s7, 1
		subi $t3, $t3, 10
	
		j loop
		
	# while para troco de moeda 0,05 (5 centavos)#
	loop9:
		blt $t3, $k0, fora	# (Se Troco menor que 5 então vá para o proximo loop e faça as condições dele) 
	
		addi $t9, $t9, 1
		subi $t3, $t3, 10
	
		j loop
	
	#Saindo de todos os loops
	fora:

# Aqui irei imprimir o texto que está armazenado em .data + o resultado de cada loop. Imprimirei a quantidade de cada nota e moeda que terá que ser dada de troco.
	
	# Pular duas linhas entre as respostas.
	li $v0, 4
	la $a0, enter	
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall
	
	# imprimindo quantidade de cedulas de 20 reais#
	li $v0, 4	# inicio do printf
	la $a0, ced20 	 	
	syscall
	li $v0, 1
	move $a0, $s0
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 10 reais#
	li $v0, 4	# inicio do printf
	la $a0, ced10  	
	syscall
	li $v0, 1
	move $a0, $s1
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 5 reais#
	li $v0, 4	# inicio do printf
	la $a0, ced5  	
	syscall
	li $v0, 1
	move $a0, $s2
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 2 reais#
	li $v0, 4	# inicio do printf
	la $a0, ced2 	
	syscall
	li $v0, 1
	move $a0, $s3
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de moedas de 1 real#
	li $v0, 4	# inicio do printf
	la $a0, mo1 		
	syscall
	li $v0, 1
	move $a0, $s4
	syscall		# Fim do printf


	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 50 centavos#
	li $v0, 4	# inicio do printf
	la $a0, mo50	
	syscall
	li $v0, 1
	move $a0, $s5
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 25 centavos#
	li $v0, 4	# inicio do printf
	la $a0, mo25 	
	syscall
	li $v0, 1
	move $a0, $s6
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 10 centavos#
	li $v0, 4	# inicio do printf
	la $a0, mo10 	
	syscall
	li $v0, 1
	move $a0, $s7
	syscall		# Fim do printf
	
	
	# Pular linha entre as respostas.
	li $v0, 4
	la $a0, enter 
	syscall
	
	# imprimindo quantidade de cedulas de 5 centavos#
	li $v0, 4	# inicio do printf
	la $a0, mo5 	
	syscall
	li $v0, 1
	move $a0, $t9
	syscall		# Fim do printf
	
	li $v0, 10 	# inicio do return 0
	syscall 	# Final do return 0
	
	#Fim Do codigo
	

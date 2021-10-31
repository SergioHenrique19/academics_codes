.data
msg_in_n: .asciiz "Digite o tamanho (n) dos vetores: "
msg_in_x: .asciiz "Digite um valor para X: "
msg_in_y: .asciiz "Digite um valor para Y: "
msg_result: .asciiz "Resultado: "

.text
.globl main
main:
  la $a0, msg_in_n
  li $v0, 4
  syscall

  li $v0, 5
  syscall
  move $s0, $v0

  j func

func:
  bge $t0, $s0, resultado

  la $a0, msg_in_x
  li $v0, 4
  syscall

  li $v0, 6
  syscall
  mov.s $f1, $f0

  la $a0, msg_in_y
  li $v0, 4
  syscall

  li $v0, 6
  syscall
  mov.s $f2, $f0

  mul.s $f0, $f1, $f2
  add.s $f3, $f3, $f0

  addi $t0, $t0, 1
  
  j func

resultado:
	la $a0, msg_result
	li $v0, 4
	syscall
	
	li $v0, 2
	mov.s $f12, $f3
  syscall

  j exit

exit:
  li $v0, 10
  syscall

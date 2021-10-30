.data
prompt: .asciiz "Digite o numero a ser elevado:"
prompt2: .asciiz "Digite a potencia:"
result: .asciiz "resultado:"
nl: "\n"

.text
.globl main
main:
  la $a0, prompt
  li $v0, 4
  syscall
  li $v0, 5
  syscall
  move $t0, $v0
  la $a0, prompt2
  li $v0, 4
  syscall
  li $v0, 5
  syscall
  move $t1, $v0
  li $t4, 1
  move $s1, $t1
  li $s3, 0

loop:
  beq $s3, $s1, exit
  mul $t2, $t4, $t0
  j somar
somar:
  addi $s3, $s3, 1
  move $t4,$t2
  j loop

exit:
  la $a0, result
  li $v0, 4
  syscall
  li $v0, 1
  move $a0, $t2
  syscall
  li $v0, 4
  la $a0, nl
  li $v0, 10
  syscall

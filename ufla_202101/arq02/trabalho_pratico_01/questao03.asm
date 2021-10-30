.data
prompt: .asciiz "Digite o hipotenusa: \n"
prompt2: .asciiz "Digite o cateto1: \n"
prompt3: .asciiz "Digite o cateto2: \n"
prompt4: .asciiz "É TRIANGULO RETANGULO \n"
prompt5: .asciiz "NÃO É TRIANGULO RETANGULO \n"
nl: .asciiz "\n"

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
  move $t1,$v0
  la $a0, prompt3
  li $v0, 4
  syscall
  li $v0, 5
  syscall
  move $t2, $v0

  move $s0, $t0 
  move $s1, $t1
  move $s2, $t2

  slt $t3, $s0 $s1
  beq $t3, $zero, skip
  move $s0, $t1
  move $s1, $t0

skip:
  slt $t3, $s0 $s2
  beq $t3, $zero, skip1
  move $s0, $t2
  move $s2, $t0
  move $s1, $t1

skip1:
  mul $s0, $s0, $s0
  mul $s1, $s1, $s1
  mul $s2, $s2, $s2

  li $v0, 1
  move $a0, $s0
  syscall
  li $v0, 4
  la $a0, nl
  syscall
  li $v0, 1
  move $a0, $s1
  syscall
  li $v0, 4
  la $a0, nl
  syscall
  li $v0, 1
  move $a0, $s2
  syscall
  li $v0, 4
  la $a0, nl
  syscall

  add $s3, $s1, $s2
  beq $s0, $s3, ehRetangulo
  li $v0, 4
  la $a0, prompt5
  syscall
  j skip2

ehRetangulo:
  li $v0, 4
  la $a0, prompt4
  syscall

skip2:

.data
prompt: .asciiz "Digite n: \n"
prompt2: .asciiz "Digite i: \n"
prompt3: .asciiz "Digite j: \n"
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
  move $t1, $v0
  la $a0, prompt3
  li $v0, 4
  syscall
  li $v0, 5
  syscall
  move $t2, $v0
  li $s0, 0
  move $s1, $t0
  li $s3, 0

loop:
  beq $s3, $s1, exit
  rem $s2, $s0, $t1
  beq $s2, $zero, print
  rem $s2, $s0, $t2
  beq $s2, $zero, print
  j endprint

print:
  addi $s3, $s3, 1
  li $v0, 1
  move $a0, $s0
  syscall
  li $v0, 4
  la $a0, nl
  syscall

endprint:
  addi $s0, $s0, 1
  j loop

exit:
  li $v0, 10
  syscall

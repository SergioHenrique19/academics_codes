.data
msg_in_n: .asciiz "Digite o valor de n: "
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
  ble $s0, $zero, resultado
  addi $t0, $t0, 1
  
  mtc1 $t0, $f1
  mtc1 $s0, $f2
  
  div.s $f3, $f1, $f2
  add.s $f4, $f4, $f3
  
  subi $s0, $s0, 1
  
  j func

resultado:
  la $a0, msg_result
  li $v0, 4
  syscall

  li $v0, 2
  mov.s $f12, $f4
  syscall

  j exit

exit:
  li $v0, 10
  syscall

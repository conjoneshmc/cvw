// Connor Jones
// conjones@g.hmc.edu
// 2026-02-14

.extern return_lui_test
.extern fail

.section .text.init
.globl lui_test
.type lui_test, @function

lui_test:
test0:
  lui t0, 0xFC802
  addi t1, zero, 0xF
  slli t1, t1, 8
  addi t1, t1, 0xC8
  slli t1, t1, 8
  addi t1, t1, 0x02
  slli t1, t1, 12
  beq t0, t1, done
  li gp, 60000
  j fail
done:
  j return_lui_test

// Connor Jones
// conjones@g.hmc.edu
// 2026-02-14

.extern return_bne_test
.extern fail

.section .text.init
.globl bne_test
.type bne_test, @function

bne_test:
test0:
  li t0, 0x018055F0
  li t1, 0x017055F0
  bne t0, t1, test1 # should be taken
  li gp, 50000
  j fail
test1:
  li t0, 0x2018CD38
  li t1, 0x2018CD38
  bne t0, t1, test1_fail # shouldn't be taken
  j done
test1_fail:
  li gp, 50001
  j fail
done:
  j return_bne_test

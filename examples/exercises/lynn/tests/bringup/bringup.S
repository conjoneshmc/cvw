// C Runtime entry point
// James Kaden Cassidy
// kacassidy@hmc.edu
// 1/21/2026

.extern add_test
.extern or_test
.extern and_test
.extern sub_test
.extern sll_test
.extern srl_test
.extern sra_test
.extern sltu_test
.extern lui_test

.section .text.init
.globl main
.globl return_add_test
.globl return_or_test
.globl return_and_test
.globl return_sub_test
.globl return_sll_test
.globl return_srl_test
.globl return_sra_test
.globl return_sltu_test
.globl return_lui_test
.type  main, @function

main:
    li t0, 2

return_lui_test:
    j pass

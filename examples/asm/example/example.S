.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
    li a0, 0x0000000050000000
    li a1, 0xFFFFFFFFA0000000
    mul a2, a0, a1

self_loop:
    j self_loop

.globl fir
fir:
  # a0 = int x[]
  # a1 = int c[]
  # a2 = int y[]
  # a3 = int n
  # a4 = int m

  # Constants that will make for loops convenient
  addi a4, a4, -1  # a4 = m - 1
  sub a3, a3, a4   # a3 = n - (m - 1) = n - m + 1

  # Filter implementation
  li t0, 0                    # j = 0
  for_j:
    bgt t0, a3, end_for_j     # check that j <= n - m + 1, otherwise terminate loop

    li t2, 0                  # res = 0
    li t1, 0                  # i = 0
    for_i:
      bgt t1, a4, end_for_i   # check that i <= m - 1, otherwise terminate loop

      slli t3, t1, 2          # t3 = i * 4
      add t3, t3, a1          # t3 = &c + (i * 4)
      lw t3, 0(t3)            # t3 = c[i]

      sub t4, t0, t1          # t4 = j - i
      add t4, t4, a4          # t4 = j - i + m - 1
      slli t4, t4, 2          # t4 = 4*(j - i + m - 1)
      add t4, t4, a0          # t4 = &x + 4*(j - i + m - 1)
      lw t4, 0(t4)            # t4 = x[j - i + m - 1]

      mul t3, t3, t4          # t3 = c[i] * x[j - i + m - 1]
      slli t3, t3, 1          # convert t3 from Q2.62 to Q1.31
      srli t3, t3, 32         #
      add t2, t2, t3          # result += t3

      addi t1, t1, 1          # i++
      j for_i
    end_for_i:

    slli t3, t0, 2          # t3 = j * 4
    add t3, t3, a2          # t3 = &y + (j * 4)
    sw t2, 0(t3)            # y[j] = c[i] * x[j - i + m - 1]

    addi t0, t0, 1          # j++
    j for_j
  end_for_j:

  ret

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
  slli a4, a4, 2   # need to multiply these constants by 4 due to the way
  slli a3, a3, 2   # for loops are done, see below

  # For all the for loops, instead of incrementing the index by 1, we increment the
  # index by 4. This makes it easier to calculate array stores and loads since we
  # don't need to multiply the index by 4 each time. We will also change the bounds
  # of the for loop to accomodate.
  li t0, 0                    # j = 0

  bgt t0, a3, end_for_j       # check that j <= n - m + 1, otherwise terminate loop
  for_j:
    li t2, 0                  # res = 0
    li t1, 0                  # i = 0

    bgt t1, a4, end_for_i     # check that i <= m - 1, otherwise terminate loop
    for_i:
      add t3, t1, a1          # t3 = &c + i
      lw t3, 0(t3)            # t3 = c[i]

      sub t4, t0, t1          # t4 = j - i
      add t4, t4, a4          # t4 = j - i + m - 1
      add t4, t4, a0          # t4 = &x + j - i + m - 1
      lw t4, 0(t4)            # t4 = x[j - i + m - 1]

      mul t3, t3, t4          # t3 = c[i] * x[j - i + m - 1]
      slli t3, t3, 1          # convert t3 from Q2.62 to Q1.31
      srli t3, t3, 32         #
      add t2, t2, t3          # result += t3

      addi t1, t1, 4          # i += 4, see above
      ble t1, a4, for_i       # check condition at end of for loop
    end_for_i:

    add t3, t0, a2          # t3 = &y + j
    sw t2, 0(t3)            # y[j] = c[i] * x[j - i + m - 1]

    addi t0, t0, 4          # j += 4, see above
    ble t0, a3, for_j       # check condition at end of for loop
  end_for_j:

  ret

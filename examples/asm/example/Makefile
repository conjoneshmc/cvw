example.objdump: example
	riscv64-unknown-elf-objdump -D example > example.objdump

example: example.S Makefile
	riscv64-unknown-elf-gcc -o example -march=rv64gc -mabi=lp64 -mcmodel=medany \
	    -nostartfiles -T../../link/link.ld example.S

clean:
	rm -f example example.objdump

# hello.asm - Hello World en MIPS (MARS)

        .data
msg:    .asciiz "Hello World\n"

        .text
        .globl main
main:
        li   $v0, 4          # syscall 4 = print_string
        la   $a0, msg        # $a0 = direccion del string
        syscall              # imprime "Hello World"

        li   $v0, 10         # syscall 10 = exit
        syscall

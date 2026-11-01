# suma.asm - Suma de 1 a N con un ciclo (codigo propio)
# Imprime: "Suma 1..5 = 15"

        .data
txt:    .asciiz "Suma 1..5 = "
nl:     .asciiz "\n"

        .text
        .globl main
main:
        li   $t0, 5          # $t0 = N
        li   $t1, 0          # $t1 = acumulador (suma)
        li   $t2, 1          # $t2 = i

ciclo:
        bgt  $t2, $t0, fin   # si i > N, salir
        add  $t1, $t1, $t2   # suma = suma + i
        addi $t2, $t2, 1     # i = i + 1
        j    ciclo

fin:
        li   $v0, 4          # print_string
        la   $a0, txt
        syscall

        li   $v0, 1          # print_int
        move $a0, $t1        # $a0 = suma
        syscall

        li   $v0, 4          # print_string
        la   $a0, nl
        syscall

        li   $v0, 10         # exit
        syscall

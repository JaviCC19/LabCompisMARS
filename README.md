# Laboratorio MARS — Compiladores

Programas en MIPS para ejecutar y depurar en MARS 4.5.1.

| Archivo | Qué hace |
|---|---|
| `hello.asm` | Hello World del tutorial |
| `suma.asm` | Código propio: suma de 1 a 5 con un ciclo, imprime `Suma 1..5 = 15` |

## Cómo correrlo

1. Instalar Java (JDK o JRE 8+).
2. Descargar `Mars4_5.jar` de https://github.com/dpetersanderson/MARS/releases/tag/v.4.5.1
3. Abrir: `java -jar Mars4_5.jar`
4. `File > Open` → elegir el `.asm`.
5. `Run > Assemble` (F3).
6. Ejecutar paso a paso con `Run > Step` (F7) y ver el panel **Registers** a la derecha. El registro que acaba de cambiar se resalta.

Desde terminal (sin GUI):

```
java -jar Mars4_5.jar nc $v0 $a0 hello.asm
java -jar Mars4_5.jar nc $t0 $t1 $t2 suma.asm
```

## Guion del video

### 1. hello.asm

| Instrucción | Registro | Valor | Qué pasa |
|---|---|---|---|
| `li $v0, 4` | `$v0` | `4` | Código de syscall para imprimir string |
| `la $a0, msg` | `$at`, `$a0` | `0x10010000` | MARS la expande en `lui $at, 0x1001` + `ori $a0, $at, 0`. `$a0` queda con la dirección del string en el segmento `.data` |
| `syscall` | — | — | Lee `$v0` = 4 e imprime el string que apunta `$a0` |
| `li $v0, 10` | `$v0` | `10` | Código de syscall para terminar |
| `syscall` | — | — | Termina el programa |

Puntos a mencionar:
- `la` es una pseudoinstrucción; en la columna *Basic* del Text Segment se ven las dos instrucciones reales y por eso cambia `$at` (registro reservado para el ensamblador).
- `$pc` avanza de 4 en 4 (cada instrucción ocupa 4 bytes) desde `0x00400000`.
- En el Data Segment, en `0x10010000`, se ven los bytes de `"Hello World"`.

### 2. suma.asm

| Momento | `$t0` (N) | `$t1` (suma) | `$t2` (i) |
|---|---|---|---|
| Después de las 3 `li` | 5 | 0 | 1 |
| Fin de la vuelta 1 | 5 | 1 | 2 |
| Fin de la vuelta 2 | 5 | 3 | 3 |
| Fin de la vuelta 3 | 5 | 6 | 4 |
| Fin de la vuelta 4 | 5 | 10 | 5 |
| Fin de la vuelta 5 | 5 | 15 (`0xf`) | 6 |
| `bgt` salta a `fin` | 5 | 15 | 6 |

Después:
- `li $v0, 1` + `move $a0, $t1` → `$a0` = 15 y el syscall 1 lo imprime como entero.
- Al final `$a0` = `0x1001000d`, la dirección de `nl` (va justo después de los 13 bytes de `"Suma 1..5 = "`).

Puntos a mencionar:
- `bgt` también es pseudoinstrucción (`slt $at, ...` + `bne`), así que `$at` cambia en cada vuelta.
- En `j ciclo` se ve cómo `$pc` regresa a la dirección de la etiqueta `ciclo`.
- Los valores de MARS salen en hexadecimal; con `Settings > Values displayed in hexadecimal` desactivado se ven en decimal.

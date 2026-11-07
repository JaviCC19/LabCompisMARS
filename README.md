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


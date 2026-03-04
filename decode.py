# Pablo García López pablo.glopez@udc.es
# Ansur Lopez Braña mail

import sys
import subprocess

def decode(kb_file, domain_file, output_file):
    # Ejecutar clingo y capturar la salida
    result = subprocess.run(
        ['clingo', kb_file, domain_file],
        capture_output=True, text=True
    )

    # Leer los stitches de la salida
    stitches = set()
    n = None
    for line in result.stdout.split('\n'):
        # Buscar el Answer
        if line.startswith('Answer:'):
            continue
        for token in line.split():
            if token.startswith('stitch('):
                # Parsear stitch(X1,Y1,X2,Y2)
                coords = token[7:-1].split(',')
                x1, y1, x2, y2 = int(coords[0]), int(coords[1]), int(coords[2]), int(coords[3])
                stitches.add((x1, y1, x2, y2))

    # Leer N del dominio
    with open(domain_file, 'r') as f:
        for line in f:
            if line.startswith('gridsize('):
                n = int(line.strip()[9:-2])
                break

    if n is None:
        print("Error: no se encontró gridsize en el dominio")
        sys.exit(1)

    # Construir la cuadrícula
    grid = [['.' for _ in range(n)] for _ in range(n)]

    for (x1, y1, x2, y2) in stitches:
        if x1 == x2:
            # Puntada horizontal: misma fila, columnas consecutivas
            grid[x1][y1] = '>'
            grid[x2][y2] = '<'
        else:
            # Puntada vertical: misma columna, filas consecutivas
            grid[x1][y1] = 'v'
            grid[x2][y2] = '^'

    # Escribir la solución
    with open(output_file, 'w') as f:
        for row in grid:
            f.write(''.join(row) + '\n')

    print(f"Solución guardada en {output_file}")

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print("Uso: python3 decode.py stitches.lp domXX.lp solXX.txt")
        sys.exit(1)
    decode(sys.argv[1], sys.argv[2], sys.argv[3])

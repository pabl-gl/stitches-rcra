import sys, os

def encode(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.read().strip().split('\n')

    # linea 1 n y m
    n, m = map(int, lines[0].split())

    # linea 2 a n+1 cuadricula
    grid = []
    for i in range(1, n + 1):
        grid.append(lines[i].strip())

    # linea n+2 agujeros col
    col_holes = list(map(int, lines[n + 1].split()))

    # linea n+3 agujeros fila
    row_holes = list(map(int, lines[n + 2].split()))

    with open(output_file, 'w') as out:


        out.write(f"gridsize({n}).\n")
        out.write(f"stitches_per_border({m}).\n")

        out.write(f"row(0..{n-1}).\n")
        out.write(f"col(0..{n-1}).\n")

        # region celdas
        for i in range(n):
            for j in range(n):
                region = grid[i][j]
                out.write(f"cell({i},{j},{region}).\n")


        for j in range(n):
            out.write(f"col_holes({j},{col_holes[j]}).\n")


        for i in range(n):
            out.write(f"row_holes({i},{row_holes[i]}).\n")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Uso: python3 encode.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    encode(input_file, output_file)
    print(f"ASP file generated: {output_file}")

import clingo
import sys

### comprobar argumentos
if len(sys.argv) != 4:
    print("Uso: python3 decode.py stitches.lp domXX.lp solXX.txt")
    sys.exit()

kb_file = sys.argv[1]
domain_file = sys.argv[2]
output_file = sys.argv[3]

# cargar programa ASP
ctl = clingo.Control()
ctl.load(kb_file)
ctl.load(domain_file)
ctl.ground([("base", [])])

stitches = set()
n = None
nummodels = 0

# resolver
with ctl.solve(yield_=True) as handle:
    for model in handle:

        if nummodels > 0:
            print("Warning: more than 1 model")
            break

        for atom in model.symbols(atoms=True):

            if atom.name == "gridsize" and len(atom.arguments) == 1:
                n = atom.arguments[0].number

            elif atom.name == "stitch" and len(atom.arguments) == 4:
                x1 = atom.arguments[0].number
                y1 = atom.arguments[1].number
                x2 = atom.arguments[2].number
                y2 = atom.arguments[3].number
                stitches.add((x1,y1,x2,y2))

        nummodels = 1

if nummodels == 0:
    print("UNSATISFIABLE")
    sys.exit()

# construir grid
grid = [['.' for _ in range(n)] for _ in range(n)]

for (x1,y1,x2,y2) in stitches:
    if x1 == x2:
        grid[x1][y1] = '>'
        grid[x2][y2] = '<'
    else:
        grid[x1][y1] = 'v'
        grid[x2][y2] = '^'

# escribir archivo de salida
with open(output_file, "w") as f:
    for row in grid:
        f.write("".join(row) + "\n")

print(f"Solution written to {output_file}")

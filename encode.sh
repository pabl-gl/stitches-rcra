#!/bin/bash
# Pablo García López pablo.glopez@udc.es
# Ansur Lopez Braña mail

EXAMPLES_DIR="examples"
ENCODINGS_DIR="encodings"

mkdir -p "$ENCODINGS_DIR"

if [[ -z "$1" ]]; then
    for file in "$EXAMPLES_DIR"/dom*.txt; do
        output="$ENCODINGS_DIR/$(basename "$file" .txt).lp"
        echo "Codificando: $file"
        python3 encode.py "$file" "$output"
        echo "Generado: $output"
    done
else
    num=$(printf "%02d" "$1")
    file="$EXAMPLES_DIR/dom${num}.txt"
    output="$ENCODINGS_DIR/dom${num}.lp"
    echo "Codificando: $file"
    python3 encode.py "$file" "$output"
    echo "Generado: $output"
fi

echo "=== Codificación completada ==="

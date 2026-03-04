#!/bin/bash
# Pablo García López pablo.glopez@udc.es
# Ansur Lopez Braña mail

ENCODINGS_DIR="encodings"
SOLUTIONS_DIR="solutions"
EXAMPLES_DIR="examples"

mkdir -p "$SOLUTIONS_DIR"

if [[ -z "$1" ]]; then
    for file in "$ENCODINGS_DIR"/dom*.lp; do
        num=$(basename "$file" .lp | sed 's/dom//')
        output="$SOLUTIONS_DIR/sol${num}.txt"
        echo "Resolviendo: $file"
        python3 decode.py stitches.lp "$file" "$output"
        if [ -f "$EXAMPLES_DIR/sol${num}.txt" ]; then
            if diff "$output" "$EXAMPLES_DIR/sol${num}.txt" > /dev/null; then
                echo "dom${num} CORRECTA"
            else
                echo "dom${num} DIFIERE de la esperada"
            fi
        fi
    done
else
    num=$(printf "%02d" "$1")
    file="$ENCODINGS_DIR/dom${num}.lp"
    output="$SOLUTIONS_DIR/sol${num}.txt"
    echo "Resolviendo: $file"
    python3 decode.py stitches.lp "$file" "$output"
    if [ -f "$EXAMPLES_DIR/sol${num}.txt" ]; then
        if diff "$output" "$EXAMPLES_DIR/sol${num}.txt" > /dev/null; then
            echo "dom${num} CORRECTA"
        else
            echo "dom${num} DIFIERE de la esperada"
        fi
    fi
fi

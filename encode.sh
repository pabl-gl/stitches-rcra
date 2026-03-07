#!/bin/bash

EXAMPLES_DIR="examples"
ENCODINGS_DIR="encodings"

mkdir -p "$ENCODINGS_DIR"

if [[ -z "$1" ]]; then
    for file in "$EXAMPLES_DIR"/dom*.txt; do
        output="$ENCODINGS_DIR/$(basename "$file" .txt).lp"
        python3 encode.py "$file" "$output"
        echo "Created $output"
	echo "---------------------------"
    done
else
    num=$(printf "%02d" "$1")
    file="$EXAMPLES_DIR/dom${num}.txt"
    output="$ENCODINGS_DIR/dom${num}.lp"
    python3 encode.py "$file" "$output"
    echo " Created $output"
    echo "-------------------------------"
fi

echo "Encoding complete."

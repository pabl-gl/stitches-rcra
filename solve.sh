#!/bin/bash
ENCODINGS_DIR="encodings"
SOLUTIONS_DIR="solutions"
EXAMPLES_DIR="examples"

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

CHECK="[✔]"
CROSS="[✖]"

mkdir -p "$SOLUTIONS_DIR"

if [[ -z "$1" ]]; then
    for file in "$ENCODINGS_DIR"/dom*.lp; do
        num=$(basename "$file" .lp | sed 's/dom//')
        output="$SOLUTIONS_DIR/sol${num}.txt"

        echo "Solving: $file"
        python3 decode.py stitches.lp "$file" "$output"

        if [ -f "$EXAMPLES_DIR/sol${num}.txt" ]; then
            if diff "$output" "$EXAMPLES_DIR/sol${num}.txt" > /dev/null; then
                echo -e "${GREEN}${CHECK} dom${num} solution is correct${RESET}"
            else
                echo -e "${RED}${CROSS} dom${num}  solution differs from expected output${RESET}"
            fi
            echo "---------------------------"
        fi
    done
else
    num=$(printf "%02d" "$1")
    file="$ENCODINGS_DIR/dom${num}.lp"
    output="$SOLUTIONS_DIR/sol${num}.txt"

    echo "Solving: $file"
    python3 decode.py stitches.lp "$file" "$output"

    if [ -f "$EXAMPLES_DIR/sol${num}.txt" ]; then
        if diff "$output" "$EXAMPLES_DIR/sol${num}.txt" > /dev/null; then
            echo -e "${GREEN}${CHECK} dom${num} solution is correct${RESET}"
        else
            echo -e "${RED}${CROSS} dom${num}  solution differs from expected output${RESET}"
        fi
        echo "---------------------------"
    fi
fi

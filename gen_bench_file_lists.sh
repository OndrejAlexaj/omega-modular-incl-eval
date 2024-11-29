#!/bin/bash

target_dir="automata/rabit"
output_file="bench/rabit_hoa"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.hoa ]]; then
        base="${file%A.hoa}" # Remove 'A.hoa' to get the base name
        pair="${base}B.hoa"  # Add 'B.hoa' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
        fi
    fi
done

target_dir="automata/hyperltl"
output_file="bench/hyperltl"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.hoa ]]; then
        base="${file%A.hoa}" # Remove 'A.hoa' to get the base name
        pair="${base}B.hoa"  # Add 'B.hoa' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
        fi
    fi
done

target_dir="automata/termination"
output_file="bench/termination"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.ba.hoa ]]; then
        base="${file%A.ba.hoa}" # Remove 'A.ba.hoa' to get the base name
        pair="${base}B.ba.hoa"  # Add 'B.ba.hoa' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
        fi
    fi
done
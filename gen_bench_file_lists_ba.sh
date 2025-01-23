#!/bin/bash

target_dir="automata_ba/automata/rabit"
mkdir -p automata_ba/automata/
output_file="bench_ba/rabit_hoa"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.hoa.ba ]]; then
        base="${file%A.hoa.ba}" # Remove 'A.hoa.ba' to get the base name
        pair="${base}B.hoa.ba"  # Add 'B.hoa.ba' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
            echo "$pair;$file" >> "$output_file"
        fi
    fi
done

target_dir="automata_ba/automata/hyperltl"
output_file="bench_ba/hyperltl"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.hoa.ba ]]; then
        base="${file%A.hoa.ba}" # Remove 'A.hoa.ba' to get the base name
        pair="${base}B.hoa.ba"  # Add 'B.hoa.ba' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
            echo "$pair;$file" >> "$output_file"
        fi
    fi
done

target_dir="automata_ba/automata/termination"
output_file="bench_ba/termination"
> "$output_file"
find "$target_dir" -type f | sort | while read -r file; do
    if [[ $file == *A.ba.hoa.ba ]]; then
        base="${file%A.ba.hoa.ba}" # Remove 'A.ba.hoa.ba' to get the base name
        pair="${base}B.ba.hoa.ba"  # Add 'B.ba.hoa.ba' to form the pair
        if [[ -f $pair ]]; then
            echo "$file;$pair" >> "$output_file"
            echo "$pair;$file" >> "$output_file"
        fi
    fi
done
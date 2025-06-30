#!/bin/bash

# Convert PDF to images using pdftoppm with dimensions divisible by 28
# Usage: ./convert_pdf_to_images.sh input.pdf output_dir

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input.pdf> <output_directory>"
    exit 1
fi

INPUT_PDF="$1"
OUTPUT_DIR="$2"

# Check if input file exists
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Input PDF file not found: $INPUT_PDF"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Convert PDF to images using pdftoppm
# Calculate dimensions divisible by 28 for A4 at ~150 DPI
# 1764x2352 pixels (both divisible by 28, close to 150 DPI for A4)
echo "Converting PDF to images with dimensions divisible by 28..."
pdftoppm -scale-to-x 1764 -scale-to-y 2352 -png -cropbox "$INPUT_PDF" "$OUTPUT_DIR/page"

if [ $? -eq 0 ]; then
    echo "Conversion complete. Images saved to $OUTPUT_DIR/ with dimensions 1764x2352 (divisible by 28)"
else
    echo "Error: Conversion failed"
    exit 1
fi
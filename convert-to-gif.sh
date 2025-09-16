#!/bin/bash

# Convert MP4 videos to optimized GIFs
# Usage: ./convert-to-gif.sh [input.mp4] [speed_multiplier] [max_width]
# Examples:
#   ./convert-to-gif.sh amp_tab.mp4          # Default 2x speed, 1920px width
#   ./convert-to-gif.sh cursor_tab.mp4 1.5   # 1.5x speed, 1920px width
#   ./convert-to-gif.sh amp_tab.mp4 2 1280   # 2x speed, 1280px width

set -e

# Default values
DEFAULT_SPEED=2.0
DEFAULT_WIDTH=1920
DEFAULT_FPS=60

# Function to show usage
show_usage() {
    echo "Usage: $0 <input.mp4> [speed_multiplier] [max_width]"
    echo ""
    echo "Arguments:"
    echo "  input.mp4        Required: Input MP4 file"
    echo "  speed_multiplier Optional: Speed multiplier (default: $DEFAULT_SPEED)"
    echo "  max_width       Optional: Maximum width in pixels (default: $DEFAULT_WIDTH)"
    echo ""
    echo "Examples:"
    echo "  $0 amp_tab.mp4"
    echo "  $0 cursor_tab.mp4 1.5"
    echo "  $0 amp_tab.mp4 2 1280"
    exit 1
}

# Check if ffmpeg is installed
check_ffmpeg() {
    if ! command -v ffmpeg &> /dev/null; then
        echo "Error: ffmpeg is not installed."
        echo "To install on macOS, run: brew install ffmpeg"
        exit 1
    fi
}

# Parse arguments
if [ $# -lt 1 ]; then
    show_usage
fi

INPUT_FILE="$1"
SPEED_MULTIPLIER="${2:-$DEFAULT_SPEED}"
MAX_WIDTH="${3:-$DEFAULT_WIDTH}"

# Validate input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' does not exist."
    exit 1
fi

# Check dependencies
check_ffmpeg

# Extract filename without extension
FILENAME=$(basename "$INPUT_FILE" .mp4)
OUTPUT_FILE="${FILENAME}_${SPEED_MULTIPLIER}x.gif"
PALETTE_FILE="${FILENAME}_palette.png"

echo "Converting $INPUT_FILE to $OUTPUT_FILE..."
echo "Speed: ${SPEED_MULTIPLIER}x | Max Width: ${MAX_WIDTH}px"

# Calculate PTS value for speed (inverse of speed multiplier)
PTS_VALUE=$(echo "scale=3; 1/$SPEED_MULTIPLIER" | bc -l)

# Generate optimized palette
echo "Generating palette..."
ffmpeg -y -i "$INPUT_FILE" \
    -vf "setpts=${PTS_VALUE}*PTS,fps=$DEFAULT_FPS,scale=${MAX_WIDTH}:-1:flags=lanczos,palettegen=max_colors=256:stats_mode=full" \
    "$PALETTE_FILE" \
    -loglevel warning

# Create GIF with palette
echo "Creating GIF..."
ffmpeg -y -i "$INPUT_FILE" -i "$PALETTE_FILE" \
    -filter_complex "setpts=${PTS_VALUE}*PTS,fps=$DEFAULT_FPS,scale=${MAX_WIDTH}:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=none:diff_mode=rectangle:new=1:alpha_threshold=128" \
    "$OUTPUT_FILE" \
    -loglevel warning

# Clean up palette file
rm "$PALETTE_FILE"

echo "✅ Conversion completed: $OUTPUT_FILE"

# Show file sizes for comparison
INPUT_SIZE=$(du -h "$INPUT_FILE" | cut -f1)
OUTPUT_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
echo "📊 File sizes: $INPUT_FILE ($INPUT_SIZE) → $OUTPUT_FILE ($OUTPUT_SIZE)"

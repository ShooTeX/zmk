#!/bin/bash

# Source the Zephyr environment
source .venv/bin/activate

# Navigate to the app directory
cd "$(dirname "$0")/app" || {
  echo "Failed to change directory to app"
  exit 1
}

# Build for the left side
west build -d build/left -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="/Users/stx/dev/miryoku_zmk/config"

# Check if the first command was successful
if [ $? -eq 0 ]; then
  echo "Left side build succeeded."
else
  echo "Left side build failed."
  exit 1
fi

# Build for the right side
west build -d build/right -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG="/Users/stx/dev/miryoku_zmk/config"

# Check if the second command was successful
if [ $? -eq 0 ]; then
  echo "Right side build succeeded."
else
  echo "Right side build failed."
  exit 1
fi

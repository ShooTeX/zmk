#!/bin/bash

# Source the Zephyr environment
source .venv/bin/activate

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
  echo -e "${GREEN}Usage: $0 {left|right}${NC}"
  exit 1
}

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
  echo -e "${RED}Error: Exactly one argument is required.${NC}"
  usage
fi

# Determine which side to flash
SIDE=$1
if [ "$SIDE" == "left" ]; then
  BUILD_DIR="left"
elif [ "$SIDE" == "right" ]; then
  BUILD_DIR="right"
else
  echo -e "${RED}Error: Invalid option.${NC}"
  usage
fi

# Flash the firmware
west flash --build-dir "app/build/$BUILD_DIR"

# Check if the flash command was successful
if [ $? -eq 0 ]; then
  echo -e "${GREEN}$SIDE side flashed successfully.${NC}"
else
  echo -e "${RED}$SIDE side flash failed.${NC}"
  exit 1
fi

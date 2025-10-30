#!/bin/bash
set -e

# Wrapper script to start Bonfire with explicit logging
cd __INSTALL_DIR__

# Source environment
set -a
source .env
set +a

# Ensure log directory exists
mkdir -p /var/log/__APP__

# Start Bonfire and redirect all output to log file
# Note: Don't use 'exec' with pipes - it causes issues with process replacement
./bin/bonfire start 2>&1 | tee -a /var/log/__APP__/startup.log

#!/bin/bash

# Helper script to diagnose Bonfire startup issues
# Usage: Run this as the bonfire user to test if the app can start

APP_DIR="${1:-/var/www/bonfire}"

echo "=== Checking Bonfire Startup ==="
echo "Install directory: $APP_DIR"
echo ""

# Check if bin/bonfire exists
if [ ! -f "$APP_DIR/bin/bonfire" ]; then
    echo "ERROR: $APP_DIR/bin/bonfire not found"
    exit 1
fi

# Check if .env exists
if [ ! -f "$APP_DIR/.env" ]; then
    echo "ERROR: $APP_DIR/.env not found"
    exit 1
fi

echo "Files check: OK"
echo ""

# Load environment
export MIX_ENV=prod
export HOME="$APP_DIR"
cd "$APP_DIR"

# Source .env
set -a
source .env
set +a

echo "Environment loaded"
echo "MIX_ENV=$MIX_ENV"
echo "HOSTNAME=$HOSTNAME"
echo "SERVER_PORT=$SERVER_PORT"
echo ""

# Try to start Bonfire in foreground for 10 seconds
echo "=== Attempting to start Bonfire (will run for 10 seconds) ==="
echo "Command: ./bin/bonfire start"
echo ""

timeout 10s ./bin/bonfire start || {
    exit_code=$?
    if [ $exit_code -eq 124 ]; then
        echo ""
        echo "SUCCESS: Bonfire ran for 10 seconds without crashing"
        echo "This suggests the issue may be with systemd configuration, not Bonfire itself"
    else
        echo ""
        echo "ERROR: Bonfire exited with code $exit_code"
        echo "Check the output above for error messages"
    fi
}

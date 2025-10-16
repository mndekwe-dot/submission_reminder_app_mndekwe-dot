#!/bin/bash

# Startup Script for Submission Reminder App
# This script initializes and runs the reminder application

echo "=========================================="
echo "Starting Submission Reminder Application..."
echo "=========================================="
echo ""

# Navigate to the app directory
cd "$(dirname "$0")" || exit 1

# Source the reminder script
source ./modules/reminder.sh

echo ""
echo "=========================================="
echo "Application execution completed!"
echo "=========================================="

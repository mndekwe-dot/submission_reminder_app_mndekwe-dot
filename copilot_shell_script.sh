#!/bin/bash

# Copilot Shell Script for Submission Reminder App
# This script allows users to update the assignment name in config.env

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Submission Reminder App - Copilot"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

# Prompt user for the app directory name
read -p "Enter your submission reminder app directory name (e.g., submission_reminder_yourname): " app_dir

# Check if directory exists
if [ ! -d "$main_app_dir" ]; then
    echo "Error: Directory $main_app_dir does not exist!"
    exit 1
fi

# Check if config.env exists
if [ ! -f "$main_app_dir/config/config.env" ]; then
    echo "Error: config.env file not found in $main_app_dir/config/"
    exit 1
fi

# Display current assignment
echo ""
echo "Current configuration:"
cat "$main_app_dir/config/config.env"
echo ""

# Prompt user for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Validate input
if [ -z "$new_assignment" ]; then
    echo "Error: Assignment name cannot be empty!"
    exit 1
fi

# Update the ASSIGNMENT value in config.env using sed
# This replaces the ASSIGNMENT line with the new value
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$main_app_dir/config/config.env"

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Assignment updated successfully!"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "New configuration:"
cat "$main_app_dir/config/config.env"
echo ""

# Ask if user wants to run the application immediately
read -p "Do you want to run the application now? (y/n): " run_code

if [ "$run_code" == "yes" ] || [ "$run_code" == "y" ]; then
    echo ""
    echo "Running application..."
    echo ""
    cd "$main_app_dir" || exit 1
    ./startup.sh
else
    echo "To run the application later, execute:"
    echo "cd $main_app_dir"
    echo "./startup.sh"
fi

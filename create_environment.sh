#!/bin/bash

# Create Environment Setup Script for Submission Reminder App
# This script sets up the directory structure and files for the application

# Allows user to enter his/her name
read -p "Enter you name: " user_name

# Creation of  main application directory
main_app_dir="submission_reminder_${user_name}"

# to verify if directory already exists
if [ -d "$main_app_dir" ]; then
    echo "Directory $main_app_dir already exists. Exiting..."
    exit 1
fi

# if it don't exist it will Create it (main directory)
mkdir -p "$main_app_dir"
echo "Created directory: $main_app_dir"

# it will Create subdirectories
mkdir -p "$main_app_dir/config"
mkdir -p "$main_app_dir/modules"
mkdir -p "$main_app_dir/assets"
echo "config, modules and assets has been Created."

# Create config.env file
cat > "$main_app_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "config.env has been created"

# Create functions.sh file
cat > "$main_app_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
echo "Created functions.sh"

# Create reminder.sh file
cat > "$main_app_dir/modules/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
echo "Created reminder.sh"

# Create submissions.txt file with at least 5 additional student records
cat > "$main_app_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Mukama, Shell Navigation, not submitted
Mukesha, Shell Basics, not submitted
Jackson, Git, submitted
Amanda, Shell Navigation, not submitted
George, Shell Basics, not submitted
Mugabe, Git, not submitted
EOF
echo "Created submissions.txt with 10 student records"

# Create startup.sh file
cat > "$main_app_dir/startup.sh" << 'EOF'
#!/bin/bash

# Startup Script for Submission Reminder App
# This script initializes and runs the reminder application

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Starting Submission Reminder Application..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

# Navigate to the app directory
cd "$(dirname "$0")" || exit 1

# Source the reminder script
source ./modules/reminder.sh

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Application execution completed!"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
EOF
echo "Created startup.sh"

# Make all .sh files executable
chmod +x "$main_app_dir/startup.sh"
chmod +x "$main_app_dir/modules/reminder.sh"
chmod +x "$main_app_dir/modules/functions.sh"
echo "Set execute permissions on all .sh files"

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Environment setup completed successfully!"
echo "Directory structure created: $main_app_dir"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo "To test the application, run:"
echo "cd $main_app_dir"
echo "./startup.sh"

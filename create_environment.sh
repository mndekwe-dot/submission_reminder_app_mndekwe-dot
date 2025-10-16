#!/bin/bash

# Create Environment Setup Script for Submission Reminder App
# This script sets up the directory structure and files for the application

# Prompt user for their name
read -p "Enter your name: " user_name

# Create main application directory
app_dir="submission_reminder_${user_name}"

# Check if directory already exists
if [ -d "$app_dir" ]; then
    echo "Directory $app_dir already exists. Exiting..."
    exit 1
fi

# Create the main directory
mkdir -p "$app_dir"
echo "Created directory: $app_dir"

# Create subdirectories
mkdir -p "$app_dir/config"
mkdir -p "$app_dir/modules"
mkdir -p "$app_dir/assets"
echo "Created subdirectories: config, modules, assets"

# Create config.env file
cat > "$app_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "Created config.env"

# Create functions.sh file
cat > "$app_dir/modules/functions.sh" << 'EOF'
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
cat > "$app_dir/modules/reminder.sh" << 'EOF'
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
cat > "$app_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
David, Shell Navigation, not submitted
Grace, Shell Basics, not submitted
Samuel, Git, submitted
Amara, Shell Navigation, not submitted
Kwame, Shell Basics, not submitted
Zainab, Git, not submitted
EOF
echo "Created submissions.txt with 10 student records"

# Create startup.sh file
cat > "$app_dir/startup.sh" << 'EOF'
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
EOF
echo "Created startup.sh"

# Make all .sh files executable
chmod +x "$app_dir/startup.sh"
chmod +x "$app_dir/modules/reminder.sh"
chmod +x "$app_dir/modules/functions.sh"
echo "Set execute permissions on all .sh files"

echo ""
echo "=========================================="
echo "Environment setup completed successfully!"
echo "Directory structure created: $app_dir"
echo "=========================================="
echo ""
echo "To test the application, run:"
echo "cd $app_dir"
echo "./startup.sh"

# Submission Reminder App

A shell script-based application that helps track and remind students about pending assignment submissions.

## Overview

This application automates the process of checking student submission statuses and sends reminders to students who haven't submitted their assignments. It uses a flexible configuration system that allows easy updates to assignment names and tracking multiple students across different assignments.

## Installation & Setup

### Step 1: Run the Setup Script

First, make the setup script executable and run it:

```bash
chmod +x create_environment.sh
./create_environment.sh
```

The script will:
- Prompt you for your name
- Create a directory named `submission_reminder_{yourName}`
- Set up the required directory structure (config, modules, assets)
- Create all necessary configuration and data files
- Set executable permissions on all shell scripts

### Step 2: Test the Application

Navigate to the created directory and run the startup script:

```bash
cd submission_reminder_{yourName}
./startup.sh
```
## Directory Structure

After running `create_environment.sh`, the following structure is created:

```
submission_reminder_{yourName}/
├── config/
│   └── config.env           
├── modules/
│   ├── functions.sh         
│   └── reminder.sh          
├── assets/
│   └── submissions.txt      
└── startup.sh              
```

## File Descriptions

### startup.sh
Entry point that executes the reminder application


## Customization

### Adding Student Records

Edit `submission_reminder_{yourName}/assets/submissions.txt`:

```bash
nano submission_reminder_{yourName}/assets/submissions.txt
```

Add new lines with the format:
```
StudentName, AssignmentName, submitted
```

### Changing Configuration Values

Edit `submission_reminder_{yourName}/config/config.env`:

```bash
nano submission_reminder_{yourName}/config/config.env
```

Or use the copilot script for automated updates:

```bash
./copilot_shell_script.sh
```

## Troubleshooting

### "Permission denied" when running scripts
Make sure the scripts are executable:
```bash
chmod +x create_environment.sh
chmod +x copilot_shell_script.sh
```

### Scripts not found
Ensure you're in the correct directory and the path to the script is correct.

### No reminders displayed
1. Check that students have "not submitted" in the `submissions.txt` file
2. Verify the assignment name in `config.env` matches the assignment name in `submissions.txt`
3. Check for extra spaces in the CSV file that might prevent matching

## Version Control with Git

This project uses Git branching:
- **feature branch**: Used for development (e.g., `feature/setup`)
- **main branch**: Contains the final, production-ready code

### Basic Git Workflow

```bash
# Clone the repository
git clone https://github.com/yourusername/submission_reminder_app_yourusername.git
cd submission_reminder_app_yourusername

# Create and switch to feature branch
git checkout -b feature/setup

# Make changes and commit
git add .
git commit -m "Initial setup scripts"

# Switch to main and merge
git checkout main
git merge feature/setup

# Push to GitHub
git push origin main
```

## Repository Structure

The GitHub repository should contain only:
- `create_environment.sh` - Setup script
- `copilot_shell_script.sh` - Assignment updater script
- `README.md` - This documentation file

## Examples

### Example 1: Initial Setup

```bash
$ chmod +x create_environment.sh
$ ./create_environment.sh
Enter your name: john
Created directory: submission_reminder_john
Created subdirectories: config, modules, assets
...
Environment setup completed successfully!

$ cd submission_reminder_john
$ ./startup.sh
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
```

### Example 2: Update Assignment

```bash
$ ./copilot_shell_script.sh
Enter your submission reminder app directory name: submission_reminder_john
Enter the new assignment name: Git
Assignment updated successfully!
Do you want to run the application now? (yes/no): yes

Assignment: Git
Days remaining to submit: 2 days
--------------------------------------------
Reminder: Chiagoziem has not submitted the Git assignment!
```


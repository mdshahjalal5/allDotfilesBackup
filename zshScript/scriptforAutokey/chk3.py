import subprocess  # Add this line to import the subprocess module

# Run a shell command to check if Visual Studio Code is running
window_check_command = "pgrep -f 'Visual Studio Code'"
window_check_output = subprocess.check_output(window_check_command, shell=True)

# Convert output to string
window_check_output = window_check_output.decode("utf-8")

# If Visual Studio Code is running, bring its window to focus using xdotool
if window_check_output.strip():
    subprocess.Popen("xdotool search --name 'Visual Studio Code' windowactivate", shell=True)
else:
    # If Visual Studio Code is not running, launch it
    subprocess.Popen("code", shell=True)

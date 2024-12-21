import subprocess

# Define the URL
url = "https://web.programming-hero.com/dashboard"

# Open the URL in the default web browser
subprocess.Popen(["xdg-open", url])

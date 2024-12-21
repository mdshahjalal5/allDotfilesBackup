import subprocess

# Define the URL
url = "https://mail.google.com/mail/u/0/?ogbl#inbox"

# Open the URL in the default web browser
subprocess.Popen(["xdg-open", url])



import subprocess

# Define the URL
url = "https://www.youtube.com/watch?v=gtdc0_rjMVk&list=PL4Tjyk-l8yMgw_O0mO5sMNsVDDXBGVOrX&pp=iAQB"

# Open the URL in the default web browser
subprocess.Popen(["xdg-open", url])
# Enter script code
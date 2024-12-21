import subprocess
import time

import pyautogui


# Function to check if the ChatGPT tab is already open
def is_chatgpt_tab_open():
    try:
        output = subprocess.check_output(["wmctrl", "-l"]).decode("utf-8")
        return "ChatGPT" in output
    except subprocess.CalledProcessError:
        return False

# Function to focus the ChatGPT tab
def focus_chatgpt_tab():
    subprocess.Popen(["wmctrl", "-a", "ChatGPT"])

# Function to open ChatGPT webpage and focus input box
def open_chatgpt_webpage():
    subprocess.Popen(["google-chrome", "https://chat.openai.com"])
    time.sleep(5)  # Wait for the webpage to load
    pyautogui.click(x=500, y=500)  # Click to focus the input box

# Function to get selected text
def get_selected_text():
    try:
        selected_text = subprocess.check_output(["xclip", "-o", "-selection", "primary"]).decode("utf-8").strip()
    subprocess.Popen(["wmctrl", "-a", "ChatGPT"])

# Function to open ChatGPT webpage and focus input box
def open_chatgpt_webpage():
    subprocess.Popen(["google-chrome", "https://chat.openai.com"])
    time.sleep(5)  # Wait for the webpage to load
    pyautogui.click(x=500, y=500)  # Click to focus the input box

# Function to get selected text
def get_selected_text():
    try:
        selected_text = subprocess.check_output(["xclip", "-o", "-selection", "primary"]).decode("utf-8").strip()
        return selected_text
    except subprocess.CalledProcessError:
        return ""

# Main function
def main():
    selected_text = get_selected_text()
    if selected_text:
        if not is_chatgpt_tab_open():
            open_chatgpt_webpage()
        else:
 
        return ""

# Main function
def main():
    selected_text = get_selected_text()
    if selected_text:
        if not is_chatgpt_tab_open():
            open_chatgpt_webpage()
        else:
            focus_chatgpt_tab()
        pyautogui.hotkey('ctrl', 'a')  # Select all existing text
        pyautogui.typewrite(selected_text)  # Type the selected text into the input box
    else:
        if is_chatgpt_tab_open():
            focus_chatgpt_tab()
        else:
            open_chatgpt_webpage()

# Call the main function
main()

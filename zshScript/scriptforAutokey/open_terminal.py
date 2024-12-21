# Enter script code
import subprocess
import pygetwindow as gw

def get_active_window_title():
    try:
        return gw.getActiveWindow().title
    except AttributeError:
        return ""

active_window_title = get_active_window_title()

def main():
    if "Nautilus" in active_window_title:
        # Nautilus is active, get its current path and open Terminal
        try:
            nautilus_path = subprocess.check_output(["xdotool", "getwindowfocus", "getwindowname"]).decode("utf-8").strip()
            subprocess.Popen(["konsole", "--workdir", nautilus_path])
        except subprocess.CalledProcessError:
            # Handle error
            pass
    elif "Konsole" in active_window_title or "Terminal" in active_window_title:
        # Terminal is active, open Nautilus in its current path
        try:
            terminal_path = subprocess.check_output(["xdotool", "getwindowfocus", "getwindowname"]).decode("utf-8").strip()
            subprocess.Popen(["nautilus", terminal_path])
        except subprocess.CalledProcessError:
            # Handle error
            pass
    else:
        # Neither Nautilus nor Terminal is active, open Terminal in the specified directory
        subprocess.Popen(["konsole", "--workdir", "/media/mdshahjalal5/forUbuntu2/ubuntu_downloader/"])

if __name__ == "__main__":
    main()

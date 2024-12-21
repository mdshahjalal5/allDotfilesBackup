import datetime

# Get the current date and time
current_date_time = datetime.datetime.now()

# Format the date and time
formatted_date_time = current_date_time.strftime('%d/%m/%Y %a %I:%M:%S %p ')

# Paste the formatted date and time
keyboard.send_keys(formatted_date_time)

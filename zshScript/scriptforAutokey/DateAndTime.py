import datetime

# Get the current date and time for GMT+6
current_date_time_gmt6 = datetime.datetime.utcnow() + datetime.timedelta(hours=6)

# Format the date and time
formatted_date_time_gmt6 = current_date_time_gmt6.strftime('%d/%m/%Y %H:%M:%S')

# Paste the formatted date and time
keyboard.send_keys(formatted_date_time_gmt6)
                          
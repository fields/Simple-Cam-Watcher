# the path to watch on your computer
$WATCHDIR = '/your/dropbox/fullpath/camwatcher/*'

# the path to your control file
$CONTROLFILE = '/your/dropbox/fullpath/cam_control.txt'

# your twilio credentials
$MY_TWILIO_SID = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
$MY_AUTH_TOKEN = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
# the phone number you want sms notifications to go to
$TO_PHONE_NUM = '+1xxxxxxxxxx'
# For trial twilio accounts, the from number must be your sandbox number.
$FROM_PHONE_NUM = '+1xxxxxxxxxx'

# default delays and loops
$INITIAL_DELAY = ENV['INITIAL_DELAY'].to_i || 300
$WAIT_INTERVAL = ENV['WAIT_INTERVAL'].to_i || 120
$NOTIFY_ON_LOOP = ENV['NOTIFY_ON_LOOP'].to_i || 5
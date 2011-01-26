# the path to watch on your computer
$WATCHDIR = '/your/dropbox/fullpath/camwatcher/*'

# your twilio credentials
$MY_TWILIO_SID = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
$MY_AUTH_TOKEN = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
# the phone number you want sms notifications to go to
$TO_PHONE_NUM = '+1xxxxxxxxxx'
# For trial twilio accounts, the from number must be your sandbox number.
$FROM_PHONE_NUM = '+1xxxxxxxxxx'

# default delays and loops
$INITIAL_DELAY = ENV['INITIAL_DELAY'] || 300
$WAIT_INTERVAL = ENV['WAIT_INTERVAL'] || 120
$NOTIFY_ON_LOOP = ENV['NOTIFY_ON_LOOP'] || 5
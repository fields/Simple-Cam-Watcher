#!/usr/bin/env ruby

require 'twilio'
require './config'

puts "wait interval is #{$WAIT_INTERVAL}"
puts "sleeping for #{$INITIAL_DELAY} seconds"
sleep $INITIAL_DELAY.to_i
print "monitoring..."
pass = 0
while true
  newfiles = 0
  Dir[$WATCHDIR].each_with_index{|fullpath, index|
    stat = File.stat(fullpath)
    ctime = stat.ctime
    mtime = stat.mtime

    #  puts "ctime: #{ctime}"
    #  puts "mtime: #{mtime}"

    if (Time.now - ctime) < $WAIT_INTERVAL
      newfiles += 1
    end
  }

  Twilio::Config.setup do
    account_sid   $MY_TWILIO_SID
    auth_token    $MY_AUTH_TOKEN
  end

#  puts "#{newfiles} found"
  if newfiles > 0
    if pass % $NOTIFY_ON_LOOP == 0
      Twilio::SMS.create :to => $TO_PHONE_NUM, :from => $FROM_PHONE_NUM, :body => "New files in dropbox"
      print "!"
    else
      print "-"
    end
    print "#{newfiles}"
    pass += 1
  else
    print "."
    pass = 0
  end
  sleep $WAIT_INTERVAL.to_i
end

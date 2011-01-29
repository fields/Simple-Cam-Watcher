#!/usr/bin/env ruby

require 'twilio'
require './config'

STDOUT.sync = true
puts "wait interval is #{$WAIT_INTERVAL}"
puts "sleeping for #{$INITIAL_DELAY} seconds"
sleep $INITIAL_DELAY.to_i
print "monitoring..."
pass = 0

Twilio::Config.setup do
  account_sid   $MY_TWILIO_SID
  auth_token    $MY_AUTH_TOKEN
end

while true
  control_line = File.open($CONTROLFILE, 'r').first
  # stop until this command goes away
  if control_line.strip.downcase == "stop"
    print "%"
    sleep $WAIT_INTERVAL.to_i
    next
  end
  
  # sleep for the requested time, then remove the sleep command
  if control_line.strip.to_i > 0
    puts "Sleep command received. Sleeping for #{control_line} seconds"
    sleep control_line.to_i
    File.open($CONTROLFILE, 'w') {|file|
      file.truncate(0)
    }
  end

  newfiles = 0
  Dir[$WATCHDIR].each_with_index{|fullpath, index|
    # puts "processing #{fullpath}"
    # always skip the control file
    next if fullpath == $CONTROLFILE
    stat = File.stat(fullpath)
    ctime = stat.ctime
    mtime = stat.mtime

    #  puts "ctime: #{ctime}"
    #  puts "mtime: #{mtime}"

    # if the file is newer than the wait interval, flag it as a new file
    if (Time.now - ctime) < $WAIT_INTERVAL.to_i
      newfiles += 1
    end
  }

#  puts "#{newfiles} found"
  if newfiles > 0
    # if we have new files and it's time to notify, send an sms
    if pass % $NOTIFY_ON_LOOP == 0
      Twilio::SMS.create :to => $TO_PHONE_NUM, :from => $FROM_PHONE_NUM, :body => "New files in dropbox"
      print "!"
    else
      # otherwise skip
      print "-"
    end
    print "#{newfiles}"
    pass += 1
  else
    # if no new files, reset the pass counter
    print "."
    pass = 0
  end
  sleep $WAIT_INTERVAL.to_i
end

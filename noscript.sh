#!/bin/bash

# Noscript-email is a shell script that checks fail2ban.log for IPs that tripped the noscript filter. Webserver access logs are searched for these IPs you are emailed what was accessed as well as the geolocation of the offender.
# Paths are all binaries are hard coded so check paths for rm, grep, geoiplookup, mail, echo, etc. if you have problems

### User variables start

# Set your web server log location here:
log=/var/log/nginx/access

# Set your email address here:
email=notifications@youremail.com

### User variables end

# prep
/bin/rm /tmp/noscript.txt 2>/dev/null

# checks each IP, writes what they accessed and their geolocation to /tmp/noscript.txt
for i in $(/bin/grep noscript /var/log/fail2ban.log | /bin/grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | /usr/bin/uniq); do /bin/grep $i $log* >> /tmp/noscript.txt && /bin/echo >> /tmp/noscript.txt && /bin/echo "$i - $(/usr/bin/geoiplookup $i)" >> /tmp/noscript.txt && /bin/echo "---------" >> /tmp/noscript.txt; done

# mail results - edit to reflect your email address
/bin/cat /tmp/noscript.txt | /usr/bin/mail -s "No-script bans - $(date)" $email

# cleanup
/bin/rm  /tmp/noscript.txt 2>/dev/null

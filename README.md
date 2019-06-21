## Noscript-email

Noscript-email is a shell script that checks fail2ban.log for IPs that tripped the noscript filter. Webserver access logs are searched for these IPs and you are emailed what was accessed as well as the geolocation of the offender.

### Requirements:
fail2ban  
geoiplookup

### Notes:
Paths for all binaries are hard coded so check paths for rm, grep, geoiplookup, mail, echo, etc. if you have problems


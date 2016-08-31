#!/bin/bash
# My first script

# Get username
echo -n "Enter username:"; read username
# Get password
echo -n "Enter password:"; read password

# define hour
hour=0
# define hour in format in proper format
hour_format=0$hour

#check all 24 hours
until [ "$hour" -ge 24 ]; do
    # prepare url
    url=https://syslog.vast.com/syslog/fenode1.oak.vast.com/2016/08/31/$hour_format/vast_nginx-carfax-access.log
    # where to export files
    export_file=$hour_format"h.txt"
    # display info to terminal    
    echo "Get hour: $hour_format"
    # display info to terminal    
    echo "Into file: $export_file"
    # execute curl 
    curl -u $username:$password $url > $export_file
    # change hour counter
    hour=$((hour + 1))
    # prepare hour format for new url and file
    if [ "$hour" -lt 10 ]; then
        hour_format="0"$hour
    else
        hour_format=$hour
    fi
done

# ask user to enter phrase for searching
echo -n "Enter phrase for grep: "; read text
# collect grep result
grep_result=$(cat 0[1-24]h.txt | grep $text)
# show result on display
echo "Your result: " $grep_result
echo ''
echo "tnx for watching..."

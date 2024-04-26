#!/bin/bash

function line {
	echo "==============================================================="
}
function empty {
	echo ""
}
function line_empty {
	echo "==============================================================="
	echo ""
}

exec 1> ~/scripts/message.txt
empty
line
awk '{print $4}' ~/scripts/access.log | grep -Eo "[0-9]{2}\/[A-Z][a-z]{2}\/[0-9]{4}.*" | sort | awk 'NR == 1{print} END{print}' > ~/scripts/time.txt
start="$(cat ~/scripts/time.txt | awk 'NR == 1{print}')"
finish="$(cat ~/scripts/time.txt | awk 'END{print}')"
echo "from ${start} to ${finish}:"
line_empty
awk '{print $1}' ~/scripts/access.log | uniq -c | sort -n > ~/scripts/ip.txt
echo "IP:"
line
cat ~/scripts/ip.txt | awk '{
if ($1 > 10)
print "Count repeats: " $1" |" " ip: " $2
}'
line

exec 2>> ~/scripts/message.txt
cat ~/scripts/access.log | grep -Eo "(http|https)://[a-zA-Z0-9.]*" | sort | uniq -c | sort > ~/scripts/url.txt
empty
echo "URL:"
line
cat ~/scripts/url.txt | awk '{
if ($1 > 10)
print "Count repeats: " $1 " |" " URL: " $2
}'
line_empty

exec 3>> ~/scripts/message.txt
awk '{print $9}' ~/scripts/access.log | sed '/^[1-399]\|-/d' | uniq | sort > ~/scripts/err.txt
echo "ERROR:"
line
cat ~/scripts/err.txt | awk '{
if ($1 > 10)
print "Code error: " $1
}'

echo 'Test send file' | mail -s 'Send message file' -A ~/scripts/message.txt ypushkarev@24hsoft.com &&
echo 'The email has been sent'

rm -f ~/scripts/ip.txt
rm -f ~/scripts/url.txt
rm -f ~/scripts/err.txt
rm -f ~/scripts/time.txt
rm -f ~/scripts/message.txt

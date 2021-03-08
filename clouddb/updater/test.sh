uptime=$(uptime | awk '{print $3,$4}' | sed 's/,//')
prettyUptime=$(uptime -p | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}' | sed 's/,//')
together="$uptime or $prettyUptime"
echo $together

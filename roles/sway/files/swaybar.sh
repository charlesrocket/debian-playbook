##
date=$(date "+%d/%m/%Y")
time=$(date "+%H:%M")
##
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
##
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
loadavg_5=$(cat /proc/loadavg | awk -F ' ' '{print $2}')
##
if [ $battery_status = "discharging" ];
then
    battery_pluggedin='🔋'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="✘"
else
   network_active="⇆"
fi
##
echo "$network_active | $loadavg_5 | $battery_pluggedin $battery_charge | $date $time"
#!/bin/bash

echo "Content-type: text/plain"
echo ""

function check_weather() {
    echo "Enter the name of the destination:"
    read DESTINATION

    WEATHER_JSON=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=${DESTINATION}&appid=05ca3305e62bba66a67556db5f01ba54")
    TEMP=$(echo $WEATHER_JSON | jq .main.temp)
    DESCRIPTION=$(echo $WEATHER_JSON | jq .weather[0].description)

    dialog --msgbox "Weather in $DESTINATION:\nTemperature: $TEMP°C\nDescription: $DESCRIPTION" 10 40
}

function display_map() {
    echo "Enter the name of the destination:"
    read DESTINATION
    links "https://www.openstreetmap.org/search?query=${DESTINATION}"
}

function travel_checklist() {
    dialog --msgbox "Travel Checklist:\n\n- Passport\n- Tickets\n- Money & Cards\n- Clothes\n- Toiletries\n- Chargers\n- Medications" 15 40
}

while true; do
    CHOICE=$(dialog --menu "Travel Planner" 15 45 4 \
    1 "Check Weather" \
    2 "Display Map" \
    3 "Travel Checklist" \
    2>&1 >/dev/tty)

    case $CHOICE in
        1)
            check_weather
            ;;
        2)
            display_map
            ;;
        3)
            travel_checklist
            ;;
    esac
done

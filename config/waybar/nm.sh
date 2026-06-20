#!/bin/bash

# Liste des options principales
OPTIONS=("Connect Wi-Fi" "Disconnect Wi-Fi" "Status" "Quit")

CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -p "Network")

case "$CHOICE" in

    "Connect Wi-Fi")
        # Liste tous les SSID disponibles
        SSID=$(nmcli -t -f SSID device wifi list | grep -v '^$' | sort -u | rofi -dmenu -p "Select Wi-Fi")
        if [ -n "$SSID" ]; then
            # Demande le mot de passe
            PASSWORD=$(rofi -dmenu -p "Password for $SSID")
            nmcli device wifi connect "$SSID" password "$PASSWORD"
        fi
        ;;

    "Disconnect Wi-Fi")
        # Remplace wlan0 par ton interface réelle
        nmcli device disconnect wlan0
        ;;

    "Status")
        nmcli device status | rofi -dmenu -p "Status"
        ;;

    "Quit")
        exit 0
        ;;
esac

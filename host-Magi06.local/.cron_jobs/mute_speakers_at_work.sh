#!/bin/sh
export PATH=/usr/local/bin/:$PATH
alias echo='echo $(date): "$1"'

atWork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep "SSID: Shopify")
audioIsMuted=$(osascript -e "output muted of (get volume settings)")
currentAudioDevice=$(switchaudiosource -c -t output)

if [[ ! -z $atWork ]]; then
  echo "At work"
  if [[ $currentAudioDevice = "MacBook Pro Speakers" || $currentAudioDevice = "Display Audio" ]]; then
    if [[ $audioIsMuted = false ]]; then
      echo "Using speakings and volume is on. Mute."
      osascript -e "set volume with output muted"
      terminal-notifier -title 'Volume Muted' -message 'At work but no headphones connected.'
      else
        echo "Using speakers, but volume already muted"
    fi
  else
    echo "Not using Speakers. Don't Mute."
  fi
fi


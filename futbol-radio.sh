#!/bin/sh

# Rename the terminal
/bin/echo -ne '\033]0;Futbol\007'

exec mplayer -nocache -playlist http://www.rtve.es/rne/audio/reelive.asx

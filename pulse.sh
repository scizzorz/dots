#!/bin/bash

# CHANGES, RE-VIEWS/WRITES, IMPROVEMENTS:
# mhasko: functions; VOL-steps; 
# gashapon: autodectect default sink
# konrad: more reliable way to autodetect default sink

# get default sink name
SINK_NAME=$(pacmd dump | perl -a -n -e 'print $F[1] if /set-default-sink/')
SINK_BUILTIN="alsa_output.pci-0000_06_00.0.analog-stereo"
SINK_BOTH=combined
SINK_HEADSET="alsa_output.usb-Razer_Razer_Kraken_7.1_Chroma-00.analog-stereo"
#SINK_HEADSET="alsa_output.usb-Creative_Technology_Ltd._Sound_BlasterX_H7_00000675-00.analog-stereo"

MIN_PIX=12
MAX_PIX=36

case "$1" in
  builtin)
    SINK_NAME=$SINK_BUILTIN
    SINK_RGB='\x0\x7F\xFF'
  ;;
  headset)
    SINK_NAME=$SINK_HEADSET
    SINK_RGB='\xFF\x7F\x0'
  ;;
  both)
    SINK_NAME=$SINK_BOTH
    SINK_RGB='\xFF\x7F\xFF'
  ;;
esac

# set max allowed volume; 0x10000 = 100%
#                         0x08000 = 50%
#                         0x05555 = 33%
VOL_MAX="0x04000"

STEPS=$((MAX_PIX - MIN_PIX))
VOL_STEP=$((VOL_MAX / STEPS + 1))

VOL_NOW=`pacmd dump | grep -P "^set-sink-volume $SINK_NAME\s+" | perl -p -n -e 's/.+\s(.x.+)$/$1/'`
MUTE_STATE=`pacmd dump | grep -P "^set-sink-mute $SINK_NAME\s+" | perl -p -n -e 's/.+\s(yes|no)$/$1/'`

function plus() {
  VOL_NEW=$((VOL_NOW + VOL_STEP))
  if [ $VOL_NEW -gt $((VOL_MAX)) ]; then
    VOL_NEW=$((VOL_MAX))
  fi
  pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`

  # for the serial NeoPixel rings
  END_PIX=$((VOL_NEW * (MAX_PIX - MIN_PIX) / VOL_MAX + MIN_PIX))
  START_PIX_HEX=$(echo "obase=16; $MIN_PIX" | bc)
  END_PIX_HEX=$(echo "obase=16; $END_PIX" | bc)
  echo "$START_PIX_HEX to $END_PIX_HEX"
  echo -en '\x3\x5\x'$START_PIX_HEX'\x'$END_PIX_HEX$SINK_RGB'\x2\x4' > /dev/ttyACM*
}

function minus() {
  VOL_NEW=$((VOL_NOW - VOL_STEP))
  if [ $(($VOL_NEW)) -lt $((0x00000)) ]; then
    VOL_NEW=$((0x00000))
  fi
  pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`

  # for the serial NeoPixel rings
  END_PIX=$((VOL_NEW * (MAX_PIX - MIN_PIX) / VOL_MAX + MIN_PIX))
  START_PIX_HEX=$(echo "obase=16; $MIN_PIX" | bc)
  END_PIX_HEX=$(echo "obase=16; $END_PIX" | bc)
  echo "$START_PIX_HEX to $END_PIX_HEX"
  echo -en '\x3\x5\x'$START_PIX_HEX'\x'$END_PIX_HEX$SINK_RGB'\x2\x4' > /dev/ttyACM*
}

function mute() {
  if [ $MUTE_STATE = no ]; then
    pactl set-sink-mute $SINK_NAME 1
  elif [ $MUTE_STATE = yes ]; then
    pactl set-sink-mute $SINK_NAME 0
  fi
}

function get() {
  BAR=""
  if [ $MUTE_STATE = yes ]; then
    BAR="mute"
    ITERATOR=$((STEPS / 2 - 2))
    while [ $ITERATOR -gt 0 ]; do
      BAR=" ${BAR} "
      ITERATOR=$((ITERATOR - 1))
    done
  else
    DENOMINATOR=$((VOL_MAX / STEPS))
    LINES=$((VOL_NOW / DENOMINATOR))
    DOTS=$((STEPS - LINES))
    while [ $LINES -gt 0 ]; do
      BAR="${BAR}|"
      LINES=$((LINES - 1))
    done
    while [ $DOTS -gt 0 ]; do
      BAR="${BAR}."
      DOTS=$((DOTS - 1))
    done
  fi
  echo "$BAR"
}

case "$2" in
  plus)
    plus
  ;;
  minus)
    minus
  ;;
  mute)
    mute
  ;;
  get)
    get
esac

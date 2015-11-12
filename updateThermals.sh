#!/bin/sh
# Changes the Thermal Trip Zones for the ODROID XU4 fan
# Please adjust the values below. Be aware that wrong values here can
# either (a) prevent your ODROID from booting, or (b) damage it irreversible
# -- So please use at your own risk.
hex() {
  printf '%x' $1
}

# Default settings:
#FAN0=$(hex 0)
#TRIP0=$(hex  50000) FAN1=$(hex 130)
#TRIP1=$(hex  60000) FAN2=$(hex 170)
#TRIP2=$(hex  70000) FAN3=$(hex 230)
#TRIP3=$(hex 120000)

# Our Settings (insert values here:
# Temperature is in milli degrees celsius (1000 = 1 degree), fan speeds are from 0 to 255 (fan starts spinning at 50-ish)
FAN0=$(hex 0)
TRIP0=$(hex  60000) FAN1=$(hex  75)
TRIP1=$(hex  80000) FAN2=$(hex 170)
TRIP2=$(hex  90000) FAN3=$(hex 230)

for f in *.dtb; do
  echo "Modifying $f .."
  if [ ! -f ${f}.bak ]; then cp $f ${f}.bak; fi
  dtc -I dtb -O dts ${f}.bak \
    | sed "s/temperature = <0x11170>/temperature = <0x$TRIP2>/g" \
    | sed "s/temperature = <0xea60>/temperature = <0x$TRIP1>/g" \
    | sed "s/temperature = <0xc350>/temperature = <0x$TRIP0>/g" \
    | sed "s/cooling-levels = <0x0 0x82 0xaa 0xe6>/cooling-levels = <0x$FAN0 0x$FAN1 0x$FAN2 0x$FAN3>/g" \
    | dtc -I dts -O dtb -o ${f} -
done

## ODROID XU4 Thermal Trip Zones

With this script you can:

 * Change the temperate trip zones at which the kernel switches between different fan speeds.
 * Set the fan speed for each of the 4 trip zones.


### Note of caution

The script was tested on the experimental _Linux odroid 4.2.0-rc1-78_ kernel, and requires DeviceTree support. It *might* work on different versions too, but I cannot guarantee it.

Please be aware that **you are performing these changes at your own risk**. These changes happen at a very low level, and you are messing with the only safety net the XU4 has. Invalid settings might crash your ODROID, damage it irreversibly or cause it to burst up into flames. Be sure to know what you are doing.


### Why would you want this?
[tl;dr]: You can make the ODROID XU4 less noisy by causing the fan to start spinning up at a higher temperature and/or by having it constantly on (thus only creating a static sound, not the annoying spin up noise).


### How to use?

Run these commands in a shell:
```sh
sudo su
apt-get install device-tree-compiler
cd /boot/
wget https://raw.githubusercontent.com/thekroko/odroid-xu4-dtc-fan-speed/master/updateThermals.sh
nano updateThermals.sh # Edit Temperatures/Fan Speeds to your liking
chmod +x updateThermals.sh
./updateThermals.sh
```

The temperature trip zones (at which the next fan level is set), and the fan speeds can be changed by editing the shell script:

```sh
# Our Settings (edit values here!)
# Temperature is in milli degrees celsius (1000 = 1 degree), fan speeds are from 0 to 255 (fan starts spinning at 50-ish)
FAN0=$(hex 0)
TRIP0=$(hex  60000) FAN1=$(hex  75)
TRIP1=$(hex  80000) FAN2=$(hex 170)
TRIP2=$(hex  90000) FAN3=$(hex 230)
# </Our Settings>
```

i.e. "TRIP0" means that at 60 degrees celsius the fan will be powered on at 75/255 = ~30%.

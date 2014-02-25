BLELedController
================

Control an RGB Led with an iPad and TI's CC254x Bluetooth Low Energy chip. It uses the CC254x Timers for smooth PWM control.

Based on TI's Bluetooth Low Energy SDK version 1.4

Sample application: https://vimeo.com/87564587

### Contains:

* XCode project with iOS app to control the RGB Led
* IAR Workbench project with CC254x firmware.

### PIO's used on CC254x:

* RED: port 1 pin 1 (Timer 4) 
* GREEN: port 1 pin 4 (Timer 3) 
* BLUE: port 0 pin 3 (Timer 1)

### BLE UUIDs:

* Led Service: 3F29121C-FA01-000A-0001-000000000000 
* Led Characteristic: 3F29121C-FB01-000A-0001-000000000000

Characteristic value format:
6 bytes, representing: 
red target value, red speed, green target value, green speed, blue target value, blue speed. All values range from 0 - 255, where 0 target value is OFF and 255 full ON, and 0 speed is slow transition and 255 instant transition.
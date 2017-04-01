#!/usr/bin/env python2

import phue

LIGHTS = [5, 7, 8]
HUE = 70 * 65535 / 360
SAT = 64

bridge = phue.Bridge('192.168.86.101')
bridge.connect()

if bridge.get_light(5)['state']['on']:
	brightness = bridge.get_light(5)['state']['bri']
	if brightness < 127:
		bridge.set_light(LIGHTS, {'hue': HUE, 'sat': SAT, 'bri': 127})
	elif brightness < 254:
		bridge.set_light(LIGHTS, {'hue': HUE, 'sat': SAT, 'bri': 254})
	else:
		bridge.set_light(LIGHTS, {'hue': HUE, 'sat': SAT, 'bri': 0, 'on': False})
else:
	bridge.set_light(LIGHTS, {'hue': HUE, 'sat': SAT, 'bri': 0, 'on': True})

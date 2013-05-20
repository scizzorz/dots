#!/usr/bin/python
import sys
import colorsys
from subprocess import call

# convert an HSL value to a hex value
def hsl_to_hex(h, s, l):
	h = int(h) % 360
	r, g, b = colorsys.hls_to_rgb(h / 360.0, l / 100.0, s / 100.0)
	# why did they make these 6 triplets instead of 3?
	# I may never know.
	return "#%02x%02x%02x%02x%02x%02x" % (r * 255.0, r * 255.0, g * 255.0, g * 255.0, b * 255.0, b * 255.0)

# apply a setting using gconftool-2
def set_val(profile, key, _type, val):
	call(['gconftool-2', '--set', '/apps/gnome-terminal/profiles/%s/%s' % (profile, key), '--type', _type, val])

def main(profile):
	# used for black, brightblack, white, and brightwhite
	# the "base" colors
	base_hue = 190
	base_sat = 30
	base_lums = (20, 40, 60, 90)

	bg_hue = base_hue
	bg_sat = 20
	bg_lum = 10
	bg_alpha = 0.98

	red =      (355, 80, 70)
	green =    (90, 80, 65)
	blue =     (230, 80, 70)
	yellow =   (50, 80, 70)
	magenta =  (265, 80, 75)
	cyan =     (195, 75, 70)

	bred =     (15, 80, 70)
	bgreen =   (80, 76, 73)
	bblue =    (210, 80, 80)
	byellow =  (30, 70, 73)
	bmagenta = (320, 80, 75)
	bcyan =    (150, 75, 75)

	# used for the accent colors
	accents = (red, green, blue, yellow, magenta, cyan, bred, bgreen, bblue, byellow, bmagenta, bcyan)

	palette = ["#000000000000" for x in range(16)]

	# set the base colors
	palette[0] = hsl_to_hex(base_hue, base_sat, base_lums[0])
	palette[7] = hsl_to_hex(base_hue, base_sat, base_lums[2])
	palette[8] = hsl_to_hex(base_hue, base_sat, base_lums[1])
	palette[15] = hsl_to_hex(base_hue, base_sat, base_lums[3])

	# set each accent color
	for i in range(6):
		palette[1 + i] = hsl_to_hex(accents[i][0], accents[i][1], accents[i][2])
		palette[9 + i] = hsl_to_hex(accents[6 + i][0], accents[6 + i][1], accents[6 + i][2])

	# apply the settings
	set_val(profile, 'palette', 'string', ':'.join(palette))
	set_val(profile, 'foreground_color', 'string', palette[15])
	set_val(profile, 'background_color', 'string',hsl_to_hex(bg_hue, bg_sat, bg_lum))
	set_val(profile, 'background_darkness', 'float', '%.2f' % bg_alpha)

if __name__ == '__main__':
	if len(sys.argv) != 2:
		print "Usage: ./schemer.py <profile name>"
	else:
		main(sys.argv[1])

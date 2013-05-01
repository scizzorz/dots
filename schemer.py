#!/usr/bin/python
import sys
import colorsys
from subprocess import call

# convert an HSL value to a hex value
def hsl_to_hex(h, s, l):
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
	base_hue = 210
	base_sat = 10
	base_lums = (20, 60, 40, 90)

	# used for the accent colors
	accent_offset = 0
	accent_hues = (0, 120, 240, 60, 300, 150, 30, 150, 270, 90, 330, 210)
	accent_sat = 100
	accent_lum = 65

	palette = ["#000000000000" for x in range(16)]

	# set the base colors
	palette[0] = hsl_to_hex(base_hue, base_sat, base_lums[0])
	palette[7] = hsl_to_hex(base_hue, base_sat, base_lums[1])
	palette[8] = hsl_to_hex(base_hue, base_sat, base_lums[2])
	palette[15] = hsl_to_hex(base_hue, base_sat, base_lums[3])

	# set each accent color
	for i in range(6):
		palette[1 + i] = hsl_to_hex(accent_hues[i] + accent_offset, accent_sat, accent_lum)
		palette[9 + i] = hsl_to_hex(accent_hues[6 + i] + accent_offset, accent_sat, accent_lum)

	# apply the settings
	set_val(profile, 'palette', 'string', ':'.join(palette))
	set_val(profile, 'foreground_color', 'string', palette[15])
	set_val(profile, 'background_color', 'string', '#000000000000')
	set_val(profile, 'background_darkness', 'float', '0.90')

if __name__ == '__main__':
	if len(sys.argv) != 2:
		print "Usage: ./schemer.py <profile name>"
	else:
		main(sys.argv[1])

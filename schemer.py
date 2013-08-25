#!/usr/bin/python
import sys
import colorsys
from subprocess import call

# convert an HSL value to a hex value
def hsl_to_rgb(h, s, l):
	h = int(h) % 360
	r, g, b = colorsys.hls_to_rgb(h / 360.0, l / 100.0, s / 100.0)
	# why did they make these 6 triplets instead of 3?
	# I may never know.
	return (r * 255.0, g * 255.0, b * 255.0)

# convert an RGB tuple to a hex sixlet
def rgb_to_sixlet(rgb):
	return "#%02x%02x%02x%02x%02x%02x" % (rgb[0], rgb[0], rgb[1], rgb[1], rgb[2], rgb[2])

# convert an RGB tuple to a hex triplet
def rgb_to_triplet(rgb):
	return "#%02x%02x%02x" % rgb

# apply a setting using gconftool-2
def set_val(profile, key, _type, val):
	call(['gconftool-2', '--set', '/apps/gnome-terminal/profiles/%s/%s' % (profile, key), '--type', _type, val])

def main(profile):
	# used for black, brightblack, white, and brightwhite
	# the "base" colors
	base_hue = 210
	base_sat = 10
	base_lums = (20, 40, 60, 90)

	# used for the background color
	bg_hue = base_hue
	bg_sat = 10
	bg_lum = 10
	bg_alpha = 1.00

	# accents
	red =      (355, 80, 65)
	green =    (90, 80, 60)
	blue =     (230, 80, 65)
	yellow =   (50, 80, 65)
	magenta =  (265, 80, 70)
	cyan =     (195, 75, 65)

	# bright accents
	bred =     (15, 80, 65)
	bgreen =   (80, 76, 68)
	bblue =    (210, 80, 75)
	byellow =  (30, 70, 68)
	bmagenta = (320, 80, 70)
	bcyan =    (150, 75, 70)

	# initialize blank palette
	palette = [(0, 0, 0) for x in range(16)]


	# set the bg color
	bg = hsl_to_rgb(bg_hue, bg_sat, bg_lum)
	bg3 = rgb_to_triplet(bg)
	bg6 = rgb_to_sixlet(bg)

	# set the base colors
	palette[0] = hsl_to_rgb(base_hue, base_sat, base_lums[0])
	palette[7] = hsl_to_rgb(base_hue, base_sat, base_lums[2])
	palette[8] = hsl_to_rgb(base_hue, base_sat, base_lums[1])
	palette[15] = hsl_to_rgb(base_hue, base_sat, base_lums[3])

	# set accent colors
	palette[1] = hsl_to_rgb(*red)
	palette[2] = hsl_to_rgb(*green)
	palette[3] = hsl_to_rgb(*blue)
	palette[4] = hsl_to_rgb(*yellow)
	palette[5] = hsl_to_rgb(*magenta)
	palette[6] = hsl_to_rgb(*cyan)

	palette[9] = hsl_to_rgb(*bred)
	palette[10] = hsl_to_rgb(*bgreen)
	palette[11] = hsl_to_rgb(*bblue)
	palette[12] = hsl_to_rgb(*byellow)
	palette[13] = hsl_to_rgb(*bmagenta)
	palette[14] = hsl_to_rgb(*bcyan)

	palette3 = [rgb_to_triplet(x) for x in palette]
	palette6 = [rgb_to_sixlet(x) for x in palette]

	# apply the settings
	set_val(profile, 'palette', 'string', ':'.join(palette6))
	set_val(profile, 'foreground_color', 'string', palette6[15])
	set_val(profile, 'background_color', 'string', bg6)
	set_val(profile, 'background_darkness', 'float', '%.2f' % bg_alpha)

	# write them to the 'terminal-palette' file
	fd = open('terminal-palette', 'w')
	fd.write("%s\n" % palette3[15].upper())
	fd.write("%s\n" % bg3.upper())

	i = 0
	while i < 16:
		if i%4 == 0:
			fd.write("\n")
		fd.write("%s\n" % palette3[i].upper())
		i += 1

	fd.close()



if __name__ == '__main__':
	if len(sys.argv) != 2:
		print "Usage: ./schemer.py <profile name>"
	else:
		main(sys.argv[1])

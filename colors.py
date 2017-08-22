from math import sqrt

def hex2rgb(code):
  '''Convert a 6-digit hex code into an rgb triplet.'''

  r = int(code[0:2], 16)
  g = int(code[2:4], 16)
  b = int(code[4:6], 16)
  return r, g, b


def rgb2hex(r, g, b):
  '''Convert an rgb triplet into a 6-digit hex code.'''

  return '{:02x}{:02x}{:02x}'.format(r, g, b)


def hsl2rgb(h, s, l):
  '''Convert an hsl triplet into an rgb triplet.'''

  c = (1 - abs(2 * l - 1)) * s
  x = c * (1 - abs((h / 60) % 2 - 1))
  m = l - c/2

  if 0 <= h < 60:
    r, g, b = c, x, 0
  elif 60 <= h < 120:
    r, g, b = x, c, 0
  elif 120 <= h < 180:
    r, g, b = 0, c, x
  elif 180 <= h < 240:
    r, g, b = 0, x, c
  elif 240 <= h < 300:
    r, g, b = x, 0, c
  elif 300 <= h < 360:
    r, g, b = c, 0, x
  else:
    raise Exception('Weird HSL')

  return int((r + m) * 255), int((g + m) * 255), int((b + m) * 255)


def hsv2rgb(h, s, v):
  '''Convert an hsv triplet into an rgb triplet.'''

  c = v * s
  x = c * (1 - abs((h / 60) % 2 - 1))
  m = v - c

  if 0 <= h < 60:
    r, g, b = c, x, 0
  elif 60 <= h < 120:
    r, g, b = x, c, 0
  elif 120 <= h < 180:
    r, g, b = 0, c, x
  elif 180 <= h < 240:
    r, g, b = 0, x, c
  elif 240 <= h < 300:
    r, g, b = x, 0, c
  elif 300 <= h < 360:
    r, g, b = c, 0, x
  else:
    raise Exception('Weird HSL')

  return int((r + m) * 255), int((g + m) * 255), int((b + m) * 255)


def luminance(r, g, b):
  '''Compute perceived luminance of an rgb triplet.'''

  R = r / 255
  G = g / 255
  B = b / 255
  return sqrt(0.299 * R**2 + 0.587 * G**2 + 0.114 * B**2)


def hex_luminance(code):
  '''Compute perceived luminance of a 6-digit hex code.'''

  return luminance(*hex2rgb(code))


def find_shade(hue, lum, tol=0.01):
  '''Find a shade within a certain tolerance of a target luminance.'''

  for s in range(101):
    this_lum = luminance(*hsv2rgb(hue, s / 100, 1.0))
    if abs(this_lum - lum) < tol:
      return s / 100, 1.0

  for v in range(100, -1, -1):
    this_lum = luminance(*hsv2rgb(hue, 1.0, v / 100))
    if abs(this_lum - lum) < tol:
      return 1.0, v / 100

  raise Exception('Can\'t find a shade for: hue=' + str(hue) + ', lum=' + str(lum))


def find_grey(hue, lum, tol=0.01):
  '''Find a shade within a certain tolerance of a target luminance.'''

  s = 10
  for v in range(100, -1, -1):
    r, g, b = hsl2rgb(hue, s / 100, v / 100)
    this_lum = luminance(r, g, b)
    if abs(this_lum - lum) < tol:
      return r, g, b

  raise Exception('Can\'t find a grey for: hue=' + str(hue) + ', lum=' + str(lum))


# Scheme inputs
# TODO argparse this crap

light = False
ansi = True
hue_lum = 0.50
dark_hue = 210
light_hue = 150
grey_lums = [
  0.10,
  0.20,
  0.40,
  0.60,
  0.80,
  0.90,
]

hues = {
  'red': 355,
  'orange': 25,
  'yellow': 55,
  'lime': 85,
  'green': 145,
  'teal': 175,
  'cyan': 205,
  'blue': 235,
  'indigo': 260,
  'purple': 280,
  'magenta': 305,
  'pink': 330,
}

hues = {
  'red': 350,
  'orange': 30,
  'yellow': 60,
  'lime': 85,
  'green': 137,
  'teal': 170,
  'cyan': 200,
  'blue': 225,
  'indigo': 250,
  'purple': 275,
  'magenta': 300,
  'pink': 325,
}


# Scheme order

ansi_order = {
  'red': 'color1',
  'pink': 'color9',
  'green': 'color2',
  'lime': 'color10',
  'blue': 'color3',
  'indigo': 'color11',
  'yellow': 'color4',
  'orange': 'color12',
  'purple': 'color5',
  'magenta': 'color13',
  'cyan': 'color6',
  'teal': 'color14',
  'base0': 'background',
  'base1': 'color0',
  'base2': 'color8',
  'base3': 'color7',
  'base4': 'color15',
  'base5': 'foreground',
}

rainbow_order = {
  'base1':  'color0',
  'base2':  'color8',
  'base3':  'color1',
  'base4':  'color9',
  'red':    'color2',
  'orange': 'color10',
  'yellow': 'color3',
  'lime':   'color11',
  'green':  'color4',
  'teal':   'color12',
  'cyan':   'color5',
  'blue':   'color13',
  'indigo': 'color6',
  'purple': 'color14',
  'pink':   'color15',
  'magenta': 'color7',
  'base0': 'background',
  'base5': 'foreground',
}


# Computation

colors = {}
greys = []

color_order = ansi_order if ansi else rainbow_order

start_hue = light_hue if light else dark_hue
end_hue = dark_hue if light else light_hue

grey_lums = sorted(grey_lums, reverse=light)
min_lum = grey_lums[0]
lum_gap = grey_lums[5] - grey_lums[0]

# compute colors
for color, hue in hues.items():
  sat, val = find_shade(hue, hue_lum)
  colors[color] = rgb2hex(*hsv2rgb(hue, sat, val))

# compute greys
for i, grey_lum in enumerate(grey_lums):
  hue = start_hue + (end_hue - start_hue) * (grey_lum - min_lum) / lum_gap
  r, g, b = find_grey(hue, grey_lum)
  colors['base{}'.format(i)] = rgb2hex(r, g, b)

# dump colors in Xresources format
for color, index in sorted(color_order.items(), key=lambda x: x[1]):
  lum = hex_luminance(colors[color])
  print('! {} (lum = {:.3f})\n*{}: #{}'.format(color, lum, index, colors[color]))

# dirty trick relies on 'foreground' being the last lexicographic key
print('*{}: #{}'.format('cursorColor', colors[color]))

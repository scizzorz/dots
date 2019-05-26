from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
from math import sqrt
import click
import yaml

# This script is responsible for generating the color palette based on a few
# rules and configuration settings from colors.yml. It uses some formulas
# borrowed from the W3 for accessibility of colors:
#   relative luminance of an RGB color: https://www.w3.org/TR/WCAG20/#relativeluminancedef
#   contrast ratio of two colors: https://www.w3.org/TR/WCAG20/#contrast-ratiodef

# The basic gist is to generate a "black" and a "white" color with a desired
# hue and relative luminance. From there, it will generate two shades lighter
# than the black and two shades darker than the light using a constant contrast
# ratio.
#   ie: black:grey1 == grey1:grey2 == grey2:grey3 == grey3:grey4 == grey4:white
# The hues are slightly shifted as it progresses. Afterwards, it determines the
# midway luminance between the black and white.
#   ie: black:middle == middle:white
# This should provide consistent readability between the dark and light themes.
# Using the midway luminance and a list of user-provided hues, it finds the
# closest shade of that hue to the target luminance. The end result is a happy
# color scheme.


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
  m = l - c / 2

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

  def fix(v):
    Vb = v / 255
    return Vb / 12.92 if Vb <= 0.03928 else ((Vb + 0.055) / 1.055) ** 2.4

  R = fix(r)
  G = fix(g)
  B = fix(b)

  return 0.2126 * R + 0.7152 * G + 0.0722 * B


def rel_luminance(c1, c2):
  '''Compute the contrast ratio between two rgb triplets.'''

  l1 = luminance(*c1)
  l2 = luminance(*c2)
  ldark = min(l1, l2)
  llight = max(l1, l2)
  return (llight + 0.05) / (ldark + 0.05)


def lighten(lum, contrast):
  '''Compute a lighter luminance that matches the given contrast ratio.'''

  return contrast * (lum + 0.05) - 0.05


def midway(lo, hi):
  '''Compute the midway luminance between two points.'''

  return sqrt((lo + 0.05) * (hi + 0.05)) - 0.05


def darken(lum, contrast):
  '''Compute a darker luminance that matches the given contrast ratio.'''

  return (lum + 0.05) / contrast - 0.05


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


def find_grey(hue, lum):
  '''Find the grey that's closest to the target luminance.'''

  s = 10
  greys = []
  for v in range(100, -1, -1):
    r, g, b = hsl2rgb(hue, s / 100, v / 100)
    this_lum = luminance(r, g, b)
    greys.append({
      'lum_delta': abs(this_lum - lum),
      'rgb': (r, g, b),
    })

  greys = sorted(greys, key=lambda x: x['lum_delta'])
  return greys[0]['rgb']


def generate_simple_colors_image(greys, colors, size=32, padding=8, filename='colors-simple.png'):
  total_colors = len(colors) + len(greys)

  img = Image.new('RGB', (total_colors * size, size * 2), color='#' + greys[0])
  draw = ImageDraw.Draw(img)

  draw.rectangle((0, size, total_colors * size, size * 2), fill='#' + greys[-1])

  for i, hex in enumerate(greys):
    x = padding + size * i
    y = padding
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)

  for i, hex in enumerate(reversed(greys)):
    x = padding + size * i
    y = padding + size
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)

  for i, hex in enumerate(colors.values()):
    x = padding + size * (i + len(greys))
    y = padding
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)
    draw.rectangle((x, y + size, x + (size - padding * 2), y + size + (size - padding * 2)), fill='#' + hex)

  with open(filename, 'wb') as fp:
    img.save(fp, format='PNG')


def generate_labeled_colors_image(greys, colors, filename='colors-labeled.png'):
  total_colors = len(colors) + len(greys)

  size = 64
  padding = 16
  width = size * 9
  height = total_colors * size

  img = Image.new('RGB', (width, height), color='#' + greys[0])
  draw = ImageDraw.Draw(img)
  font = ImageFont.truetype('fonts/FiraMono.ttf', size // 4)

  draw.rectangle((width / 2, 0, width, height), fill='#' + greys[-1])

  for i, hex in enumerate(greys):
    # draw text in opposite color if it's the first shade
    text_color = greys[-1] if i == 0 else hex

    x = padding
    y = padding + i * size
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)
    draw.text((x + size - padding, y + padding / 2), f' shade {i}: #{hex}', font=font, fill='#' + text_color)

  for i, hex in enumerate(reversed(greys)):
    # draw text in opposite color if it's the first shade
    text_color = greys[0] if i == 0 else hex

    x = padding + width / 2
    y = padding + size * i
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)
    draw.text((x + size - padding, y + padding / 2), f' shade {i}: #{hex}', font=font, fill='#' + text_color)

  for i, (color, hex) in enumerate(colors.items()):
    x = padding
    y = padding + size * (i + len(greys))
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)
    draw.text((x + size - padding, y + padding / 2), f'{color:>8}: #{hex}', font=font, fill='#' + hex)

    x = padding + width / 2
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)
    draw.text((x + size - padding, y + padding / 2), f'{color:>8}: #{hex}', font=font, fill='#' + hex)

  with open(filename, 'wb') as fp:
    img.save(fp, format='PNG')


formats = {}


def add_format(fn):
  formats[fn.__name__] = fn
  return fn


@add_format
def text(config, greys, colors):
  # dump colors
  for color, hex in colors.items():
    print(f'{color:>8}: #{hex}')

  # dump greys
  for i, hex in enumerate(greys):
    print(f' shade {i}: #{hex}')


@add_format
def alacritty(config, greys, colors):
  map = config['ansi_map']
  output = {
    'colors': {
      'primary': {
        'background': greys[0],
        'foreground': greys[5],
      },
      'cursor': {
        'text': greys[0],
        'cursor': greys[5],
      },
      'normal': {
        'black': greys[1],
        'red': colors[map['red']],
        'green': colors[map['green']],
        'yellow': colors[map['yellow']],
        'blue': colors[map['blue']],
        'magenta': colors[map['magenta']],
        'cyan': colors[map['cyan']],
        'white': greys[3],
      },
      'bright': {
        'black': greys[2],
        'red': colors[map['br_red']],
        'green': colors[map['br_green']],
        'yellow': colors[map['br_yellow']],
        'blue': colors[map['br_blue']],
        'magenta': colors[map['br_magenta']],
        'cyan': colors[map['br_cyan']],
        'white': greys[4],
      },
    },
  }

  for section, colors in output['colors'].items():
    for name, color in colors.items():
      colors[name] = f'0x{color}'

  import sys
  yaml.dump(output, sys.stdout)


@add_format
def hterm(config, greys, colors):
  map = config['ansi_map']
  output = [
    greys[1],
    colors[map['red']],
    colors[map['green']],
    colors[map['yellow']],
    colors[map['blue']],
    colors[map['magenta']],
    colors[map['cyan']],
    greys[3],

    greys[2],
    colors[map['red']],
    colors[map['green']],
    colors[map['yellow']],
    colors[map['blue']],
    colors[map['magenta']],
    colors[map['cyan']],
    greys[4],
  ]

  output = ['#' + hex for hex in output]

  print(f'background: #{greys[0]}')
  print(f'cursor: #{greys[5]}')
  import json
  print(json.dumps(output, indent=2))


@click.command()
@click.argument('config', type=str, default='colors.yml')
@click.option('--mode', '-m', default='dark', type=click.Choice(('light', 'dark')))
@click.option('--format', '-f', default=list(formats)[0], type=click.Choice(formats))
def main(config, mode, format):
  with open(config) as fp:
    data = yaml.load(fp, Loader=yaml.FullLoader)

  # compute greys
  dark_hue = data['dark_hue']
  light_hue = data['light_hue']
  grey_contrast = data['grey_contrast']

  # compute grey luminance values
  min_lum = data['dark_lum']
  lv2_lum = lighten(min_lum, grey_contrast)
  lv3_lum = lighten(lv2_lum, grey_contrast)

  max_lum = data['light_lum']
  lv5_lum = darken(max_lum, grey_contrast)
  lv4_lum = darken(lv5_lum, grey_contrast)

  grey_lums = [min_lum, lv2_lum, lv3_lum, lv4_lum, lv5_lum, max_lum]

  # compute final grey colors
  greys = []
  for i, grey_lum in enumerate(grey_lums):

    # in the first half of greys, we want to base our result off of the dark_hue.
    # in the second half, we want to base our result off the light_hue.
    if i < len(grey_lums) / 2:
      # as we leave i=0, scale goes up and our hue should leave dark_hue
      hue = dark_hue - 10 * (grey_contrast ** i)
    else:
      # as we approach i=len, scale keeps going up and our hue should approach light_hue
      hue = light_hue + 10 * (grey_contrast ** (5 - i))

    r, g, b = find_grey(int(hue), grey_lum)
    greys.append(rgb2hex(r, g, b))

  # compute colors
  colors = {}
  color_lum = midway(min_lum, max_lum)
  for color, hue in data['color_hues'].items():
    sat, val = find_shade(hue, color_lum)
    colors[color] = rgb2hex(*hsv2rgb(hue, sat, val))

  if mode == 'light':
    greys = list(reversed(greys))

  formats[format](data, greys, colors)

  # generate images
  generate_simple_colors_image(greys, colors)
  generate_labeled_colors_image(greys, colors)


if __name__ == '__main__':
  main()

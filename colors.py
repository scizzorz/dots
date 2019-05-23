from math import sqrt
import math
import click
import PIL as pil
import yaml


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


@click.command()
@click.argument('config', type=str, default='colors.yml')
def main(config):
  with open(config) as fp:
    data = yaml.load(fp, Loader=yaml.FullLoader)

  if data['mode'] not in ('light', 'dark'):
    raise Exception('Invalid mode')

  colors = {}
  greys = []

  start_hue = data['light_hue'] if data['mode'] == 'light' else data['dark_hue']
  end_hue = data['dark_hue'] if data['mode'] == 'light' else data['light_hue']
  grey_lums = sorted(data['grey_lums'], reverse=data['mode'] == 'light')
  min_lum = grey_lums[0]
  lum_delta = grey_lums[-1] - grey_lums[0]

  # compute colors
  for color, hue in data['color_hues'].items():
    sat, val = find_shade(hue, data['color_lum'])
    colors[color] = rgb2hex(*hsv2rgb(hue, sat, val))

  # compute greys
  for i, grey_lum in enumerate(grey_lums):
    direction = math.copysign(1, end_hue - start_hue)

    if i < 3:
      hue = start_hue + direction * (10 + 10 * i) * (grey_lum - min_lum) / lum_delta
    else:
      hue = end_hue - direction * (50 - i * 10) * (grey_lum - min_lum) / lum_delta

    hue = int(hue)
    r, g, b = find_grey(hue, grey_lum)

    greys.append(rgb2hex(r, g, b))

  for color, hex in colors.items():
    print(f'{color:>8}: #{hex}')

  for i, hex in enumerate(greys):
    print(f' shade {i}: #{hex}')


if __name__ == '__main__':
  main()

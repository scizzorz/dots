from PIL import Image
from PIL import ImageDraw
from math import sqrt
import click
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
@click.option('--mode', '-m', default='dark', type=click.Choice(('light', 'dark')))
def main(config, mode):
  with open(config) as fp:
    data = yaml.load(fp, Loader=yaml.FullLoader)

  if len(data['grey_lums']) % 2 == 1:
    raise Exception('Not sure how to handle odd number of greys.')

  # compute colors
  colors = {}
  for color, hue in data['color_hues'].items():
    sat, val = find_shade(hue, data['color_lum'])
    colors[color] = rgb2hex(*hsv2rgb(hue, sat, val))

  # compute greys
  start_hue = data['light_hue'] if mode == 'light' else data['dark_hue']
  end_hue = data['dark_hue'] if mode == 'light' else data['light_hue']

  grey_lums = sorted(data['grey_lums'], reverse=mode == 'light')
  min_lum = grey_lums[0]
  max_lum = grey_lums[-1]

  # this is just arbitary based on my taste
  hue_chunk = (start_hue - end_hue) / len(grey_lums) / 2

  greys = []
  for i, grey_lum in enumerate(grey_lums):
    scale = (grey_lum - min_lum) / (max_lum - min_lum) * 2

    # in the first half of greys, we want to base our result off of the start_hue.
    # in the second half, we want to base our result off the end_hue.
    if i < len(grey_lums) / 2:
      # as we leave i=0, scale goes up and our hue should leave start_hue
      hue = start_hue - hue_chunk * scale
    else:
      # as we approach i=len, scale keeps going up and our hue should approach end_hue
      hue = end_hue + hue_chunk * (2 - scale)

    r, g, b = find_grey(int(hue), grey_lum)

    greys.append(rgb2hex(r, g, b))

  # dump colors
  for color, hex in colors.items():
    print(f'{color:>8}: #{hex}')

  # dump greys
  for i, hex in enumerate(greys):
    print(f' shade {i}: #{hex}')

  size = 32
  padding = 8
  total_colors = len(colors) + len(greys)

  img = Image.new('RGB', (total_colors * size, size), color='#' + greys[0])
  draw = ImageDraw.Draw(img)

  for i, hex in enumerate(greys):
    x = padding + size * i
    y = padding
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)

  for i, hex in enumerate(colors.values()):
    x = padding + size * (i + len(greys))
    y = padding
    draw.rectangle((x, y, x + (size - padding * 2), y + (size - padding * 2)), fill='#' + hex)

  with open('colors.png', 'wb') as fp:
    img.save(fp, format='PNG')


if __name__ == '__main__':
  main()

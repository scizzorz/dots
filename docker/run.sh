#!/bin/sh
docker run --rm -it \
  -v /home/john/.ssh/id_rsa:/home/john/.ssh/id_rsa \
  -v /home/john/.ssh/id_rsa.pub:/home/john/.ssh/id_rsa.pub \
  "$@" scizzorz/arch

#!/bin/bash
lsblk -lno MOUNTPOINT | grep "^\/" | sed -e 's/^.*$/\0${goto 60}$color2${fs_used_perc \0}%$color${goto 110}${fs_size \0}/g'

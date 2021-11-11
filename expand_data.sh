#!/bin/bash
# Autor: Mattia Tadini
# File: expand_data.sh
# Revision: 1.00
# Date 2021/11/10

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  d # delete partition
  3 # partition number 3
  n # new partition
  p # primary partition
  3 # partition number 3
    # default,start immediately after preceding partition (data)
    # default,all free space (data)  
  n # keep btrfs signature
  w # write change to partition table
EOF

partprobe -s

mount -a

btrfs filesystem resize max /srv/data/ 

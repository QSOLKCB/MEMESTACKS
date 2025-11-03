#!/usr/bin/env bash
# bootstrap: clone & run your MEMESTACKS fullstack
set -e
cd ~
if [ ! -d MEMESTACKS ]; then
  git clone https://github.com/QSOLKCB/MEMESTACKS.git
fi
cd MEMESTACKS
chmod +x fullstack.sh
./fullstack.sh

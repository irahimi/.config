#!/bin/zsh
time find /Volumes/External/Music -name '*.flac' | parallel -j16 'echo {}; /Applications/XLD.app/Contents/MacOS/XLD --cmdline -f alac -o "." {} && rm {};'

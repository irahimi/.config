#!/usr/bin/env bash
TITLE=`mpc -f "%artist%" | head -n1`
TEXT=`mpc -f '%album% - %title%' | head -n1`

#SEARCH_TERM=`mpc -f '%artist% %album%' | head -n1 | tr ' ' '+'`
#ALBUM_ART_URL=`curl -s "http://www.albumart.org/index.php?searchk=$SEARCH_TERM&itempage=1&newsearch=1&searchindex=Music" | python -c "import sys; from lxml.etree import parse, HTMLParser; print parse(sys.stdin, HTMLParser()).xpath('//div[@id=\'main_left\']/ul/li/div/a/img/@src')[0]" 2> /dev/null`

#terminal-notifier -message "$TEXT"  -title "$TITLE" -appIcon "${ALBUM_ART_URL}" -group 6600 > /dev/null
terminal-notifier -message "$TEXT"  -title "$TITLE" -group 6600 > /dev/null

#!/bin/sh
#set -x
cd "$(dirname "$0")"

# generate SVG charts from Prometheus data
./generate_charts.php

# replace markers with current values
./generate_kindle.php

# living room
# generate temperature1 graph as SVG
rrdtool graph t1.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia-y2-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000
# generate humidity1 graph as SVG
rrdtool graph h1.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia-y1-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000

# bed room
# generate temperature2 graph as SVG
rrdtool graph t2.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia2-y2-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000
# generate humidity2 graph as SVG
rrdtool graph h2.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia2-y1-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000

# guest room
# generate temperature3 graph as SVG
rrdtool graph t3.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/zero/zero-mijia4-y2-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000
# generate humidity3 graph as SVG
rrdtool graph h3.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/zero/zero-mijia4-y1-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000

# balcony
# generate temperature4 graph as SVG
rrdtool graph t4.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia3-y2-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000
# generate humidity4 graph as SVG
rrdtool graph h4.svg -a SVG --disable-rrdtool-tag --border 0 --slope-mode --start -3h DEF:val=/var/lib/munin/shuttle2/shuttle2-mijia3-y1-g.rrd:42:AVERAGE AREA:val#666666 LINE2:val#000000

# convert the SVG to PNG
rsvg-convert --background-color=white -o kindle.png kindle.svg
# crush & grayscale it
pngcrush -q -c 0 -ow kindle.png
# push it to web server's docroot
#cp -f kindle.png /var/www/kindle/
# mv should be atomic
mv -f kindle.png /var/www/kindle/

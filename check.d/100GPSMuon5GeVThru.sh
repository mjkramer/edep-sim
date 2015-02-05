#!/bin/sh

# Enable error trapping.
set -e

MACRO=`mktemp -t detsim.XXXXXXXXXX` || exit 1
cat >> $MACRO <<EOF
/dsim/control baseline 1.0
/dsim/validateGeometry
/dsim/update

/gps/verbose 0
/gps/particle mu-
/gps/energy 5 GeV
/gps/position 0.0 0.0 -50.0 cm
/gps/pos/type Plane
/gps/pos/shape Circle
/gps/pos/radius 2 cm
/gps/direction 0 0 1
/run/beamOn 10

EOF

OUTPUT=detsim-100GPSMuon5GeVThru

if [ -f $OUTPUT.root ]; then
    rm $OUTPUT.root
fi

DETSIM.exe -o $OUTPUT $MACRO 

rm $MACRO

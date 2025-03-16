$fa = 1;
$fs = 0.3;

D = 0.001;
t = 0.3333333333333;
rodRadius = 3.1;
wallThickness = 3;
cellWidth = 20;
chamberHeight = 80;
solenoidBottomScrewFromTop = 43;
solenoidBottomScrewDistance = 15;
solenoidScrewR = 1;
valveHeight = 5;
outputInnerR = 3;
outputOuterR = 4;
spuntikHeight = 10;
spuntikDiraHeight = 5;
spuntikDiraRadius = 1;
connectorHeight = 15;
konektorWidth = 28;
kabelyHeight = 2;
kabelyWidth = 12;
kabelyOffsetHeight = 10;
kabelyOffsetWidth = 2;

valveBigR = cellWidth / 2 - wallThickness / 2;

I = 3;
slack = 1.05;

translate([ 0, 0, 0 ]) intersection()
{
    difference()
    {
        cylinder(connectorHeight + D, outputOuterR, outputOuterR, false);
        cylinder(connectorHeight + 2 * D, outputInnerR, outputInnerR, false);
    }
    cylinder(connectorHeight + 2 * D, cellWidth / 2, outputInnerR + 0.5, false);
}

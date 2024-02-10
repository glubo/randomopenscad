$fa = 1;
$fs = 0.4;
D = 0.001;
t = 0.3333333333333;

smallOuterDia = 63.5;
smallOuterR = smallOuterDia / 2;
wallThickness = 2;
smallHeight = 50;

connectorHeight = 50;
bigZ = smallHeight + connectorHeight;
bigOuterDia = 126;
bigOuterR = bigOuterDia / 2;
bigInnerDia = 98;
bigInnerR = bigInnerDia / 2;
bigHeight = 14;

magnetR = 5;
magnetHeight = 10.4;
magnetWall = 0.6;
magnetMagicR = 112/2;

diff = smallOuterR - bigInnerR + wallThickness;



module small() {
  translate([diff, 0, 0])
    difference() {
      cylinder(smallHeight, smallOuterR + wallThickness, smallOuterR + wallThickness);
      translate([0, 0, -D])
        cylinder(smallHeight + 2 * D, smallOuterR, smallOuterR);
    }
}


module big() {
  translate([0, 0, bigZ-2*D])
    difference() {
      cylinder(bigHeight, bigOuterR, bigOuterR);
      translate([0, 0, -D])
        cylinder(bigHeight + 2 * D, bigInnerR, bigInnerR);
    }
}

module bigHoles() {
  translate([0, 0, bigZ-2*D + bigHeight - magnetHeight - magnetWall])
  union() {
  translate([magnetMagicR, 0, 0])
        cylinder(magnetHeight, magnetR, magnetR);
  translate([-magnetMagicR, 0, 0])
        cylinder(magnetHeight, magnetR, magnetR);
  translate([0, magnetMagicR, 0])
        cylinder(magnetHeight, magnetR, magnetR);
  translate([0, -magnetMagicR, 0])
        cylinder(magnetHeight, magnetR, magnetR);
  }
}

module connector() {
  translate([0, 0, smallHeight-D])
    difference() {
      union() {
        translate([diff, 0, 0])
          cylinder(connectorHeight, smallOuterR + wallThickness, smallOuterR + wallThickness);
        cylinder(connectorHeight, 1, bigOuterR);
      }
      translate([0, 0, -D])
        union() {
          translate([diff, 0, 0])
            cylinder(connectorHeight + 2 * D, smallOuterR, smallOuterR);
          cylinder(connectorHeight + 2 * D, 1, bigInnerR);
        }
    }
}

small();
connector();
difference() {
big();
bigHoles();
}

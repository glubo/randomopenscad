$fa = 1;
$fs = 0.4;
D = 0.001;
t = 0.3333333333333;
rodRadius = 1.5;
wallThickness = 3;
cellWidth = 12.5;
chamberHeight = 50;
valveHeight = 5;
outputInnerR = 3;
outputOuterR = 4;
spuntikHeight = 10;
connectorHeight = 15;
konektorWidth = 28;
I = 12;
slack = 1.05;

use <MCAD/boxes.scad>;


valveBigR = cellWidth / 2 - wallThickness / 2;


module ventyl() {
    difference() {
        cube([cellWidth, cellWidth, wallThickness], center = true);
        cylinder(h = wallThickness + D, r = rodRadius, center = true);
    }
    translate([0, 0, chamberHeight])
        difference() {
            translate([0, 0, valveHeight / 2])
                cube([cellWidth, cellWidth, valveHeight], center = true);
            cylinder(valveHeight + D, valveBigR, outputInnerR, false);
        };
    translate([0, 0, chamberHeight - wallThickness])
        difference() {
            translate([0, 0, wallThickness / 2])
                cube([cellWidth, cellWidth, wallThickness], center = true);
            cylinder(wallThickness + D, cellWidth / 2 + wallThickness / 2, valveBigR, false);
        };

    translate([0, 0, chamberHeight + valveHeight])
        intersection() {
            difference() {
                cylinder(connectorHeight + D, outputOuterR, outputOuterR, false);
                cylinder(connectorHeight + 2 * D, outputInnerR, outputInnerR, false);
            }
            cylinder(connectorHeight + 2 * D, cellWidth / 2, outputInnerR + 0.5, false);
        }

}


module octa(R, height) {
    intersection() {
        rotate([0, 0, 45])
            cube([R, R, height], center = true);
        translate([0, 0, 0])
            cube([R, R, height], center = true);

    }
}


module podpory() {
    module aaa() {
        octa(wallThickness, chamberHeight+wallThickness);
    }
    translate([-cellWidth / 2, -cellWidth / 2, chamberHeight / 2])
        aaa();
    translate([-cellWidth / 2, cellWidth / 2, chamberHeight / 2])
        aaa();
    translate([cellWidth / 2, -cellWidth / 2, chamberHeight / 2])
        aaa();
    translate([cellWidth / 2, cellWidth / 2, chamberHeight / 2])
        aaa();

}
module telo() {

    translate([cellWidth / 2, 0, chamberHeight / 2])
        cube([wallThickness, cellWidth, chamberHeight + wallThickness], center = true);
    translate([-cellWidth / 2, 0, chamberHeight / 2])
        cube([wallThickness, cellWidth, chamberHeight + wallThickness], center = true);
    translate([0, -cellWidth / 2, chamberHeight / 2])
        cube([cellWidth, wallThickness, chamberHeight + wallThickness], center = true);
    module stenaPred() {
        translate([0, cellWidth / 2, chamberHeight / 2])
            cube([cellWidth, wallThickness, chamberHeight + wallThickness], center = true);
    }

}

module spuntik() {
    diff = valveBigR - outputInnerR;
    spuntBigR = outputInnerR + (2 * t * diff);

    translate([0, 0, valveHeight * 2 * t - D])
        cylinder(valveHeight * t *2, spuntBigR, (outputInnerR + t * diff)*(0.84));
    difference() {
        cylinder(valveHeight * 2 * t, spuntBigR, spuntBigR);
        cylinder(valveHeight * t, rodRadius);
    }
    translate([0, 0, -spuntikHeight + D])
        difference() {
            translate([0, 0, spuntikHeight / 2])cube([spuntBigR * 2, spuntBigR * 2, spuntikHeight], center = true);

            cylinder(spuntikHeight + D, rodRadius);
        }
}

module stena() {
        cube([cellWidth * I, wallThickness, chamberHeight + wallThickness], center = true);
}

module zadnistena() {
    translate([cellWidth / 2 * (I - 1), -cellWidth / 2, chamberHeight / 2])
        stena();
}


module bocnice() {
    translate([cellWidth * (I - 0.5), 0, chamberHeight / 2])
        cube([wallThickness, cellWidth, chamberHeight + wallThickness], center = true);
    translate([cellWidth * (-0.5), 0, chamberHeight / 2])
        cube([wallThickness, cellWidth, chamberHeight + wallThickness], center = true);
}

module prepazky() {
        for (i = [1:I - 1]) {
            translate([cellWidth * (i-0.5), 0, chamberHeight*5/6.0 ])
                cube([wallThickness/3.0, cellWidth, chamberHeight/3.0], center = true);
        }
}

module botPredkus() {
    translate([cellWidth / 2 * (I - 1), cellWidth / 2, 0])
        cube([cellWidth * I, wallThickness, wallThickness], center = true);
}
module topPredkus() {
    difference() {
        translate([cellWidth / 2 * (I - 1), cellWidth / 2, chamberHeight])
            cube([cellWidth * I, wallThickness, wallThickness], center = true);
        for (i = [0:I - 1]) {
            translate([cellWidth * i, 0, chamberHeight - wallThickness])
                cylinder(wallThickness + D, cellWidth / 2 + wallThickness / 2, valveBigR, false);
        }
    }
}
module ventyly() {
    for (i = [0:I - 1]) {
        echo(i);
        translate([cellWidth * i, 0, 0])
            union() {
                ventyl();
                podpory();
            }
    }

    zadnistena();
    bocnice();
    prepazky();
    botPredkus();
    topPredkus();
}

module bublik() {
    rotate([-90, 0, 0,]) {
        translate([0, 0, 20 - D])
            intersection() {
                cylinder(2, 5, 5);
                cylinder(2, 5, 4.6);
            }
        cylinder(20, 5, 5);
    }
}

module konektor() {
    difference() {
        union() {
            translate([0, 0, 2.5])
                roundedBox([konektorWidth, konektorWidth, 5], 5, true);
            translate([0, 0, wallThickness])
                roundedBox([konektorWidth + wallThickness, konektorWidth + wallThickness, wallThickness], 5, true);

            translate([0, 0, wallThickness*1.5])
                intersection() {
                    roundedBox([konektorWidth + wallThickness, konektorWidth + wallThickness, wallThickness*2], 5, true);
                    roundedBox([konektorWidth + wallThickness, konektorWidth + wallThickness, wallThickness*2], wallThickness, false);
                }
            translate([0, 0, konektorWidth / 2])
                roundedBox([konektorWidth, konektorWidth, konektorWidth], 5, false);
            translate([0, 10, 18])
                bublik();
        };
        translate([0, 0, 10])
            roundedBox([konektorWidth - wallThickness, konektorWidth - wallThickness, konektorWidth], 5, true);
        translate([0, 10, 18])
                cylinder(30, 4, 4);

    }
}

module prikryvkaMinus() {
    for (i = [0:I ]) {
        echo(i);
        translate([cellWidth * i, 0, 0])
            union() {
                translate([-cellWidth / 2, 0, 0])
                octa(wallThickness*slack, chamberHeight+D);
            }
    };
    translate([cellWidth / 2 * (I - 1), 0, chamberHeight*0.5])
        cube([cellWidth * I+D, wallThickness, wallThickness*slack], center = true);
    translate([cellWidth / 2 * (I - 1), 0, chamberHeight*-0.5])
        cube([cellWidth * I +D, wallThickness, wallThickness*slack], center = true);
    translate([konektorWidth*0.5, -wallThickness*0.5, 0])
        rotate([-90, 0, 0])
            roundedBox([konektorWidth+0.05, konektorWidth+0.05, wallThickness  *2], 5, true);
}

module prikryvka() {
    difference() {
        translate([cellWidth / 2 * (I - 1), 0, 0])
            stena();

        translate([0,wallThickness *0.5,0])
            prikryvkaMinus();
    }
}

//spuntik();
//ventyly();
//konektor();

prikryvka();

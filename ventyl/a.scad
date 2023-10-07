$fa = 1;
$fs = 0.4;
D = 0.001;
t = 0.3333333333333;
rodRadius = 1.5;
wallThickness = 3;
cellWidth = 12.5;
chamberHeight= 50;
valveHeight = 5;
outputInnerR = 3;
outputOuterR = 4;
spuntikHeight = 10;
connectorHeight = 15;


valveBigR = cellWidth/2-wallThickness/2;

module telo () {
difference() {
    cube([cellWidth,cellWidth, wallThickness], center=true);
    cylinder(h=wallThickness+D, r=rodRadius, center=true);
}

translate([cellWidth/2,0,chamberHeight/2])
cube([wallThickness, cellWidth, chamberHeight+wallThickness], center=true);
translate([-cellWidth/2,0,chamberHeight/2])
cube([wallThickness, cellWidth, chamberHeight+wallThickness], center=true);
translate([0,-cellWidth/2,chamberHeight/2])
cube([cellWidth, wallThickness,  chamberHeight+wallThickness], center=true);
module stenaPred() {
  translate([0,cellWidth/2,chamberHeight/2])
  cube([cellWidth, wallThickness,  chamberHeight+wallThickness], center=true);
}
translate([0,0,chamberHeight])
difference() {
    translate([0,0,valveHeight/2])
     cube([cellWidth,cellWidth, valveHeight], center=true);
    cylinder(  valveHeight+D,    valveBigR,    outputInnerR,        false);
};

translate([0,0,chamberHeight-wallThickness])
difference() {
    translate([0,0,wallThickness/2])
     cube([cellWidth,cellWidth, wallThickness], center=true);
    cylinder(  wallThickness+D,        cellWidth/2 + wallThickness/2,  valveBigR,      false);
};

translate([-cellWidth/2,-cellWidth/2,chamberHeight/2])
cube([wallThickness, wallThickness, chamberHeight+wallThickness], center=true);

translate([cellWidth/2,-cellWidth/2,chamberHeight/2])
cube([wallThickness, wallThickness, chamberHeight+wallThickness], center=true);


translate([0,0,chamberHeight+valveHeight])
intersection() {
  difference() {
    cylinder(  connectorHeight+D, outputOuterR,outputOuterR,        false);
    cylinder(  connectorHeight+2*D, outputInnerR,outputInnerR,        false);
  }
    cylinder(  connectorHeight+2*D, cellWidth/2,outputInnerR+0.5,        false);
}

}

module spuntik() {
    diff = valveBigR - outputInnerR;
    spuntBigR = outputInnerR + (2*t* diff);
    
    translate([0,0,valveHeight*2*t-D])
      cylinder(valveHeight*t, spuntBigR , outputInnerR + t* diff);
    difference() {
        cylinder(valveHeight*2*t, spuntBigR, spuntBigR);
        cylinder(valveHeight*t, rodRadius);
    }
    translate([0,0,-spuntikHeight + D])
    difference() {
        translate([0,0, spuntikHeight/2])cube([spuntBigR*2, spuntBigR*2, spuntikHeight], center=true);
        
        cylinder(spuntikHeight+D, rodRadius);
    }
}


telo();
//spuntik();
$fa = 1;
$fs = 0.4;
D = 0.001;

magnetDia = 10;
magnetR = magnetDia * 0.5;
magnetHeight = 10.4;
wallThickness = 1.2;
botThickness = 0.4;
gapWidth = 10;

wholeHeight = magnetHeight + wallThickness * 2;
bigR = magnetR + wallThickness;


module body() {
	cylinder(wholeHeight, bigR, bigR);
	translate([gapWidth+bigR*2,0,0])
		cylinder(wholeHeight, bigR, bigR);
	translate([0,-bigR,0])
		cube([gapWidth+bigR*2,bigR*2,wholeHeight]);
}


difference() {
	body();
	translate([0,0,botThickness])
		cylinder(magnetHeight, magnetR, magnetR);
	translate([gapWidth+bigR*2,0,botThickness])
		cylinder(magnetHeight, magnetR, magnetR);
	translate([bigR,-bigR-D,wholeHeight*0.4])
		cube([gapWidth,bigR*2+2*D,wholeHeight*0.2]);
		
}

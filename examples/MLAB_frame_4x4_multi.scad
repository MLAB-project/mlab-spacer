$fn=40;
include<../src/MLAB_frame.scad>

sx = 4;
sy = 4;

rowx = 4;
rowy = 4;

%translate([0, 0, -0.1]) square(150);

for(x = [0:rowx-1], y=[0:rowy-1])
    translate([MLAB_grid*sx*x, MLAB_grid*sy*y, 0])
        render()
	        mlab_frame(sx,sy);

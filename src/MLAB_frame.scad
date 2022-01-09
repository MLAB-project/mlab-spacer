MLAB_grid = 10.16;

module mlab_frame(x, y, pedestal_height = 9, grid_en = -1){

x_holes = x;
y_holes = y;
//pedestal_height = 9;   // designed for use the MLAB standard 20mm screws.

MLAB_grid = 10.16;
thickness = 1;          // thickness of bottom belt
pile_radius = 4;        // radius of pile around screw
x_size = x_holes * MLAB_grid ;
y_size = y_holes * MLAB_grid ;
mount_hole = 3.5;
nut_size = 6.55;
clear = 0.175;


MLAB_grid_xoffset = MLAB_grid/2;
MLAB_grid_yoffset = MLAB_grid/2;

grid_list = [for (j = [MLAB_grid_xoffset : MLAB_grid: x_size], i = [MLAB_grid_yoffset :MLAB_grid: y_size]) 
if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) ) [j, i] ];


difference () {
    union () {
        for (j = grid_list) {
            translate (concat(j, [0]))
            cylinder (h = pedestal_height, r= pile_radius, $fn=30);
        }

            translate ([MLAB_grid_xoffset , MLAB_grid_yoffset , 0])
                minkowski() {
                cube([x_size - 2*(MLAB_grid/2 - pile_radius) - 2*pile_radius, y_size - 2*(MLAB_grid/2 - pile_radius) - 2*pile_radius, thickness]);          // base plastics brick
                cylinder(r=pile_radius,h=0.1);
            }
    }
    
    translate ([2*pile_radius, 2*pile_radius, -thickness/2]) // central hole in module support
        cube([x_size-4*pile_radius, y_size-4*pile_radius, 3*thickness]);          

    // MLAB grid holes
    for (j = grid_list) {
            translate (concat(j, [0]))
                cylinder (h = 3, r= (nut_size+clear)/2, $fn=6);
            // zahloubeni
            translate (concat(j, [0]))
                translate([0, 0, -0.1]) cylinder (h = 0.5, r1= (nut_size+clear)/2+0.5, r2= (nut_size+clear)/2, $fn=6);
            translate (concat(j, [3.2]))  // one solid layer for slicer (the holes will be pierced on demand )
                cylinder (h = pedestal_height, r= mount_hole/2, $fn=20);
    }    
}


    if((grid_en == -1 && (x > 5 || y > 5)) || (grid_en == 1)){
        for(xp = [1:x-2]){
            translate([(xp+0.5)*MLAB_grid, MLAB_grid*0.5, 0]) cube([1, (y-1)*MLAB_grid, thickness]);
        }
        for(yp = [1:y-2]){
            translate([MLAB_grid*0.5, (yp+0.5)*MLAB_grid, 0]) cube([(x-1)*MLAB_grid, 1, thickness]);
        }
    }
}



//mlab_frame(7, 5);



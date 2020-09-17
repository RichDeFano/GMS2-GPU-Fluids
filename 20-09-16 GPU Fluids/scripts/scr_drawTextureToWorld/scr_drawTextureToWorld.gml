//var tex;
var debugString = argument0;
var surf_input = argument1;
surface_set_target(surf_world);
	draw_surface(surf_input,0,0);
	draw_text(0,0,debugString);
surface_reset_target();

draw_surface(surf_world,0,0);
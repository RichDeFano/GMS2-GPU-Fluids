/// @description Insert description here
// You can write your code in this editor
var mouse_x_relative = (mouse_x / room_w) * wScale;
var mouse_y_relative = (mouse_y / room_h) * hScale;



surface_set_target(surf_velocity);
var color = c_red;///make_color_rgb(ceil((clamp(((mouse_x - mouse_x_previous) * 0.35), -1, 1) * 0.125 + 0.5) * 255), ceil((clamp(((mouse_y - mouse_y_previous) * 0.35), -1, 1) * 0.125 + 0.5) * 255), 0);
draw_sprite_ext(spr_grad, 0, mouse_x, mouse_y, 1,1, 0, color, 1);



/// @description Insert description here
// You can write your code in this editor
draw_self();
draw_sprite_part(sprite_index,1,0,0,sprite_width*value, sprite_height,x,y-sprite_get_yoffset(sprite_index));
draw_sprite(spr_sliderButton,0,x+sprite_width*value,y);
//draw_circle(button_x,button_y,button_rad,true);
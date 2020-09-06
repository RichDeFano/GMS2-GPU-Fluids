/// @description Insert description here
// You can write your code in this editor
if !(mouse_check_button(mb_left)){
	selected = false;
}
else
{
	button_x = x+sprite_width*value;
    button_y = y;//+sprite_width*value;
	button_rad = sprite_get_width(spr_sliderButton);
	
	if (point_in_circle(mouse_x,mouse_y,button_x,button_y,button_rad))
	{selected = true;}

		
}

if (selected == true){
	value = clamp((mouse_x-x)/sprite_width,0.0,1.0);
}
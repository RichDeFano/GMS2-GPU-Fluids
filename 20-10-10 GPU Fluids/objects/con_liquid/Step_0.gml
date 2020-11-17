/// @description Insert description here
// You can write your code in this editor



if (keyboard_check_released(ord("Q")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.DENSITY;
	scr_resetWorld();
}

if (keyboard_check_released(ord("W")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.VELOCITY;
	scr_resetWorld();
}

if (keyboard_check_released(ord("E")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.DIVERGENCE;
	scr_resetWorld();
}

if (keyboard_check_released(ord("R")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.PRESSURE;
	scr_resetWorld();
}

if (keyboard_check_released(ord("T")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.VORTICITY;
	scr_resetWorld();
}

if (keyboard_check_released(ord("Y")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.DIFFUSION;
	scr_resetWorld();
}

if (keyboard_check_released(ord("U")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.TEMPERATURE;
	scr_resetWorld();
}

if (keyboard_check_released(ord("I")))
{
	DISPLAY_FIELD = DISPLAY_FIELD.WORLD;
	scr_resetWorld();
}


if (mouse_check_button(mb_any)){
	mousePressed = true;
	//stepTime += 1;
}
else
{
	mousePressed = false;
	}
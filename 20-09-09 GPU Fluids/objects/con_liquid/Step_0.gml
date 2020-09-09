/// @description Insert description here
// You can write your code in this editor



if (keyboard_check_released(ord("Q")))
{DISPLAY_FIELD = DISPLAY_FIELD.DENSITY;}

if (keyboard_check_released(ord("W")))
{DISPLAY_FIELD = DISPLAY_FIELD.VELOCITY;}

if (keyboard_check_released(ord("E")))
{DISPLAY_FIELD = DISPLAY_FIELD.DIVERGENCE;}

if (keyboard_check_released(ord("R")))
{DISPLAY_FIELD = DISPLAY_FIELD.PRESSURE;}

if (keyboard_check_released(ord("T")))
{DISPLAY_FIELD = DISPLAY_FIELD.VORTICITY;}

if (keyboard_check_released(ord("Y")))
{DISPLAY_FIELD = DISPLAY_FIELD.DIFFUSION;}

if (keyboard_check_released(ord("U")))
{DISPLAY_FIELD = DISPLAY_FIELD.TEMPERATURE;}


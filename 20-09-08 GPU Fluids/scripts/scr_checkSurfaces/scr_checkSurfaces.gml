



if (!surface_exists(surf_velocity))
{
surf_velocity = surface_create(room_w,room_h);
surface_set_target(surf_velocity);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_tempVelocity))
{
surf_tempVelocity = surface_create(room_w,room_h);
surface_set_target(surf_tempVelocity);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_density))
{
surf_density = surface_create(room_w,room_h);
surface_set_target(surf_density);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_tempDensity))
{
surf_tempDensity = surface_create(room_w,room_h);
surface_set_target(surf_tempDensity);
draw_clear_alpha(c_black,0);
surface_reset_target();
}
//Viscous Diffusion
if (!surface_exists(surf_diffusion))
{
surf_diffusion = surface_create(room_w,room_h);
surface_set_target(surf_diffusion);
draw_clear_alpha(c_black,0);
surface_reset_target();
}
if (!surface_exists(surf_tempDiffusion))
{
surf_tempDiffusion = surface_create(room_w, room_h);
surface_set_target(surf_tempDiffusion);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

//Jacobi 
if (!surface_exists(surf_pressure))
{
surf_pressure = surface_create(room_w,room_h);
surface_set_target(surf_pressure);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_tempPressure))
{
surf_tempPressure = surface_create(room_w,room_h);
surface_set_target(surf_tempPressure);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_divergence))
{
surf_divergence = surface_create(room_w,room_h);
surface_set_target(surf_divergence);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_tempDivergence))
{
surf_tempDivergence = surface_create(room_w,room_h);
surface_set_target(surf_tempDivergence);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

//Vorticity
if (!surface_exists(surf_tempVorticity))
{
surf_tempVorticity = surface_create(room_w,room_h);
surface_set_target(surf_tempVorticity);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_vorticity))
{
surf_vorticity = surface_create(room_w,room_h);
surface_set_target(surf_vorticity);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

//temperature
if (!surface_exists(surf_tempTemperature))
{
surf_tempTemperature = surface_create(room_w,room_h);
surface_set_target(surf_tempTemperature);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

if (!surface_exists(surf_temperature))
{
surf_temperature = surface_create(room_w,room_h);
surface_set_target(surf_temperature);
draw_clear_alpha(c_black,0);
surface_reset_target();
}

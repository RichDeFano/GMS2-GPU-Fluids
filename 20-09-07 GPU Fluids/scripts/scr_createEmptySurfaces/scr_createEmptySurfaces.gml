surf_velocity = surface_create(room_width,room_height);
surface_set_target(surf_velocity);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempVelocity = surface_create(room_width,room_height);
surface_set_target(surf_tempVelocity);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_density = surface_create(room_width,room_height);
surface_set_target(surf_density);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempDensity = surface_create(room_width,room_height);
surface_set_target(surf_tempDensity);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_pressure = surface_create(room_width,room_height);
surface_set_target(surf_pressure);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempPressure = surface_create(room_width,room_height);
surface_set_target(surf_tempPressure);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_diffusion = surface_create(room_width,room_height);
surface_set_target(surf_diffusion);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempDiffusion = surface_create(room_width,room_height);
surface_set_target(surf_tempDiffusion);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_divergence = surface_create(room_width,room_height);
surface_set_target(surf_divergence);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempDivergence = surface_create(room_width,room_height);
surface_set_target(surf_tempDivergence);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_vorticity = surface_create(room_width,room_height);
surface_set_target(surf_vorticity);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempVorticity = surface_create(room_width,room_height);
surface_set_target(surf_tempVorticity);
draw_clear_alpha(c_black,0);
surface_reset_target();

surf_temperature = surface_create(room_width,room_height);
surface_set_target(surf_temperature);
draw_clear_alpha(c_black,0);
surface_reset_target();
surf_tempTemperature = surface_create(room_width,room_height);
surface_set_target(surf_tempTemperature);
draw_clear_alpha(c_black,0);
surface_reset_target();

tempStorage = surface_create(room_width,room_height);
surface_set_target(tempStorage);
draw_clear_alpha(c_black,0);
surface_reset_target();


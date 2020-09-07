/// @description Insert description here
// You can write your code in this editor
//gpu_set_blendmode(bm_add);

//scr_checkSurfaces();



//if (mousePressed == true){
	//splat the ink by updating the density field
	
	scr_NavierStokes();

	
	draw_surface(surf_density,0,0);	
	surface_copy(tempStorage,0,0,surf_density);
		surface_copy(surf_density,0,0,surf_tempDensity);
		surface_copy(surf_tempDensity,0,0,tempStorage);
if (mousePressed == true){
//Fluid
//gpu_set_blendmode_ext(bm_one,bm_one);

	surface_set_target(surf_tempDensity);
		shader_set(shd_gaussianSplat)
//			draw_set_blend_mode_ext(bm_one, bm_one);
			shader_set_uniform_f(pt,mouse_x,mouse_y);
			shader_set_uniform_f(r,48.0);
			shader_set_uniform_f(fC,255.0,255.0,255.0);
			texture_set_stage(shader_get_sampler_index(shd_gaussianSplat,"scalar_field"),surface_get_texture(surf_density));
				draw_surface(surf_density,0,0);		
		shader_reset();
	surface_reset_target();
		surface_copy(tempStorage,0,0,surf_density);
		surface_copy(surf_density,0,0,surf_tempDensity);
		surface_copy(surf_tempDensity,0,0,tempStorage);

//Velocity
//gpu_set_blendmode
	surface_set_target(surf_tempVelocity);
		shader_set(shd_splat);
			shader_set_uniform_f(vpt,mouse_x,mouse_y);
			shader_set_uniform_f(vr,48.0);
			shader_set_uniform_f(vfC,255.0,255.0,255.0);
			texture_set_stage(shader_get_sampler_index(shd_splat,"vector_field"),surface_get_texture(surf_velocity));
				draw_surface(surf_velocity,0,0);
		shader_reset();
	surface_reset_target();
	
		surface_copy(tempStorage,0,0,surf_velocity);
		surface_copy(surf_velocity,0,0,surf_tempVelocity);
		surface_copy(surf_tempVelocity,0,0,tempStorage);
	//stepTime++;
	
//Velocity boundaries
	surface_set_target(surf_tempVelocity);
		shader_set(shd_boundary);
			texture_set_stage(shader_get_sampler_index(shd_boundary,"vector_field"),surface_get_texture(surf_velocity));
			shader_set_uniform_f(boundH,1.0);
			shader_set_uniform_f(boundW,1.0);
				draw_surface(surf_velocity,0,0);
		shader_reset();
	surface_reset_target();
		surface_copy(tempStorage,0,0,surf_velocity);
		surface_copy(surf_velocity,0,0,surf_tempVelocity);
		surface_copy(surf_tempVelocity,0,0,tempStorage);
	
		//stepTime++;
}
/*
else
{
	scr_NavierStokes();
	
stepTime++;
	
}
//scr_NavierStokes()
/*
                // Splat the ink onto the screen by updating density field
                gaussianSplat(density.read, density.write, xpos, ypos, INK_SPLAT_SIZE, r, g, b);
                swapVectorFields(&density);

                // Also make the fluid move with the ink just added by updating velocity field in the same way
                splat(velocity.read, velocity.write, xpos, ypos, VELOCITY_SPLAT_SIZE, tipVelocity.x * 4, tipVelocity.y * 4, 0);
                swapVectorFields(&velocity);
*/







//////////////////////////////////////////////
//subtractGradient(velocity.read, pressure.read, velocity.write, SCALE);
    //swapVectorFields(&velocity);
				
				
/*
	 // Enforce boundary conditions on the pressure field
    checkBoundary(pressure.read, pressure.write, width, height, false);
    swapVectorFields(&pressure);
    // Subtract pressure gradient from the velocity field
    subtractGradient(velocity.read, pressure.read, velocity.write, SCALE);
    swapVectorFields(&velocity);

    // --- Finally, enforce boundary conditions on the velocity field ---
    checkBoundary(velocity.read, velocity.write, width, height, true);
    swapVectorFields(&velocity);
*/
				
//surface_set_target(application_surface);

/*
add velocity 
with (argument0) {
            surface_set_target(sf_velocity_temporary);
            draw_enable_alphablend(false);
            draw_surface(sf_velocity, 0, 0);
            shader_set(sh_fd_add_velocity_glsl);
            shader_set_uniform_f(shader_get_uniform(sh_fd_add_velocity_glsl, "addend"), 0.5 + 0.5 * sf_velocity_texel_width, 0.5 + 0.5 * sf_velocity_texel_height);
            texture_set_stage(shader_get_sampler_index(sh_fd_add_velocity_glsl, "texture_velocity"), surface_get_texture(sf_velocity));
        var color = make_color_rgb(ceil((clamp(argument7, -1, 1) * 0.125 + 0.5) * 255), ceil((clamp(argument8, -1, 1) * 0.125 + 0.5) * 255), 0);
        draw_sprite_ext(argument1, argument2, argument3, argument4, argument5, argument6, 0, color, 1);
    fd_rectangle_reset_target(id);
}


replace material
with (argument0) {
    surface_set_target(sf_velocity);
     draw_sprite_ext(argument1, argument2, argument3, argument4, argument5, argument6, 0, argument7, argument8);
    fd_rectangle_reset_target(id);
}




///
Advect
viscous diffusion
	// Calculates divergence of velocity.
            surface_set_target(surf_pressure);
                shader_set(shd_divergence);
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_velocity_divergence_glsl, "initial_value_pressure"), initial_value_pressure);
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_velocity_divergence_glsl, "texel_size"), sf_velocity_texel_width, sf_velocity_texel_height);
                    draw_surface_stretched(surf_velocity, 0, 0, room_W, room_h);
                shader_reset();
            surface_reset_target();
			
			shader_set(shd_pressureJacobi);
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_pressure_jacobi_glsl, "texel_size"), sf_pressure_texel_width, sf_pressure_texel_height);
                    for(var i=0;i<jacobiIterations;i++) {
                        surface_set_target(sf_pressure_temporary);
                            draw_surface(sf_pressure, 0, 0);
                        surface_reset_target();
                        temporary = sf_pressure; sf_pressure = sf_pressure_temporary; sf_pressure_temporary = temporary;
                    }
                shader_reset();
// Calculates the gradient of pressure and subtracts it from the velocity.
            surface_set_target(surf_tempVelocity);
			draw_surface(surf_velocity)
			
XX	
	// --- Advection ---
    advect(velocity.read, velocity.read, velocity.write, width, height, SCALE, TIMESTEP, VELOCITY_DISSIPATION);
    swapVectorFields(&velocity);

    // --- Advection of the ink or fluid injected ---
    advect(velocity.read, density.read, density.write, width, height, SCALE, TIMESTEP, DISSIPATION);
    swapVectorFields(&density);
XX
    // --- Diffusion ---
    // Make a copy of the velocity field and put it into diffusion field.
    fillVectorField(diffusion.read, 0);
    addFields(diffusion.read, velocity.read, diffusion.write, 1.0, 1.0);
    swapVectorFields(&diffusion);

    // Jacobi iterations to estimate diffusion field
    for (int i = 0; i < NUM_JACOBI_ITERATIONS; i++) {
      computeJacobi(diffusion.read, diffusion.read, diffusion.write, 1.0, 5.0);
      swapVectorFields(&diffusion);
    }

    // Add back into velocity field with VISCOSITY scalar
    addFields(velocity.read, diffusion.read, velocity.write, 1.0, VISCOSITY);
    swapVectorFields(&velocity);

    // --- Vorticity confinement ---
    computeVorticity(velocity.read, vorticity.read, width, height, SCALE);
    computeVorticityForce(velocity.read, vorticity.read, velocity.write, width, height, SCALE, TIMESTEP, EPSILON, CURL, CURL);
    swapVectorFields(&velocity);

    // --- Projection operator (account for change in fluid velocity due to fluid pressure) ---
    // Compute divergence of velocity field
    computeDivergence(velocity.read, divergence.read, SCALE);
    // Jacobi iterations to estimate pressure field
    fillVectorField(pressure.read, 0);
    for (int i = 0; i < NUM_JACOBI_ITERATIONS; i++) {
        computeJacobi(pressure.read, divergence.read, pressure.write, -1.0, 4.0);
        swapVectorFields(&pressure);
    }
    // Enforce boundary conditions on the pressure field
    checkBoundary(pressure.read, pressure.write, width, height, false);
    swapVectorFields(&pressure);
    // Subtract pressure gradient from the velocity field
    subtractGradient(velocity.read, pressure.read, velocity.write, SCALE);
    swapVectorFields(&velocity);

    // --- Finally, enforce boundary conditions on the velocity field ---
    checkBoundary(velocity.read, velocity.write, width, height, true);
    swapVectorFields(&velocity);
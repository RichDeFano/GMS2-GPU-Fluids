/// @description Insert description here
// You can write your code in this editor


var tempStorage = 0;
//Step 0: Add a source
/*
surface_set_target(surf_tempQuantity);
shader_set(shd_add);
shader_set_uniform_f(
	shader_get_uniform(shd_add,"scaleA"),1);
shader_set_uniform_f(
	shader_get_uniform(shd_add,"scaleB"),1);
texture_set_stage(shader_get_sampler_index(shd_add, "sampA"), surface_get_texture(surf_quantity));
	texture_set_stage(shader_get_sampler_index(shd_add, "sampB"), surface_get_texture(surf_velocity));
	
	draw_surface(surf_quantity,0,0);
	surface_reset_target();
	shader_reset();
	
	 tempStorage = surf_quantity;
	 surf_quantity = surf_tempQuantity;
	 surf_tempQuantity = tempStorage;
	 */
////////////////////////////////////////////////////////////////////
//Step 1: Advection of the Vector Field
////////////////////////////////////////////////////////////////////
draw_sprite_ext(spr_grad, 0, mouse_x, mouse_y, 1,1, 0, c_red, 1);

surface_set_target(surf_tempVelocity);
	shader_set(shd_advection);
	//Set the uniforms
	//advect(velocity,advected,output,width,height,scale,timesetp,dissipation)
	shader_set_uniform_f(size,1.0);
	shader_set_uniform_f(scale,1.0);
	shader_set_uniform_f(time,stepTime);
	shader_set_uniform_f(diss,0.99);
	//Draw
	texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
	texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_velocity));
	draw_surface(surf_velocity, 0, 0);
	shader_reset();
surface_reset_target();
	 //Remap the textures
	 tempStorage = surf_velocity;
	 surf_velocity = surf_tempVelocity;
	 surf_tempVelocity = tempStorage;
//1.5: Advection of an Ink
surface_set_target(surf_tempDensity);
	shader_set(shd_advection);
	//Set the uniforms
	//advect(velocity,advected,output,width,height,scale,timesetp,dissipation)
	shader_set_uniform_f(size,1.0);
	shader_set_uniform_f(scale,1.0);
	shader_set_uniform_f(time,stepTime);
	shader_set_uniform_f(diss,0.99);
	//Draw
	texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
	texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_density));
	draw_surface(surf_density, 0, 0);
	shader_reset();
surface_reset_target();
	 //Remap the textures
	 tempStorage = surf_density;
	 surf_density = surf_tempDensity;
	 surf_tempDensity = tempStorage;
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

//Step 2: Viscous Diffusion
var jacobiIterations = 50;
var viscosity = 0.001;
//Add velocity to the diffusion field
surface_set_target(surf_tempDiffusion);
	shader_set(shd_add);
		shader_set_uniform_f(ascale,1.0);
		shader_set_uniform_f(bscale,1.0);
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field1"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field2"),surface_get_texture(surf_diffusion));
	draw_surface(surf_diffusion,0,0);
	shader_reset();
surface_reset_target();
//Remap the textures
	 tempStorage = surf_diffusion;
	 surf_diffusion = surf_tempDiffusion;
	 surf_tempDiffusion = tempStorage;


//Estimate diffusion field with jacobi

	shader_set(shd_pressureJacobi);
	shader_set_uniform_f(alph,1.0);
	shader_set_uniform_f(beta,1/5);
	texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"pressure_field"),surface_get_texture(surf_diffusion));
	texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"divergence_field"),surface_get_texture(surf_tempDiffusion));
                    for(var i=0;i<jacobiIterations;i++) {
                        surface_set_target(surf_tempDiffusion);
                            draw_surface(surf_diffusion, 0, 0);
                        surface_reset_target();
						
                        tempStorage = surf_diffusion;
					 surf_diffusion = surf_tempDiffusion;
					 surf_tempDiffusion = tempStorage;
                    }
	shader_reset();

//Add back into velocity field with viscosity
surface_set_target(surf_tempDiffusion);
	shader_set(shd_add);
		shader_set_uniform_f(ascale,1.0);
		shader_set_uniform_f(bscale,viscosity);
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field1"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field2"),surface_get_texture(surf_diffusion));
	draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
//Remap the textures
	 tempStorage = surf_velocity;
	 surf_velocity = surf_tempVelocity;
	 surf_tempVelocity = tempStorage;



/////////////////////////TODO : vorticity confinement

//Projection operator
	// Calculates divergence of velocity.
            surface_set_target(surf_pressure);
                shader_set(shd_divergence);
					texture_set_stage(shader_get_sampler_index(shd_divergence,"velocity_field"),surface_get_texture(surf_velocity));
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_velocity_divergence_glsl, "initial_value_pressure"), initial_value_pressure);
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_velocity_divergence_glsl, "texel_size"), sf_velocity_texel_width, sf_velocity_texel_height);
                    draw_surface_stretched(surf_velocity, 0, 0, room_w, room_h);
                shader_reset();
            surface_reset_target();
	//Do some more jacobi iterations	
			shader_set(shd_pressureJacobi);
			shader_set_uniform_f(alph,-1.0);
			shader_set_uniform_f(beta,1/4);
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"pressure_field"),surface_get_texture(surf_pressure));
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"divergence_field"),surface_get_texture(surf_velocity));
                    //shader_set_uniform_f(shader_get_uniform(sh_fd_calculate_pressure_jacobi_glsl, "texel_size"), sf_pressure_texel_width, sf_pressure_texel_height);
                    for(var i=0;i<jacobiIterations;i++) {
                        surface_set_target(surf_tempPressure);
                            draw_surface(surf_pressure, 0, 0);
                        surface_reset_target();
						
                        tempStorage = surf_pressure; 
						surf_pressure = surf_tempPressure; 
						surf_tempPressure = tempStorage;
                    }
           shader_reset();
//

surface_set_target(surf_tempVelocity);
shader_set(shd_subtractGradient);
texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"pressure_field"),surface_get_texture(surf_pressure));
texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"velocity_field"),surface_get_texture(surf_velocity));
draw_surface(surf_velocity,0,0);
shader_reset();
surface_reset_target();

						tempStorage = surf_velocity; 
						surf_pressure = surf_tempVelocity; 
						surf_tempVelocity = tempStorage;
/////////////////////////////////////////////////////////////////////////


shader_set(shd_visualize)

        switch (DISPLAY_FIELD) {
            case DISPLAY_FIELD.DENSITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_density));
                shader_set_uniform_f(maxval, 1.0);
                shader_set_uniform_f(bias, 0.0, 0.0, 0.0);
				draw_surface(surf_density,0,0);
				draw_text(0,0,"DISPLAY MODE: DENSITY");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.VELOCITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_velocity));
                shader_set_uniform_f(maxval, 32.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				draw_surface(surf_velocity,0,0);
				draw_text(0,0,"DISPLAY MODE: VELOCITY");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.PRESSURE:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_pressure));
                shader_set_uniform_f(maxval, 64.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				draw_surface(surf_pressure,0,0);
				draw_text(0,0,"DISPLAY MODE: PRESSURE");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.DIVERGENCE:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_divergence));
                shader_set_uniform_f(maxval, 1.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				draw_surface(surf_divergence,0,0);
				draw_text(0,0,"DISPLAY MODE: DIVERGENCE");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.VORTICITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_vorticity));
                shader_set_uniform_f(maxval, 4.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				draw_surface(surf_vorticity,0,0);
				draw_text(0,0,"DISPLAY MODE: VORTICITY");
				//shader_reset();
				//surface_reset_target();
                break;
        }
		
shader_reset();





//splat the ink by updating the density field
surface_set_target(surf_tempDensity);
	shader_set(shd_gaussianSplat)
		shader_set_uniform_f(pt,mouse_x,mouse_y);
		shader_set_uniform_f(r,12.0);
		shader_set_uniform_f(fC,138.0,43.0,226.0);
		texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_tempDensity));
		draw_surface(surf_density,0,0);
		draw_sprite(spr_grad,0,mouse_x,mouse_y);
	shader_reset();
		tempStorage = surf_density;
		surf_density = surf_tempDensity;
		surf_tempDensity = tempStorage;	 
surface_reset_target();
//and update the velocity field too
surface_set_target(surf_tempVelocity);
	shader_set(shd_splat);
		shader_set_uniform_f(vpt,mouse_x,mouse_y);
		shader_set_uniform_f(vr,12.0);
		shader_set_uniform_f(vfC,255.0,215.0,0.0)
		texture_set_stage(shader_get_sampler_index(shd_splat,"source_field"),surface_get_texture(surf_tempVelocity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
		tempStorage = surf_velocity;
		surf_velocity = surf_tempVelocity;
		surf_tempVelocity = tempStorage;
surface_reset_target();

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
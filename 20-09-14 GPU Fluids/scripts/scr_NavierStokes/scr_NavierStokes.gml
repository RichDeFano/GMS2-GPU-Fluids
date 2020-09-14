//var tempStorage = surface_create(room_w,room_h);


////////////////////////////////////////////////////////////////////
//Step 1: Advection of the Vector Fields
////////////////////////////////////////////////////////////////////

surface_set_target(surf_tempVelocity);
	shader_set(shd_advection);
		shader_set_uniform_f(adSize,size/room_w,size/room_h);
		shader_set_uniform_f(adScale,1.0/scale);
		shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,velocityDissipation);
		texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_velocity));
			draw_surface(surf_velocity, 0, 0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);
	
	
	
//1.5: Advection of an Ink
surface_set_target(surf_tempDensity);
	shader_set(shd_advection);
		shader_set_uniform_f(adSize,size/room_w,size/room_h);
		shader_set_uniform_f(adScale,1.0/scale);
		shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,materialDissipation);
		texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_density));
			draw_surface(surf_density, 0, 0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempDensity,surf_density);
	

////////////////////////////////////////////////////////////////////
//Step 2: Diffusion of the Vector Fields
////////////////////////////////////////////////////////////////////
//Add velocity to the diffusion field
surface_set_target(surf_tempDiffusion);
	shader_set(shd_addDiffusion);
		shader_set_uniform_f(ascale,diffusionA);
		shader_set_uniform_f(bscale,diffusionB);
		texture_set_stage(shader_get_sampler_index(shd_addDiffusion,"vector_field"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_addDiffusion,"scalar_field"),surface_get_texture(surf_diffusion));
		draw_surface(surf_diffusion,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempDiffusion,surf_diffusion);
	/*
//Estimate diffusion field with jacobi
for(var i=0;i<jacobiIterations;i++) {
	surface_set_target(surf_tempDiffusion);
		shader_set(shd_jacobi);
			shader_set_uniform_f(alph,defaultViscAlpha);
			shader_set_uniform_f(beta,defaultViscBeta);
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"pressure_field"),surface_get_texture(surf_diffusion));
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"divergence_field"),surface_get_texture(surf_diffusion));
	          draw_surface(surf_diffusion, 0, 0);
		shader_reset();
	surface_reset_target();
		scr_swapFields(tempStorage,surf_tempDiffusion,surf_diffusion);
}

/*
//Add back into velocity field with viscosity

surface_set_target(surf_tempVelocity);
	shader_set(shd_addVelocity);
		shader_set_uniform_f(ascale,velocityPart);
		shader_set_uniform_f(bscale,viscosity);
		texture_set_stage(shader_get_sampler_index(shd_addVelocity,"vector_field"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_addVelocity,"scalar_field"),surface_get_texture(surf_diffusion));
		draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);
////////////////////////////////////////////////////////////////////
//Step 3: Forces (External and Internal)
////////////////////////////////////////////////////////////////////
//Buoyancy Force
surface_set_target(surf_tempVelocity)
	shader_set(shd_buoyancy);
		shader_set_uniform_f(buoyAlpha,1.0);
		shader_set_uniform_f(buoyBeta,1.0);
			texture_set_stage(shader_get_sampler_index(shd_vorticity,"velocity_field"),surface_get_texture(surf_velocity));
			texture_set_stage(shader_get_sampler_index(shd_vorticity,"density_field"),surface_get_texture(surf_density));
			texture_set_stage(shader_get_sampler_index(shd_vorticity,"temperature_field"),surface_get_texture(surf_temperature));
				draw_surface(surf_velocity,0,0);
			shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);
		
//Vorticity Confinement
surface_set_target(surf_tempVorticity)
	shader_set(shd_vorticity);
		shader_set_uniform_f(vorSize,room_w,room_h);
		shader_set_uniform_f(vorScale,0.5/scale);
		texture_set_stage(shader_get_sampler_index(shd_vorticity,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_vorticity,0,0);
	shader_reset();
surface_reset_target();
	 scr_swapFields(tempStorage,surf_tempVorticity,surf_vorticity);
	 
//Vorticity Force Confinement
surface_set_target(surf_tempVelocity);
	shader_set(shd_vorticityForce);
		shader_set_uniform_f(vorForceSize,room_w,room_h);
		shader_set_uniform_f(vorForceScale, 0.5/scale);
		shader_set_uniform_f(vorForceTime,stepTime);
		shader_set_uniform_f(vorForceEp, defaultEpsillon);
		shader_set_uniform_f(vorForceCurl,defaultCurl,defaultCurl);
		texture_set_stage(shader_get_sampler_index(shd_vorticityForce,"velocity_field"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_vorticityForce,"vorticity_field"),surface_get_texture(surf_vorticity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);

//////////////////////////////////////////////////////////////
//Step 4: Projection of the Vector Fields
////////////////////////////////////////////////////////////
// Calculates divergence of velocity.
surface_set_target(surf_tempDivergence);
	shader_set(shd_divergence);
	shader_set_uniform_f(divScale,0.5/scale);
		texture_set_stage(shader_get_sampler_index(shd_divergence,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_divergence, 0, 0);
    shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempDivergence,surf_divergence);
//Do some more jacobi iterations
for(var i=0;i<jacobiIterations;i++) {
	surface_set_target(surf_tempPressure);
		shader_set(shd_jacobi);
			shader_set_uniform_f(alph,defaultJacobiAlpha);
			shader_set_uniform_f(beta,defaultJacobiBeta);
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"pressure_field"),surface_get_texture(surf_pressure));
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"divergence_field"),surface_get_texture(surf_velocity));
				draw_surface(surf_pressure, 0, 0);
		shader_reset();		
	surface_reset_target();
		scr_swapFields(tempStorage,surf_tempPressure,surf_pressure);
}
//Subtract from the gradient		
surface_set_target(surf_tempVelocity);
	shader_set(shd_subtractGradient);
		shader_set_uniform_f(gradScale,0.5/scale);
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"pressure_field"),surface_get_texture(surf_pressure));
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);
////////////////////////////
//Boundary Conditions
////////////////////////////
//Pressure Boundaries
surface_set_target(surf_tempPressure);
	shader_set(shd_pressureBoundary);
		texture_set_stage(shader_get_sampler_index(shd_pressureBoundary,"scalar_field"),surface_get_texture(surf_pressure));
		shader_set_uniform_f(boundH,room_w);
		shader_set_uniform_f(boundW,room_h);
			draw_surface(surf_pressure,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempPressure,surf_pressure);
//Velocity boundaries
surface_set_target(surf_tempVelocity);
	shader_set(shd_velocityBoundary);
		texture_set_stage(shader_get_sampler_index(shd_velocityBoundary,"vector_field"),surface_get_texture(surf_velocity));
		shader_set_uniform_f(boundH,room_h);
		shader_set_uniform_f(boundW,room_w);
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	scr_swapFields(tempStorage,surf_tempVelocity,surf_velocity);
	
	

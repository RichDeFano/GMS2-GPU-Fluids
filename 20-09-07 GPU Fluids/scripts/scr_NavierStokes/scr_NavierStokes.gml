//var tempStorage = surface_create(room_w,room_h);


////////////////////////////////////////////////////////////////////
//Step 1: Advection of the Vector Fields
////////////////////////////////////////////////////////////////////

surface_set_target(surf_tempVelocity);
	shader_set(shd_advection);
		//shader_set_uniform_f(size,defaultSize/room_w,defaultSize/room_h);
		shader_set_uniform_f(scale,velocityScale);
		//shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,velocityDissipation);
		texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_velocity));
			draw_surface(surf_velocity, 0, 0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);
	
	
	
//1.5: Advection of an Ink
surface_set_target(surf_tempDensity);
	shader_set(shd_advection);
		//shader_set_uniform_f(size,defaultSize/room_w,defaultSize/room_h);
		shader_set_uniform_f(scale,materialScale);
		//shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,materialDissipation);
		texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_density));
			draw_surface(surf_density, 0, 0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_density);
	surface_copy(surf_density,0,0,surf_tempDensity);
	surface_copy(surf_tempDensity,0,0,tempStorage);
	

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
	surface_copy(tempStorage,0,0,surf_diffusion);
	surface_copy(surf_diffusion,0,0,surf_tempDiffusion);
	surface_copy(surf_tempDiffusion,0,0,tempStorage);
	
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
		surface_copy(tempStorage,0,0,surf_diffusion);
		surface_copy(surf_diffusion,0,0,surf_tempDiffusion);
		surface_copy(surf_tempDiffusion,0,0,tempStorage);
}


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
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);

//Vorticity Confinement

surface_set_target(surf_tempVorticity)
	shader_set(shd_vorticity);
		shader_set_uniform_f(vorSize,vorticitySize);
		shader_set_uniform_f(vorScale,vorticityScale);
		texture_set_stage(shader_get_sampler_index(shd_vorticity,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_vorticity,0,0);
	shader_reset();
surface_reset_target();
	 surface_copy(tempStorage,0,0,surf_vorticity);
	 surface_copy(surf_vorticity,0,0,surf_tempVorticity);
	 surface_copy(surf_tempVorticity,0,0,tempStorage);
	 
//Vorticity Force Confinement
surface_set_target(surf_tempVelocity);
	shader_set(shd_vorticityForce);
		shader_set_uniform_f(vorForceSize,vorticityFSize);
		shader_set_uniform_f(vorForceScale, vorticityFScale);
		//shader_set_uniform_f(vorForceTime,stepTime);
		shader_set_uniform_f(vorForceEp, defaultEpsillon);
		shader_set_uniform_f(vorForceCurl,defaultCurl,defaultCurl);
		texture_set_stage(shader_get_sampler_index(shd_vorticityForce,"velocity_field"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_vorticityForce,"vorticity_field"),surface_get_texture(surf_vorticity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);

//////////////////////////////////////////////////////////////
//Step 3: Projection of the Vector Fields
////////////////////////////////////////////////////////////
// Calculates divergence of velocity.
surface_set_target(surf_tempDivergence);
	shader_set(shd_divergence);
		texture_set_stage(shader_get_sampler_index(shd_divergence,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_divergence, 0, 0);
    shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_divergence);
		surface_copy(surf_divergence,0,0,surf_tempDivergence);
		surface_copy(surf_tempDivergence,0,0,tempStorage);
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
		surface_copy(tempStorage,0,0,surf_pressure);
		surface_copy(surf_pressure,0,0,surf_tempPressure);
		surface_copy(surf_tempPressure,0,0,tempStorage);
}

//Pressure Boundaries
surface_set_target(surf_tempPressure);
	shader_set(shd_pressureBoundary);
		texture_set_stage(shader_get_sampler_index(shd_pressureBoundary,"scalar_field"),surface_get_texture(surf_pressure));
		shader_set_uniform_f(boundH,room_w);
		shader_set_uniform_f(boundW,room_h);
			draw_surface(surf_pressure,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_pressure);
	surface_copy(surf_pressure,0,0,surf_tempPressure);
	surface_copy(surf_tempPressure,0,0,tempStorage);
//Subtract from the gradient		
surface_set_target(surf_tempVelocity);
	shader_set(shd_subtractGradient);
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"pressure_field"),surface_get_texture(surf_pressure));
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);
//Velocity boundaries
surface_set_target(surf_tempVelocity);
	shader_set(shd_velocityBoundary);
		texture_set_stage(shader_get_sampler_index(shd_velocityBoundary,"vector_field"),surface_get_texture(surf_velocity));
		shader_set_uniform_f(boundH,room_h);
		shader_set_uniform_f(boundW,room_w);
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);
////////////////////////
//Step 4: Convection
/////////////////////////////
//Calculate buoyant forces
surface_set_target(surf_tempTemperature)
	shader_set(shd_convection);
		texture_set_stage(shader_get_sampler_index(shd_convection,"temperature_field"),surface_get_texture(surf_temperature));
		draw_surface(surf_temperature,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_temperature);
	surface_copy(surf_temperature,0,0,surf_tempTemperature);
	surface_copy(surf_tempTemperature,0,0,tempStorage);
//Estimate diffusion field with jacobi
for(var i=0;i<jacobiIterations;i++) {
	surface_set_target(surf_tempTemperature);
		shader_set(shd_jacobi);
			shader_set_uniform_f(alph,defaultViscAlpha);
			shader_set_uniform_f(beta,defaultViscBeta);
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"pressure_field"),surface_get_texture(surf_temperature));
			texture_set_stage(shader_get_sampler_index(shd_jacobi,"divergence_field"),surface_get_texture(surf_temperature));
	          draw_surface(surf_temperature, 0, 0);
		shader_reset();
	surface_reset_target();
		surface_copy(tempStorage,0,0,surf_temperature);
		surface_copy(surf_temperature,0,0,surf_tempTemperature);
		surface_copy(surf_tempTemperature,0,0,tempStorage);
}


//Add back into velocity field with viscosity
surface_set_target(surf_tempVelocity);
	shader_set(shd_addBuoyancy);
		shader_set_uniform_f(ascale,velocityPart);
		shader_set_uniform_f(bscale,velocityPart);
		texture_set_stage(shader_get_sampler_index(shd_addVelocity,"vector_field"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_addVelocity,"scalar_field"),surface_get_texture(surf_temperature));
		draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);

	

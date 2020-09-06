//var tempStorage = surface_create(room_w,room_h);
//Advection
var defaultDissipation = 0.20;			//Range 0-1 - should be higher than velocity if its going to leave anything behind
var defaultVelocityDissipation = 0.40;	//Range 0-1
var defaultSize = 1.0;
var defaultScale = 1.0;
//Step 2: Viscous Diffusion
var jacobiIterations = 50;				//Range 20-100
var defaultViscosity = 0.001;
var defaultViscAlpha = 1.0;
var defaultViscBeta = 0.20;
var defaultAScale = 1.0;
var defaultBScale = 1.0;
//Vorticity Confinement
var defaultVorticityScale = 0.5;
var defaultVorticitySize = 1.0;
var defaultEpsillon = 0.00024414;
var defaultCurl = 0.3;
//Projection
var defaultJacobiAlpha = (-1.0);
var defaultJacobiBeta = (0.25);
//Pressure Boundaries
var pBoundariesHeight = 1.0;
var pBoundariesWidth = 1.0;
///Velocity Boundaries
var vBoundariesHeight = 1.0;
var vBoundariesWidth = 1.0;
////////////////////////////////////////////////////////////////////
//Step 1: Advection of the Vector Fields
////////////////////////////////////////////////////////////////////

surface_set_target(surf_tempVelocity);
	shader_set(shd_advection);
		shader_set_uniform_f(size,defaultSize/room_w,defaultSize/room_h);
		shader_set_uniform_f(scale,defaultScale/(room_w*room_h));
		shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,defaultVelocityDissipation);
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
		shader_set_uniform_f(size,defaultSize/room_w,defaultSize/room_h);
		shader_set_uniform_f(scale,1.0/defaultScale);
		shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,defaultDissipation);
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
	shader_set(shd_add);
		shader_set_uniform_f(ascale,defaultAScale);
		shader_set_uniform_f(bscale,defaultAScale);
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field1"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field2"),surface_get_texture(surf_diffusion));
		draw_surface(surf_diffusion,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_diffusion);
	surface_copy(surf_diffusion,0,0,surf_tempDiffusion);
	surface_copy(surf_tempDiffusion,0,0,tempStorage);
	
//Estimate diffusion field with jacobi
for(var i=0;i<jacobiIterations;i++) {
	surface_set_target(surf_tempDiffusion);
		shader_set(shd_pressureJacobi);
			shader_set_uniform_f(alph,defaultViscAlpha);
			shader_set_uniform_f(beta,defaultViscBeta);
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"pressure_field"),surface_get_texture(surf_diffusion));
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"divergence_field"),surface_get_texture(surf_tempDiffusion));
	          draw_surface(surf_diffusion, 0, 0);
		shader_reset();
	surface_reset_target();
		surface_copy(tempStorage,0,0,surf_diffusion);
		surface_copy(surf_diffusion,0,0,surf_tempDiffusion);
		surface_copy(surf_tempDiffusion,0,0,tempStorage);
}
	
//Add back into velocity field with viscosity
surface_set_target(surf_tempVelocity);
	shader_set(shd_add);
		shader_set_uniform_f(ascale,defaultAScale);
		shader_set_uniform_f(bscale,defaultViscosity);
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field1"),surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_add,"tex_field2"),surface_get_texture(surf_diffusion));
		draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);

//Vorticity Confinement

surface_set_target(surf_tempVorticity)
	shader_set(shd_vorticity);
		shader_set_uniform_f(vorSize,defaultVorticitySize);
		shader_set_uniform_f(vorScale,defaultVorticityScale);
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
		shader_set_uniform_f(vorForceSize,defaultVorticitySize,defaultVorticitySize);
		shader_set_uniform_f(vorForceScale, defaultVorticityScale);
		shader_set_uniform_f(vorForceTime,stepTime);
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
	tempStorage = surf_tempDivergence; 
	surf_tempDivergence = surf_divergence; 
	surf_divergence = tempStorage;
//Do some more jacobi iterations
for(var i=0;i<jacobiIterations;i++) {
	surface_set_target(surf_tempPressure);
		shader_set(shd_pressureJacobi);
			shader_set_uniform_f(alph,defaultJacobiAlpha);
			shader_set_uniform_f(beta,defaultJacobiBeta);
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"pressure_field"),surface_get_texture(surf_pressure));
			texture_set_stage(shader_get_sampler_index(shd_pressureJacobi,"divergence_field"),surface_get_texture(surf_velocity));
				draw_surface(surf_pressure, 0, 0);
		shader_reset();		
	surface_reset_target();
		surface_copy(tempStorage,0,0,surf_pressure);
		surface_copy(surf_pressure,0,0,surf_tempPressure);
		surface_copy(surf_tempPressure,0,0,tempStorage);
}

//Pressure Boundaries
surface_set_target(surf_tempPressure);
	shader_set(shd_boundary);
		texture_set_stage(shader_get_sampler_index(shd_boundary,"vector_field"),surface_get_texture(surf_pressure));
		shader_set_uniform_f(boundH,pBoundariesHeight);
		shader_set_uniform_f(boundW,pBoundariesWidth);
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
	shader_set(shd_boundary);
		texture_set_stage(shader_get_sampler_index(shd_boundary,"vector_field"),surface_get_texture(surf_velocity));
		shader_set_uniform_f(boundH,vBoundariesHeight);
		shader_set_uniform_f(boundW,vBoundariesWidth);
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	surface_copy(tempStorage,0,0,surf_velocity);
	surface_copy(surf_velocity,0,0,surf_tempVelocity);
	surface_copy(surf_tempVelocity,0,0,tempStorage);
	
	

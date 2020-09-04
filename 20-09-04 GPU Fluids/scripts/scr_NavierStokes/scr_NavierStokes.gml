var tempStorage = surface_create(room_w,room_h);
//Advection
var defaultDissipation = 0.90;			//Range 0-1
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
//Step 1: Advection of the Vector Field
////////////////////////////////////////////////////////////////////
surface_set_target(surf_tempVelocity);
	shader_set(shd_advection);
		shader_set_uniform_f(size,defaultSize/room_w,defaultSize/room_h);
		shader_set_uniform_f(scale,defaultScale/room_w,defaultScale/room_h);
		shader_set_uniform_f(time,stepTime);
		shader_set_uniform_f(diss,defaultDissipation);
		texture_set_stage(shader_get_sampler_index(shd_advection, "velocity_field"), surface_get_texture(surf_velocity));
		texture_set_stage(shader_get_sampler_index(shd_advection, "advected_field"), surface_get_texture(surf_velocity));
			draw_surface(surf_velocity, 0, 0);
	shader_reset();
surface_reset_target();
	tempStorage = surf_velocity;
	surf_velocity = surf_tempVelocity;
	surf_tempVelocity = tempStorage;
	
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
	tempStorage = surf_tempDensity;
	surf_tempDensity = surf_density;
	surf_density = tempStorage;
	
////////////////////////////////////////////////////////////////////
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
	tempStorage = surf_tempDiffusion;
	surf_tempDiffusion = surf_diffusion;
	surf_diffusion = tempStorage;
	
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
		tempStorage = surf_tempDiffusion;
		surf_tempDiffusion = surf_diffusion;
		surf_diffusion = tempStorage;
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
	 tempStorage = surf_tempVelocity;
	 surf_tempVelocity = surf_velocity;
	 surf_velocity = tempStorage;
//Vorticity Confinement
surface_set_target(surf_tempVorticity)
	shader_set(shd_vorticity);
		shader_set_uniform_f(vorSize,defaultVorticitySize);
		shader_set_uniform_f(vorScale,defaultVorticityScale);
		texture_set_stage(shader_get_sampler_index(shd_vorticity,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_vorticity,0,0);
	shader_reset();
surface_reset_target();
	 tempStorage = surf_tempVorticity;
	 surf_tempVorticity = surf_vorticity;
	 surf_vorticity = tempStorage;
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
	 tempStorage = surf_tempVelocity;
	 surf_tempVelocity = surf_velocity;
	 surf_velocity = tempStorage;
//////////////////////////////////////////////////////////////
//Projection operator
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
		tempStorage = surf_tempPressure; 
		surf_tempPressure = surf_pressure; 
		surf_pressure = tempStorage;
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
	tempStorage = surf_tempPressure; 
	surf_tempPressure = surf_pressure; 
	surf_pressure = tempStorage;
//Subtract from the gradient		
surface_set_target(surf_tempVelocity);
	shader_set(shd_subtractGradient);
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"pressure_field"),surface_get_texture(surf_pressure));
		texture_set_stage(shader_get_sampler_index(shd_subtractGradient,"velocity_field"),surface_get_texture(surf_velocity));
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	tempStorage = surf_tempVelocity; 
	surf_tempVelocity = surf_velocity; 
	surf_velocity = tempStorage;
//Velocity boundaries
surface_set_target(surf_tempVelocity);
	shader_set(shd_boundary);
		texture_set_stage(shader_get_sampler_index(shd_boundary,"vector_field"),surface_get_texture(surf_velocity));
		shader_set_uniform_f(boundH,vBoundariesHeight);
		shader_set_uniform_f(boundW,vBoundariesWidth);
			draw_surface(surf_velocity,0,0);
	shader_reset();
surface_reset_target();
	tempStorage = surf_tempVelocity; 
	surf_tempVelocity = surf_velocity; 
	surf_velocity = tempStorage;
	
	

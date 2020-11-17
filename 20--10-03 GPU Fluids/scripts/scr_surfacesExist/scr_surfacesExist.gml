var allExist = false;
//Check Surfaces
	if (
	(surface_exists(surf_density)) 
	&& (surface_exists(surf_tempDensity)) 
	
	&& (surface_exists(surf_velocity)) 
	&& (surface_exists(surf_tempVelocity)) 
	
	&& (surface_exists(surf_pressure)) 
	&& (surface_exists(surf_tempPressure)) 
	
	&& (surface_exists(surf_divergence)) 
	&& (surface_exists(surf_tempDivergence)) 
	
	&& (surface_exists(surf_vorticity)) 
	&& (surface_exists(surf_tempVorticity)) 
	
	&& (surface_exists(surf_diffusion)) 
	&& (surface_exists(surf_tempDiffusion)) 
	
	&& (surface_exists(surf_temperature)) 
	&& (surface_exists(surf_tempTemperature)) 

	&& (surface_exists(surf_world)) 
	&& (surface_exists(surf_tempStorage)) 
	)
		{allExist = true;}
//Create if false
	else
		{
		scr_initSurfaces();
		allExist = true;
		}

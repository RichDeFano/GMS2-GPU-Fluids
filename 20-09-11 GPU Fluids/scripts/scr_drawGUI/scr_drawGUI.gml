/*
velocityDissipation = instance_create_layer(10,30,"GUI",obj_sliderParent);
	velocityDissipation.minValue = 0.0;
	velocityDissipation.maxValue = 1.0;
	velocityDissipation.value = 0.25;
	
materialDissipation = instance_create_layer(10,60,"GUI",obj_sliderParent);
	materialDissipation.minValue = 0.0;
	materialDissipation.maxValue = 1.0;
	materialDissipation.value = 0.50;
	
viscosity = instance_create_layer(10,90,"GUI",obj_sliderParent);
	viscosity.minValue = 0.0;
	viscosity.maxValue = 1.0;
	viscosity.value = 0.99;
	
timeStep = instance_create_layer(10,120,"GUI",obj_sliderParent);
	timeStep.minValue = 0.0;
	timeStep.maxValue = 100.0;
	timeStep.value = 1.25;
	
	
	*/
var startingX = 80;
var startingY = 10;
draw_sprite(spr_guiBG,0,0,16);
	
//Advection
draw_text(startingX,startingY+16,"Velocity Dissipation: " + string(velocityDissipation.returnValue));
draw_text(startingX,startingY+40,"Velocity Scale: " + string(velocityScale.returnValue));
draw_text(startingX,startingY+64,"Material Dissipation: " + string(materialDissipation.returnValue));
draw_text(startingX,startingY+88,"Material Scale " + string(materialScale.returnValue));
//Viscous Diffusion
draw_text(startingX,startingY+112,"Diffusion %A: " + string(diffusionA.returnValue));
draw_text(startingX,startingY+136,"Diffusion %B " + string(diffusionB.returnValue));
draw_text(startingX,startingY+160,"Velocity % " + string(velocityPart.returnValue));
draw_text(startingX,startingY+184,"Viscosity % " + string(viscosity.returnValue));
//Vorticity
draw_text(startingX,startingY+208,"Vorticity Size: " + string(vorticitySize.returnValue));
draw_text(startingX,startingY+232,"Vorticity Scale: " + string(vorticityScale.returnValue));
draw_text(startingX,startingY+256,"Vorticity FSize: " + string(vorticityFSize.returnValue));
draw_text(startingX,startingY+280,"Vorticity FScale: " + string(vorticityFScale.returnValue));
///Forces
draw_text(startingX,startingY+304,"Buoyancy Alpha: " + string(buoyancyAlpha.returnValue));
draw_text(startingX,startingY+328,"Buoyancy Beta: " + string(buoyancyBeta.returnValue));

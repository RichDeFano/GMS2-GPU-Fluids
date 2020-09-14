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
var startingX = 150;
var startingY = 10;
draw_sprite(spr_guiBG,0,0,16);
//16 40 64 88 112 136 160 184 208 232 256 280 304 328
//Advection
draw_text(startingX,startingY+16,"Velocity Dissipation: " + string(velocityDissipation.returnValue));
draw_text(startingX,startingY+40,"Material Dissipation: " + string(materialDissipation.returnValue));
//Viscous Diffusion
draw_text(startingX,startingY+64,"Diffusion %A: " + string(diffusionA.returnValue));
draw_text(startingX,startingY+88,"Diffusion %B " + string(diffusionB.returnValue));
draw_text(startingX,startingY+112,"Velocity % " + string(velocityPart.returnValue));
draw_text(startingX,startingY+136,"Viscosity % " + string(viscosity.returnValue));
///Forces
draw_text(startingX,startingY+160,"Buoyancy Alpha: " + string(buoyancyAlpha.returnValue));
draw_text(startingX,startingY+184,"Buoyancy Beta: " + string(buoyancyBeta.returnValue));

//Vorticity
draw_text(startingX,startingY+208,"Size: " + string(size.returnValue));
draw_text(startingX,startingY+232,"Scale: " + string(scale.returnValue));


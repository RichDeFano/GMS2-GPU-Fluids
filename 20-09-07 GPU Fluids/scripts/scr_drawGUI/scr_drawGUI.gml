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
	
draw_text(80,30,"Velocity Dissipation: " + string(velocityDissipation.returnValue));
draw_text(80,60,"Material Dissipation: " + string(materialDissipation.returnValue));
draw_text(80,90,"Viscosity: " + string(viscosity.returnValue));
draw_text(80,120,"Timestep: " + string(time.returnValue));
draw_text(80,150,"Size: " + string(size.returnValue));
draw_text(80,180,"Scale: " + string(scale.returnValue));
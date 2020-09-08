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
	
time = instance_create_layer(10,120,"GUI",obj_sliderParent);
	time.minValue = 0.0;
	time.maxValue = 100.0;
	time.value = 1.0;
	
size = instance_create_layer(10,150,"GUI",obj_sliderParent);
	size.minValue = 0.0;
	size.maxValue = 5.0;
	size.value = 1.0;
	
scale = instance_create_layer(10,180,"GUI",obj_sliderParent);
	scale.minValue = 0.0;
	scale.maxValue = 5.0;
	scale.value = 1.0;
	
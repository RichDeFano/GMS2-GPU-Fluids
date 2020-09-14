var startingX = 0; var startingY = 20;

//Advection
velocityDissipation = instance_create_layer(startingX,startingY+16,"GUI",obj_sliderParent);
	velocityDissipation.minValue = 0.0;
	velocityDissipation.maxValue = 1.0;
	velocityDissipation.value = 0.75;
	
	
materialDissipation = instance_create_layer(startingX,startingY+40,"GUI",obj_sliderParent);
	materialDissipation.minValue = 0.0;
	materialDissipation.maxValue = 1.0;
	materialDissipation.value = 0.0;
	
///////////////////////////////////////////////////////////Viscous
diffusionA = instance_create_layer(startingX,startingY+64,"GUI",obj_sliderParent);
	diffusionA.minValue = 0.0;
	diffusionA.maxValue = 1.0;
	diffusionA.value = 0.25;
	
diffusionB = instance_create_layer(startingX,startingY+88,"GUI",obj_sliderParent);
	diffusionB.minValue = 0.0;
	diffusionB.maxValue = 1.0;
	diffusionB.value = 0.99;
	
velocityPart = instance_create_layer(startingX,startingY+112,"GUI",obj_sliderParent);
	velocityPart.minValue = 0.0;
	velocityPart.maxValue = 1.0;
	velocityPart.value = 0.50;
	
viscosity = instance_create_layer(startingX,startingY+136,"GUI",obj_sliderParent);
	viscosity.minValue = 0.0;
	viscosity.maxValue = 1.0;
	viscosity.value = 1.0;
///Forces
buoyancyAlpha = instance_create_layer(startingX,startingY+160,"GUI",obj_sliderParent);
	buoyancyAlpha.minValue = 0.0;
	buoyancyAlpha.maxValue = 1.0;
	buoyancyAlpha.value = 1.0;
	
buoyancyBeta = instance_create_layer(startingX,startingY+184,"GUI",obj_sliderParent);
	buoyancyBeta.minValue = 0.0;
	buoyancyBeta.maxValue = 1.0;
	buoyancyBeta.value = 1.0;
///Scaling
size = instance_create_layer(startingX,startingY+208,"GUI",obj_sliderParent);
	size.minValue = 0.0;
	size.maxValue = 10.0;
	size.value = 1.0;
	
scale = instance_create_layer(startingX,startingY+232,"GUI",obj_sliderParent);
	scale.minValue = 0.0;
	scale.maxValue = 10.0;
	scale.value = 1.0;
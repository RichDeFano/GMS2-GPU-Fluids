var startingX = 0; var startingY = 20;

//Advection
velocityDissipation = instance_create_layer(startingX,startingY+16,"GUI",obj_sliderParent);
	velocityDissipation.minValue = 0.0;
	velocityDissipation.maxValue = 1.0;
	velocityDissipation.value = 0.25;
	
velocityScale = instance_create_layer(startingX,startingY+40,"GUI",obj_sliderParent);
	velocityScale.minValue = 0.0;
	velocityScale.maxValue = 1.0;
	velocityScale.value = 0.99;
	
materialDissipation = instance_create_layer(startingX,startingY+64,"GUI",obj_sliderParent);
	materialDissipation.minValue = 0.0;
	materialDissipation.maxValue = 1.0;
	materialDissipation.value = 0.50;
	
materialScale = instance_create_layer(startingX,startingY+88,"GUI",obj_sliderParent);
	materialScale.minValue = 0.0;
	materialScale.maxValue = 1.0;
	materialScale.value = 0.99;
///////////////////////////////////////////////////////////Viscous
diffusionA = instance_create_layer(startingX,startingY+112,"GUI",obj_sliderParent);
	diffusionA.minValue = 0.0;
	diffusionA.maxValue = 1.0;
	diffusionA.value = 0.25;
	
diffusionB = instance_create_layer(startingX,startingY+136,"GUI",obj_sliderParent);
	diffusionB.minValue = 0.0;
	diffusionB.maxValue = 1.0;
	diffusionB.value = 0.99;
	
velocityPart = instance_create_layer(startingX,startingY+160,"GUI",obj_sliderParent);
	velocityPart.minValue = 0.0;
	velocityPart.maxValue = 1.0;
	velocityPart.value = 0.50;
	
viscosity = instance_create_layer(startingX,startingY+184,"GUI",obj_sliderParent);
	viscosity.minValue = 0.0;
	viscosity.maxValue = 1.0;
	viscosity.value = 0.99;
///////////////////////////////////////////////////////////Vort
vorticitySize = instance_create_layer(startingX,startingY+208,"GUI",obj_sliderParent);
	vorticitySize.minValue = 0.0;
	vorticitySize.maxValue = 1.0;
	vorticitySize.value = 0.25;
	
vorticityScale = instance_create_layer(startingX,startingY+232,"GUI",obj_sliderParent);
	vorticityScale.minValue = 0.0;
	vorticityScale.maxValue = 1.0;
	vorticityScale.value = 0.99;
	
vorticityFSize = instance_create_layer(startingX,startingY+256,"GUI",obj_sliderParent);
	vorticityFSize.minValue = 0.0;
	vorticityFSize.maxValue = 1.0;
	vorticityFSize.value = 0.50;
	
vorticityFScale = instance_create_layer(startingX,startingY+280,"GUI",obj_sliderParent);
	vorticityFScale.minValue = 0.0;
	vorticityFScale.maxValue = 1.0;
	vorticityFScale.value = 0.99;
	

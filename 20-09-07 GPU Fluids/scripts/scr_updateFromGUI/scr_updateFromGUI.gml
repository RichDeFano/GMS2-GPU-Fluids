con_liquid.velocityDissipation = velocityDissipation.returnValue;
con_liquid.velocityScale = velocityScale.returnValue;
con_liquid.materialDissipation = materialDissipation.returnValue;
con_liquid.materialScale = materialScale.returnValue;
con_liquid.diffusionA = diffusionA.returnValue;
con_liquid.diffusionB = diffusionB.returnValue;
con_liquid.velocityPart = velocityPart.returnValue;
con_liquid.viscosity = viscosity.returnValue;
con_liquid.vorticitySize = vorticitySize.returnValue;
con_liquid.vorticityScale = vorticityScale.returnValue;
con_liquid.vorticityFSize = vorticityFSize.returnValue;
con_liquid.vorticityFScale = vorticityFScale.returnValue;




/*
//Advection
defaultDissipation = 0.50;			//Range 0-1 - should be higher than velocity if its going to leave anything behind
defaultVelocityDissipation = 0.20;	//Range 0-1
defaultSize = 1.0;
defaultScale = 1.0;
//Step 2: Viscous Diffusion
jacobiIterations = 50;				//Range 20-100
defaultViscosity = 0.001;
defaultViscAlpha = 1.0;
defaultViscBeta = 0.20;
//var defaultAScale = 1.0;
//var defaultBScale = 1.0;
//Vorticity Confinement
//var defaultVorticityScale = 0.5;
//var defaultVorticitySize = 1.0;
defaultEpsillon = 0.00024414;
defaultCurl = 0.3;
//Projection
defaultJacobiAlpha = (-1.0);
defaultJacobiBeta = (0.25);
//Pressure Boundaries
pBoundariesHeight = 1.0;
pBoundariesWidth = 1.0;
///Velocity Boundaries
vBoundariesHeight = 1.0;
vBoundariesWidth = 1.0;
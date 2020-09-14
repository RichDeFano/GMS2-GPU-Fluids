
room_w = room_width;
room_h = room_height;

stepTime = 0.0125;
mousePressed = false;

mouseprev_x = mouse_x;
mouseprev_y = mouse_y;
//////SLIDER VARIABLES
//Advection
//Step 2: Viscous Diffusion
jacobiIterations = 100;				//Range 20-100
defaultViscosity = 0.001;
defaultViscAlpha = 1.0;
defaultViscBeta = 0.20;
//Vorticity Confinement
defaultEpsillon = 0.00024414;
defaultCurl = 0.3;
//Projection
defaultJacobiAlpha = (-1.0);
defaultJacobiBeta = (0.25);
////GUI
velocityDissipation = 1.0;//velocityDissipation.returnValue;
materialDissipation = 1.0;//materialDissipation.returnValue;

diffusionA = 1.0;//diffusionA.returnValue;
diffusionB = 1.0;//diffusionB.returnValue;
velocityPart = 1.0;//velocityPart.returnValue;
viscosity = 0.99;//viscosity.returnValue;
buoyancyAlpha = 1.0;
buoyancyBeta = 1.0;

scale = 1.0;
size = 1.0

scr_createEmptySurfaces();
scr_shaderUniforms();
scr_fluidEnums();
DISPLAY_FIELD=DISPLAY_FIELD.VELOCITY;

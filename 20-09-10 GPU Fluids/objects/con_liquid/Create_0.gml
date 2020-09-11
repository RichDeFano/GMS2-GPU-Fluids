
room_w = room_width;
room_h = room_height;

wScale = 1;
hScale = 1;


mouse_x_previous = mouse_x; 
mouse_y_previous = mouse_y;
stepTime = 0.00125;
mousePressed = false;


scr_createEmptySurfaces();

//////SLIDER VARIABLES
//Advection
stepTimeInterval= 0.0125;
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
velocityScale = 1.0;//velocityScale.returnValue;
materialDissipation = 1.0;//materialDissipation.returnValue;
materialScale = 1.0;//aterialScale.returnValue;
diffusionA = 1.0;//diffusionA.returnValue;
diffusionB = 1.0;//diffusionB.returnValue;
velocityPart = 1.0;//velocityPart.returnValue;
viscosity = 0.99;//viscosity.returnValue;
vorticitySize = 1.0;//vorticitySize.returnValue;
vorticityScale = 1.0;//vorticityScale.returnValue;
vorticityFSize = 1.0;//vorticityFSize.returnValue;
vorticityFScale = 1.0;//vorticityFScale.returnValue;
buoyancyAlpha = 1.0;
buoyancyBeta = 1.0;
///buoyancy
buoyAlphaF = shader_get_uniform(shd_buoyancyForce,"alpha");
buoyBetaF = shader_get_uniform(shd_buoyancyForce,"beta");

buoyAlpha = shader_get_uniform(shd_buoyancy,"alpha");
buoyBeta = shader_get_uniform(shd_buoyancy,"beta");
///
//\Slab velocity, Slab density, Slab pressure, Slab diffusion, Slab divergence, Slab vorticity,
//Advection

size = shader_get_uniform(shd_advection,"rSize");
scale = shader_get_uniform(shd_advection,"rScale");

time = shader_get_uniform(shd_advection,"timestep");
diss = shader_get_uniform(shd_advection,"dissipation");
//Viscous Diffusion

//Jacobi 


alph = shader_get_uniform(shd_jacobi,"alpha");
beta = shader_get_uniform(shd_jacobi,"rBeta");
//Divergence

hScale = shader_get_uniform(shd_divergence,"rHalfScale");


//Vorticity


vorSize = shader_get_uniform(shd_vorticity,"size");
vorScale = shader_get_uniform(shd_vorticity,"rHalfScale");


vorForceSize = shader_get_uniform(shd_vorticityForce,"size");
vorForceScale = shader_get_uniform(shd_vorticityForce,"rHalfScale");
vorForceTime = shader_get_uniform(shd_vorticityForce,"timestep");
vorForceEp = shader_get_uniform(shd_vorticityForce,"epsilon");
vorForceCurl = shader_get_uniform(shd_vorticityForce,"curl");


///Boundary conditions
boundW = shader_get_uniform(shd_velocityBoundary,"width");
boundH = shader_get_uniform(shd_velocityBoundary,"height");

pBoundW = shader_get_uniform(shd_pressureBoundary,"width");
pBoundH = shader_get_uniform(shd_pressureBoundary,"height");



//Gradient Subtraction

//Field Addition
ascale = shader_get_uniform(shd_addVelocity,"scaleA");
bscale = shader_get_uniform(shd_addVelocity,"scaleB");

ascaleD = shader_get_uniform(shd_addDiffusion,"scaleA");
bscaleD  = shader_get_uniform(shd_addDiffusion,"scaleB");

///Viewing fields
bias = shader_get_uniform(shd_visualize,"bias");
scale = shader_get_uniform(shd_visualize,"scale");
maxval = shader_get_uniform(shd_visualize,"maxVal");
alph = shader_get_uniform(shd_visualize,"alph");
isVector = shader_get_uniform(shd_visualize,"isVector");
isNegative = shader_get_uniform(shd_visualize,"isNegative");

//gaussian splat

pt = shader_get_uniform(shd_gaussianSplat,"point");
r = shader_get_uniform(shd_gaussianSplat,"radius");
fC = shader_get_uniform(shd_gaussianSplat,"fillColor");

//velocity splat
vpt = shader_get_uniform(shd_splat, "point");
vr	= shader_get_uniform(shd_splat,"radius");
vfC = shader_get_uniform(shd_splat,"fillColor");

//texelSize = shader_get_uniform(shd_visualiseField,"texel_size");
//surf_world = global.fluidSurface;
fluid_enums();
DISPLAY_FIELD=DISPLAY_FIELD.VELOCITY;
/*

uniform vec3 bias;
uniform vec2 scale;
uniform float maxVal;

uniform sampler2D vector_field;
uniform vec2 rSize;
uniform float rScale;
uniform float timestep
uniform float dissipation;

uniform sampler2D velocity;
uniform sampler2D advected;
///
uniform float alpha;
uniform float rBeta;  // reciprocal beta term

uniform sampler2D pressure;
uniform sampler2D divergence;
///
out float divergence;
uniform float rHalfScale;
uniform sampler2D velocity;


scale = 1.0;
timestep = 0.125;
velocityDissipation = 0.99

advect(velocity.read,velocity.read,velocity.write,width,height,SCALE,TIMESETP,VELOCITY_DISSIPATION)
swaPVectorFields


advect(velocity,advected,output,width,height,scale,timesetp,dissipation)
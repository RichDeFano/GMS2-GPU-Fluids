
room_w = room_width;
room_h = room_height;

wScale = 1;
hScale = 1;


mouse_x_previous = mouse_x; 
mouse_y_previous = mouse_y;
stepTime = 0;
mousePressed = false;


scr_createEmptySurfaces();

//////SLIDER VARIABLES
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


///
//\Slab velocity, Slab density, Slab pressure, Slab diffusion, Slab divergence, Slab vorticity,
//Advection

size = shader_get_uniform(shd_advection,"rSize");
scale = shader_get_uniform(shd_advection,"rScale");
time = shader_get_uniform(shd_advection,"timestep");
diss = shader_get_uniform(shd_advection,"dissipation");
//Viscous Diffusion

//Jacobi 


alph = shader_get_uniform(shd_pressureJacobi,"alpha");
beta = shader_get_uniform(shd_pressureJacobi,"rBeta");
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
boundW = shader_get_uniform(shd_boundary,"width");
boundH = shader_get_uniform(shd_boundary,"height");



//Gradient Subtraction

//Field Addition
ascale = shader_get_uniform(shd_add,"scaleA");
bscale = shader_get_uniform(shd_add,"scaleB");

///Viewing fields
bias = shader_get_uniform(shd_visualize,"bias");
scale = shader_get_uniform(shd_visualize,"scale");
maxval = shader_get_uniform(shd_visualize,"maxVal");

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
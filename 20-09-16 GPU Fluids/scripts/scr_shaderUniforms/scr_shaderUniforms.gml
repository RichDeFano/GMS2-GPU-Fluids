///buoyancy
buoyAlpha = shader_get_uniform(shd_buoyancy,"alpha");
buoyBeta = shader_get_uniform(shd_buoyancy,"beta");
//Advection
adSize = shader_get_uniform(shd_advection,"rSize");
adScale = shader_get_uniform(shd_advection,"rScale");

time = shader_get_uniform(shd_advection,"timestep");
diss = shader_get_uniform(shd_advection,"dissipation");
//Viscous Diffusion
diffAlph = shader_get_uniform(shd_jacobiDiffusion,"alpha");
diffBeta = shader_get_uniform(shd_jacobiDiffusion,"rBeta");
//Jacobi 
alph = shader_get_uniform(shd_jacobi,"alpha");
beta = shader_get_uniform(shd_jacobi,"rBeta");
//Divergence
divScale = shader_get_uniform(shd_divergence,"rHalfScale");
//Vorticity
vorSize = shader_get_uniform(shd_vorticity,"size");
vorScale = shader_get_uniform(shd_vorticity,"rHalfScale");
vorForceSize = shader_get_uniform(shd_vorticityForce,"size");
vorForceScale = shader_get_uniform(shd_vorticityForce,"rHalfScale");
vorForceTime = shader_get_uniform(shd_vorticityForce,"timestep");
vorForceEp = shader_get_uniform(shd_vorticityForce,"epsilon");
vorForceCurl = shader_get_uniform(shd_vorticityForce,"curl");
//Gradient Subtraction
gradScale = shader_get_uniform(shd_subtractGradient,"rHalfScale");
///Boundary conditions
boundW = shader_get_uniform(shd_velocityBoundary,"width");
boundH = shader_get_uniform(shd_velocityBoundary,"height");
//Field Addition
ascale = shader_get_uniform(shd_addVectors,"scaleA");
bscale = shader_get_uniform(shd_addVectors,"scaleB");
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
spSize = shader_get_uniform(shd_gaussianSplat,"size");
spScale = shader_get_uniform(shd_gaussianSplat,"scale");
//velocity splat
vpt = shader_get_uniform(shd_splat, "point");
vr	= shader_get_uniform(shd_splat,"radius");
vfC = shader_get_uniform(shd_splat,"fillColor");
///new
prevPt = shader_get_uniform(shd_gaussVelocity,"prevPoint");
gaussTime = shader_get_uniform(shd_gaussVelocity,"timestep");
gaussPt = shader_get_uniform(shd_gaussVelocity,"point");
gaussRad = shader_get_uniform(shd_gaussVelocity,"radius");

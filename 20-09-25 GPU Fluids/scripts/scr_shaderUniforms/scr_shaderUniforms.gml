///buoyancy
buoyAlpha = shader_get_uniform(shd_buoyancy,"alpha");
buoyBeta = shader_get_uniform(shd_buoyancy,"beta");
/*
//Advection
adSize = shader_get_uniform(shd_advection,"rSize");
adScale = shader_get_uniform(shd_advection,"rScale");
time = shader_get_uniform(shd_advection,"time");
diss = shader_get_uniform(shd_advection,"dissipation");
*/
texSize = shader_get_uniform(shd_velocityAdvection,"texelSize");
useMac = shader_get_uniform(shd_velocityAdvection,"useMac");
adDiss = shader_get_uniform(shd_velocityAdvection,"dissipationValues");
macW = shader_get_uniform(shd_velocityAdvection,"macWeight");
time = shader_get_uniform(shd_velocityAdvection,"time");




densDiss = shader_get_uniform(shd_densityAdvection,"dissipation");
densTime = shader_get_uniform(shd_densityAdvection,"time");
densTexSize = shader_get_uniform(shd_densityAdvection,"texelSize");
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

//gaussian splat
pt = shader_get_uniform(shd_addDensity,"point");
r = shader_get_uniform(shd_addDensity,"radius");
fC = shader_get_uniform(shd_addDensity,"fillColor");
spSize = shader_get_uniform(shd_addDensity,"size");
spScale = shader_get_uniform(shd_addDensity,"scale");

prevPt = shader_get_uniform(shd_gaussVelocity,"prevPoint");
gaussTime = shader_get_uniform(shd_gaussVelocity,"timestep");
gaussPt = shader_get_uniform(shd_gaussVelocity,"point");
gaussRad = shader_get_uniform(shd_gaussVelocity,"radius");

//visuals
isVec = shader_get_uniform(shd_fieldVisualization,"isVector");
isSig = shader_get_uniform(shd_fieldVisualization,"isScalar");
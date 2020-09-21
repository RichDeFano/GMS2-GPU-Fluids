scr_initializeFluid();
//gpu_set_blendenable(false);
gpu_set_blendmode_ext(bm_src_alpha,bm_inv_src_alpha);
//gpu_set_blendenable(true);
if !gpu_get_texfilter()	{gpu_set_texfilter(true);}

if !gpu_get_texrepeat()	{gpu_set_texrepeat(true);}


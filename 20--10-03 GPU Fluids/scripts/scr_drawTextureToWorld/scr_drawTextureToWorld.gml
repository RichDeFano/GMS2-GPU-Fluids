//var tex;
var debugString = argument0;
var surf_input = argument1;
var isVect = argument2;
var isSigned = argument3;

//gpu_set_blendmode_ext(bm_src_alpha,bm_one);

surface_set_target(surf_world);
draw_clear_alpha(c_black,0); 
surface_reset_target();

surface_set_target(surf_world);
	shader_set(shd_fieldVisualization);
		shader_set_uniform_f(isVec,isVect);
		shader_set_uniform_f(isSig,isSigned);
		//texture_set_stage(shader_get_sampler_index(shd_fieldVisualization,"visual_field"),surface_get_texture(surf_input));
			draw_surface(surf_input,0,0);
	shader_reset();
surface_reset_target();

draw_surface(surf_world,0,0);
draw_text(0,0,debugString);
//gpu_set_blendmode(bm_normal);
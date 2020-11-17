
gpu_set_blendmode_ext(bm_src_color,bm_inv_src_color);
	surface_set_target(surf_tempDensity);
		shader_set(shd_addDensity)
			shader_set_uniform_f(pt,mouse_x,mouse_y);
			shader_set_uniform_f(r,1.0);
			texture_set_stage(shader_get_sampler_index(shd_addDensity,"scalar_field"),surface_get_texture(surf_density));
				draw_surface(surf_density,0,0);		
		shader_reset();
	surface_reset_target();
		scr_swapFields(surf_tempStorage,surf_tempDensity,surf_density);
gpu_set_blendmode(bm_normal);

gpu_set_blendmode_ext(bm_src_color,bm_inv_src_color);
	surface_set_target(surf_tempVelocity);
		shader_set(shd_gaussVelocity);
			shader_set_uniform_f(prevPt,mouseprev_x,mouseprev_y);
			shader_set_uniform_f(gaussPt,mouse_x,mouse_y);
			shader_set_uniform_f(gaussRad,1.0);
			shader_set_uniform_f(gaussTime,stepTime);
			texture_set_stage(shader_get_sampler_index(shd_addDensity,"vector_field"),surface_get_texture(surf_velocity));
				draw_surface(surf_velocity,0,0);
		shader_reset();
	surface_reset_target();
		scr_swapFields(surf_tempStorage,surf_tempVelocity,surf_velocity);
gpu_set_blendmode(bm_normal);
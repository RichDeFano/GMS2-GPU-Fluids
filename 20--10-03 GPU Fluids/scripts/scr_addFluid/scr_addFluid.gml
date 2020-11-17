gpu_set_blendmode(bm_normal);
		if (mousePressed == true){
			surface_set_target(surf_tempDensity);
				shader_set(shd_addDensity)
					shader_set_uniform_f(pt,mouse_x,mouse_y);
					shader_set_uniform_f(r,1.0*scale);
					//shader_set_uniform_f(fC,255.0,0.0,0.0);
					texture_set_stage(shader_get_sampler_index(shd_addDensity,"scalar_field"),surface_get_texture(surf_density));
						draw_surface(surf_density,0,0);		
				shader_reset();
			surface_reset_target();
				scr_swapFields(surf_tempStorage,surf_tempDensity,surf_density);

		
		surface_set_target(surf_tempVelocity);
			shader_set(shd_gaussVelocity);
				shader_set_uniform_f(prevPt,mouseprev_x,mouseprev_y);
				shader_set_uniform_f(gaussPt,mouse_x,mouse_y);
				shader_set_uniform_f(gaussRad,1.0*scale);
				shader_set_uniform_f(gaussTime,stepTime);
				texture_set_stage(shader_get_sampler_index(shd_addDensity,"vector_field"),surface_get_texture(surf_velocity));
					draw_surface(surf_velocity,0,0);
			shader_reset();
		surface_reset_target();
			scr_swapFields(surf_tempStorage,surf_tempVelocity,surf_velocity);
			
		}
gpu_set_blendmode(bm_normal);
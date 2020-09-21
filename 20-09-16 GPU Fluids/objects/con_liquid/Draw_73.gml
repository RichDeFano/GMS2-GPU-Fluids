/// @description Insert description here
// You can write your code in this editor
        switch (DISPLAY_FIELD) {
            case DISPLAY_FIELD.DENSITY:
                scr_drawTextureToWorld("Density",surf_density);
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.VELOCITY:
                //texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_velocity));
                //shader_set_uniform_f(maxval, 10.0);	//32
                //shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//shader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,true);
				//shader_set_uniform_f(isNegative,true);
				//surface_set_target(surf_world);
				scr_drawTextureToWorld("Velocity",surf_velocity);
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.PRESSURE:
                //texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_pressure));
                //shader_set_uniform_f(maxval, 10.0);	//64
                //shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//shader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,false);
				//shader_set_uniform_f(isNegative,false);
				scr_drawTextureToWorld("Pressure",surf_pressure);
                break;
            case DISPLAY_FIELD.DIVERGENCE:
                //texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_divergence));
                //shader_set_uniform_f(maxval, 10.0);		///1.0
                //shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//shader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,false);
				//shader_set_uniform_f(isNegative,true);
				scr_drawTextureToWorld("Divergence",surf_divergence);
                break;
			case DISPLAY_FIELD.DIFFUSION:
                //texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_diffusion));
                //shader_set_uniform_f(maxval, 10.0);
                //shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//shader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,false);
				//shader_set_uniform_f(isNegative,false);
				scr_drawTextureToWorld("Diffusion",surf_diffusion);
                break;
            case DISPLAY_FIELD.VORTICITY:
               // texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_vorticity));
                //shader_set_uniform_f(maxval, 10.0);
                //shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//hader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,false);
				//shader_set_uniform_f(isNegative,true);
				scr_drawTextureToWorld("Vorticity",surf_vorticity);
                break;
			case DISPLAY_FIELD.TEMPERATURE:
                //texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_vorticity));
                //shader_set_uniform_f(maxval, 10.0);
                //shader_set_uniform_f(bias, 0.0, 0.0, 0.0);
				//shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				//shader_set_uniform_f(alph,1.0);
				//shader_set_uniform_f(isVector,false);
				//shader_set_uniform_f(isNegative,false);
				scr_drawTextureToWorld("Temperature",surf_temperature);
                break;
		
        }
//gpu_set_blendmode_ext(bm_src_alpha,bm_inv_src_alpha);

//shader_set(shd_visualize)
//scr_swapFields(tempStorage,surf_density,surf_tempDensity);

//stepTime += stepTime;
//draw_text(600,200,stepTime);
//shader_reset();
//gpu_set_blendmode(bm_normal);
//scr_swapAllFields();
mouseprev_x = mouse_x;
mouseprev_y = mouse_y;
//draw_surface(surf_world,0,0);

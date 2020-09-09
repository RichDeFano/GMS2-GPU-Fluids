/// @description Insert description here
// You can write your code in this editor

//draw_surface(surf_density,0,0);

shader_set(shd_visualize)

        switch (DISPLAY_FIELD) {
            case DISPLAY_FIELD.DENSITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_density));
				shader_set_uniform_f(alph,1.0);
                shader_set_uniform_f(maxval, 1.0);
                shader_set_uniform_f(bias, 0.0, 0.0, 0.0);
				shader_set_uniform_f(isVector,false);
				shader_set_uniform_f(isNegative,false);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				draw_surface(surf_density,0,0);
				draw_text(0,0,"DISPLAY MODE: DENSITY");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.VELOCITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_velocity));
                shader_set_uniform_f(maxval, 32.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,true);
				shader_set_uniform_f(isNegative,true);
				draw_surface(surf_velocity,0,0);
				draw_text(0,0,"DISPLAY MODE: VELOCITY");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.PRESSURE:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_pressure));
                shader_set_uniform_f(maxval, 64.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,false);
				draw_surface(surf_pressure,0,0);
				draw_text(0,0,"DISPLAY MODE: PRESSURE");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.DIVERGENCE:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_divergence));
                shader_set_uniform_f(maxval, 1.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,false);
				shader_set_uniform_f(isNegative,true);
				draw_surface(surf_divergence,0,0);
				draw_text(0,0,"DISPLAY MODE: DIVERGENCE");
				//shader_reset();
				//surface_reset_target();
                break;
			case DISPLAY_FIELD.DIFFUSION:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_diffusion));
                shader_set_uniform_f(maxval, 1.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,false);
				shader_set_uniform_f(isNegative,false);
				draw_surface(surf_diffusion,0,0);
				draw_text(0,0,"DISPLAY MODE: DIFFUSION");
				//shader_reset();
				//surface_reset_target();
                break;
            case DISPLAY_FIELD.VORTICITY:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_vorticity));
                shader_set_uniform_f(maxval, 4.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,false);
				shader_set_uniform_f(isNegative,true);
				draw_surface(surf_vorticity,0,0);
				draw_text(0,0,"DISPLAY MODE: VORTICITY");
				//shader_reset();
				//surface_reset_target();
                break;
			case DISPLAY_FIELD.TEMPERATURE:
                texture_set_stage(shader_get_sampler_index(shd_visualize,"vector_field"),surface_get_texture(surf_vorticity));
                shader_set_uniform_f(maxval, 4.0);
                shader_set_uniform_f(bias, 0.5, 0.5, 0.5);
				shader_set_uniform_f(scale,1.0/room_w,1.0/room_h);
				shader_set_uniform_f(alph,1.0);
				shader_set_uniform_f(isVector,false);
				shader_set_uniform_f(isNegative,false);
				draw_surface(surf_temperature,0,0);
				draw_text(0,0,"DISPLAY MODE: TEMPERATURE");
				//shader_reset();
				//surface_reset_target();
                break;
		
        }
//stepTime += stepTime;
//draw_text(600,200,stepTime);
shader_reset();
gpu_set_blendmode(bm_normal);
	switch (DISPLAY_FIELD) {
		case DISPLAY_FIELD.DENSITY:
	        scr_drawTextureToWorld("Density",surf_density,false,false);
		break;
    
		case DISPLAY_FIELD.VELOCITY:
			scr_drawTextureToWorld("Velocity",surf_velocity,true,false);
		break;
    
		case DISPLAY_FIELD.PRESSURE:
			scr_drawTextureToWorld("Pressure",surf_pressure,false,false);
		break;
   
		case DISPLAY_FIELD.DIVERGENCE:
			scr_drawTextureToWorld("Divergence",surf_divergence,false,true);
		break;

		case DISPLAY_FIELD.DIFFUSION:
			scr_drawTextureToWorld("Diffusion",surf_diffusion,false,false);
		break;
	
		case DISPLAY_FIELD.VORTICITY:
			scr_drawTextureToWorld("Vorticity",surf_vorticity,false,true);
		break;

	case DISPLAY_FIELD.TEMPERATURE:
		scr_drawTextureToWorld("Temperature",surf_temperature,false,false);
	break;
	}
gpu_set_blendmode(bm_normal);
mouseprev_x = mouse_x;
mouseprev_y = mouse_y;
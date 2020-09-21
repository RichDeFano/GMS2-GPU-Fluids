
//0 = tempstorage
//1 = temp
//2 = reg
////Temp gets written to
///reg goes to temp
//temp goes to old 
surface_copy(argument0,0,0,argument2);
surface_copy(argument2,0,0,argument1);
surface_copy(argument1,0,0,argument0);
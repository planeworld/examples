local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "earth")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 6371010)
pw.physics.shp_set_mass(idShp, 5.97219e+24)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -93103239617.90498, -119056575214.1636)
pw.physics.obj_set_velocity(idObj, 23234.268333125387, -18659.959636517608)
pw.physics.obj_set_angle_vel(idObj, 0.00007292115)
return M

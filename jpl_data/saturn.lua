local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "saturn")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 60268000)
pw.physics.shp_set_mass(idShp, 5.68319e+26)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -955621664399.574, -1133240385539.9082)
pw.physics.obj_set_velocity(idObj, 7131.899378584912, -6502.237240945347)
pw.physics.obj_set_angle_vel(idObj, 0.000163785)
return M

local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "venus")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 6051800)
pw.physics.shp_set_mass(idShp, 4.8685e+24)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, 64071003154.02987, -88101377192.08041)
pw.physics.obj_set_velocity(idObj, 28335.89812495124, 20579.892384573817)
pw.physics.obj_set_angle_vel(idObj, -2.992449223677638e-7)
return M

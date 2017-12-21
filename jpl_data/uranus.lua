local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "uranus")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 25559000)
pw.physics.shp_set_mass(idShp, 8.68103e+25)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, 2922260359566.172, 659035807763.0343)
pw.physics.obj_set_velocity(idObj, -1626.8740186488599, 6604.061097798658)
pw.physics.obj_set_angle_vel(idObj, 0.0001012)
return M

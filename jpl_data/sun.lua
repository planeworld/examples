local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "sun")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 696300000)
pw.physics.shp_set_mass(idShp, 1.988544e+30)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_angle_vel(idObj, 0.0000028653290845717256)
return M

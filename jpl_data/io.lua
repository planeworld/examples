local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "io")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 1821300)
pw.physics.shp_set_mass(idShp, 8.933e+22)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, NaN, NaN)
pw.physics.obj_set_velocity(idObj, NaN, NaN)
return M

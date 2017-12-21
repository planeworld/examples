local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "amalthea")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 131000)
pw.physics.shp_set_mass(idShp, undefined)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, NaN, NaN)
pw.physics.obj_set_velocity(idObj, NaN, NaN)
return M

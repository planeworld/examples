local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "himalia")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 85000)
pw.physics.shp_set_mass(idShp, undefined)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -339131872558.8629, 715441283922.872)
pw.physics.obj_set_velocity(idObj, -8178.847156133495, -2756.833718966849)
return M

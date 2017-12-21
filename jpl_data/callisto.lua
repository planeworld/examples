local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "callisto")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 2403000)
pw.physics.shp_set_mass(idShp, 1076)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -342427463239.0055, 705815364562.4865)
pw.physics.obj_set_velocity(idObj, -5744.046455117414, -5485.356897498423)
return M

local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "phobos")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 13100)
pw.physics.shp_set_mass(idShp, 10800000000000000)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -195074831316.27084, -135440983676.26471)
pw.physics.obj_set_velocity(idObj, 17591.31840970459, -18081.161291289827)
return M

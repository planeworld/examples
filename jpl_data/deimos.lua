local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "deimos")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 7800)
pw.physics.shp_set_mass(idShp, 1800000000000000)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -195065781480.3834, -135454321287.18497)
pw.physics.obj_set_velocity(idObj, 16648.570269499294, -18032.348315316667)
return M

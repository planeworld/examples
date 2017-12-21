local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "mercury")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 2440000)
pw.physics.shp_set_mass(idShp, 3.302e+23)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -37037365920.25637, 34009865269.316273)
pw.physics.obj_set_velocity(idObj, -37948.54173746507, -30146.78569954514)
pw.physics.obj_set_angle_vel(idObj, 0.0000012400130301098858)
return M

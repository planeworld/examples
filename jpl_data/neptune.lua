local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "neptune")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 24766000)
pw.physics.shp_set_mass(idShp, 1.0241e+26)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, 4075020235815.2427, -1871570521675.106)
pw.physics.obj_set_velocity(idObj, 2224.355569535702, 4961.765573164074)
pw.physics.obj_set_angle_vel(idObj, 0.0001083)
return M

local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "jupiter")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 71492000)
pw.physics.shp_set_mass(idShp, 1.89813e+27)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -340594202816.51086, 706132078174.9547)
pw.physics.obj_set_velocity(idObj, -12040.855242563428, -5106.639461701904)
pw.physics.obj_set_angle_vel(idObj, 0.000175865)
return M

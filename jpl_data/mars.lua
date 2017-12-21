local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "mars")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 3389900)
pw.physics.shp_set_mass(idShp, 6.4185e+23)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -195073519163.95682, -135449636307.83136)
pw.physics.obj_set_velocity(idObj, 15419.186410890201, -18669.89478286345)
pw.physics.obj_set_angle_vel(idObj, 0.00007088218111185525)
return M

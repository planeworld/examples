local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "europa")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 1565000)
pw.physics.shp_set_mass(idShp, 4.797e+22)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -340998131306.9195, 705393952605.7599)
pw.physics.obj_set_velocity(idObj, -8694.850548892437, -18761.07310585991)
return M

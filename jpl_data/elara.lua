local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "elara")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 40000)
pw.physics.shp_set_mass(idShp, undefined)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -334893397792.9314, 698929960852.4463)
pw.physics.obj_set_velocity(idObj, -15123.806251504688, -4865.580665363168)
return M

local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "ganymede")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 2634000)
pw.physics.shp_set_mass(idShp, 1482)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -340786724342.8417, 704891254884.3053)
pw.physics.obj_set_velocity(idObj, -14497.42522875913, -11636.163964292524)
return M

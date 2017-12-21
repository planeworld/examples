local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "sinope")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 14000)
pw.physics.shp_set_mass(idShp, undefined)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -368222736456.6751, 711416962446.9281)
pw.physics.obj_set_velocity(idObj, -13227.105280821123, -3861.434863768364)
return M

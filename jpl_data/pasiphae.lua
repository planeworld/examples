local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "pasiphae")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 18000)
pw.physics.shp_set_mass(idShp, undefined)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -349191543573.35284, 688649778002.3817)
pw.physics.obj_set_velocity(idObj, -11741.26875958688, -3265.5502962585565)
return M

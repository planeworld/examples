local M={}
local idObj = pw.system.create_obj()
pw.physics.obj_set_name(idObj, "moon")
local idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, undefined)
pw.physics.shp_set_mass(idShp, 7.349e+22)
pw.system.obj_add_shp(idObj, idShp)
pw.physics.obj_set_position(idObj, -93436982025.9187, -119242871291.81195)
pw.physics.obj_set_velocity(idObj, 22208.678790884045, -18237.79814985306)
return M

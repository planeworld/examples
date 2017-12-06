-- Sputnik orbiting the earth
        
-- Import input script
require('pw_input_default')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)
pw.system.set_data_path_visuals("./")
pw.system.create_universe(23479, 10000)

-- Create Sputnik
idObjSputnik = pw.system.create_obj()
--io.write(idObjSputnik)
idShpSputnikBody = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShpSputnikBody, 0.29)
pw.physics.shp_set_mass(idShpSputnikBody, 83.6)

idShpSputnikAntenna1 = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpSputnikAntenna1,
    { -0.29,  0.0,
      -0.50, -1.5 }
)

idShpSputnikAntenna2 = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpSputnikAntenna2,
    {  0.00,  0.0,
       0.00, -1.6 }
)

idShpSputnikAntenna3 = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpSputnikAntenna3,
    {  0.29,  0.0,
       0.50, -1.5 }
)

pw.system.obj_add_shp(idObjSputnik, idShpSputnikBody)
pw.system.obj_add_shp(idObjSputnik, idShpSputnikAntenna1)
pw.system.obj_add_shp(idObjSputnik, idShpSputnikAntenna2)
pw.system.obj_add_shp(idObjSputnik, idShpSputnikAntenna3)

--pw.physics.obj_set_name(idObjSputnik, "Sputnik")
pw.physics.obj_set_position(idObjSputnik, 0.0, 6954607.812238137)
pw.physics.obj_set_angle(idObjSputnik, math.rad(90))
pw.physics.obj_set_velocity(idObjSputnik, -7064.774995603303, 0.0)
pw.physics.obj_set_angle_vel(idObjSputnik, 0.0010158408908653759)
-- kinematics_reference="Earth"
-- dynamics="true"
-- gravity="true"
-- inertia="100.0"


idObjEarth=pw.system.create_obj()
--pw.physics.obj_set_name(idObjEarth, "Earth")
pw.physics.obj_set_angle_vel(idObjEarth, 0.0000727220521664304)
idShpEarth=pw.system.create_shp("shp_planet")
pw.physics.shp_set_radius(idShpEarth, 6378.16e3)
pw.physics.shp_set_mass(idShpEarth, 5.97219e24)
-- height_max="8000.0"
-- sea_level="-0.2"
-- ground_resolution="0.001"
-- inertia="8.0e37"
-- dynamics="true"
-- gravity="true"
pw.system.obj_add_shp(idObjEarth, idShpEarth)       
pw.physics.obj_disable_dynamics(idObjEarth)




-- Setup camera
idCam01 = pw.system.create_camera()
pw.system.cam_attach_to(idCam01, idObjSputnik)
pw.system.cam_set_resolution_mpx(idCam01, 0.1)
pw.system.cam_rotate_by(idCam01, math.rad(-90))


-- Pause simulation
pw.system.pause()

-- Setup callback functions
pw.system.register_lua_callback("e_lua_update", "update")
pw.system.register_lua_callback("toggle_pause", "start_simulation")

function update()
    -- Callback to "e_lua_update" event which is called with 30 Hz
    -- (given by "pw.system.set_frequency_lua(30)", see above)
    -- Regular updates might be implemented here, additional callbacks
    -- to the update are possible
end

function start_simulation()
    -- On simulation start close window
end

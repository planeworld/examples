
        
-- Import input script
require('pw_input_default')

astrodynamics = require('lua_modules.astrodynamics')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)
pw.system.set_data_path_visuals("./")
pw.system.create_universe(23479, 10000)

-- Create earth
require('jpl_data.sun')
require('jpl_data.mercury')
require('jpl_data.venus')
require('jpl_data.earth')
require('jpl_data.mars')
require('jpl_data.jupiter')
require('jpl_data.saturn')
require('jpl_data.uranus')
require('jpl_data.neptune')


-- Setup camera
idCam01 = pw.system.create_camera()
-- pw.system.cam_attach_to(idCam01, idObjAsteroid)
pw.system.cam_set_resolution_mpx(idCam01, 50000)


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

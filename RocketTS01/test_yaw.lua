  -- Import input script
require('../pw_input_default')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)
pw.system.set_data_path_visuals("./")
pw.visuals.toggle_grid()
pw.system.toggle_fullscreen()

Rocket = require('RocketTS01/TS01')

-- Setup main camera
idCam01 = pw.system.create_camera()
--pw.system.cam_set_position(idCam01, -200.0, 6000100.0)
--pw.system.cam_attach_to(idCam01, Rocket.Id)
pw.system.cam_set_resolution_pxm(idCam01, 10)

--Rocket.setThrust(100111000.0)
-- Pause simulation
pw.system.pause()

-- Setup callback functions
pw.system.register_lua_callback("e_lua_update", "update")
pw.system.register_lua_callback("toggle_pause", "start_simulation")

function update()
  Rocket.yawcontroller(math.rad(90))
end

function start_simulation()

end

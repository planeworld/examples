-- Import input script
require('planeworld/pw_input_default')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)

pw.system.init_visuals()
pw.system.init_physics()

pw.visuals.toggle_grid()
--pw.system.toggle_fullscreen()


-- Create Arrow
local idObjArrow = pw.system.create_obj()
local idShpArrow1 = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpArrow1,
    {-40.0, 0.0,
      40.0, 0.0}
)
pw.system.obj_add_shp(idObjArrow, idShpArrow1)
local idShpArrow2 = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpArrow2,
    { 35.0,  3.0,
      40.0,  0.0,
      35.0, -3.0,
      40.0,  0.0}
)
pw.system.obj_add_shp(idObjArrow, idShpArrow2)

pw.physics.obj_set_angle(idObjArrow, math.rad(90))

Rocket = require('RocketTS01.TS01')

-- Setup main camera
idCam01 = pw.system.create_camera()
pw.system.cam_set_resolution_pxm(idCam01, 10)
--pw.system.cam_fit_object(idCam01, Rocket.Id)


-- Create a text window
idWin01=pw.system.create_window()
idWdg01=pw.system.create_widget("text")
pw.system.widget_set_text(idWdg01, "This example includes several test of the yaw controller. Pressing the space bar will start the next test.")
pw.system.win_set_widget(idWin01, idWdg01)
pw.system.win_set_title(idWin01, "Test Yaw Controller")
--pw.system.win_center_keep(idWin01)
Win01_Open = true

local callController = function()

end

local testqueue = {}

table.insert(testqueue, function ()
    pw.system.resume()
  pw.system.widget_set_text(idWdg01, "In this test, the rocket shall rotate to a specific angle. The controller uses the fastes solution (e.g. if the rocket already roatates, the controller might accelerate in this direction, although the angle is larger.")
  pw.physics.obj_set_angle(idObjArrow, math.rad(180))
  callController = function()
    Rocket.yawcontroller(math.rad(90))
  end
  pw.system.key_action[57]=table.remove(testqueue, 1)
end
)

table.insert(testqueue, function ()
  pw.system.widget_set_text(idWdg01, "Same controller with another angle.")
  pw.physics.obj_set_angle(idObjArrow, math.rad(0))
  callController = function()
    Rocket.yawcontroller(math.rad(-90))
  end
  pw.system.key_action[57]=table.remove(testqueue, 1)
end
)

table.insert(testqueue, function ()
  pw.system.widget_set_text(idWdg01, "Now, the rocket shall perform a constant rotation.")
  pw.physics.obj_set_angle_vel(idObjArrow, math.rad(10))
  callController = function()
    Rocket.yawcontroller_angle_vel(math.rad(10))
  end
  pw.system.key_action[57]=table.remove(testqueue, 1)
end
)



pw.system.key_action[57] = table.remove(testqueue, 1)




-- Pause simulation
pw.system.pause()

-- Setup callback functions
pw.system.register_lua_callback("e_lua_update", "update")
pw.system.register_lua_callback("toggle_pause", "start_simulation")



function update()
  callController()
end

function start_simulation()

end

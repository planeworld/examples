-- Sputnik orbiting the earth
        
-- Import input script
require('planeworld/pw_input_default')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)
pw.system.create_universe(23479, 10000)

pw.system.init_visuals()
pw.system.init_physics()

-- Load solar system
require('jpl_data.sun')
require('jpl_data.mercury')
require('jpl_data.venus')
require('jpl_data.earth')
require('jpl_data.mars')
require('jpl_data.jupiter')
require('jpl_data.saturn')
require('jpl_data.uranus')
require('jpl_data.neptune')

-- Create object
idObj = pw.system.create_obj()

idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 60)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 50)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 40)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 30)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_circle")
pw.physics.shp_set_radius(idShp, 20)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShp,
    { 0,  40,
      20,  60,
      20, 120,
      0,  200,
      -20, 120,
      -20, 60,
    }
)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShp,
    { 20,  100,
      40,  140,
      40, 180,
      20,  120,
    }
)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShp,
    { -20,  100,
      -40,  140,
      -40, 180,
      -20,  120,
    }
)
pw.system.obj_add_shp(idObj, idShp)


idShp = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShp,
    { 50,  220,
      40,  220,
      40,  120,
      50,  115,
      60,  120,
      60,  220
    }
)
pw.system.obj_add_shp(idObj, idShp)

idShp = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShp,
    { -50,  220,
      -40,  220,
      -40,  120,
      -50,  115,
      -60,  120,
      -60,  220
    }
)
pw.system.obj_add_shp(idObj, idShp)

pw.physics.obj_set_angle(idObj, math.rad(-135))
pw.physics.obj_set_position(idObj, 1123454785432, -1865839457105)
pw.physics.obj_set_velocity(idObj, -1000, 1000)



-- Create a text window
idWin01=pw.system.create_window()
idWdg01=pw.system.create_widget("text")
pw.system.widget_set_text(idWdg01, "\n\n\nAn unidentified object was found in our solar system.\nPlease confirm and identify it!\n\nStart mission by pressing Spacebar")
pw.system.win_set_widget(idWin01, idWdg01)
pw.system.win_set_title(idWin01, "Incomming Message")
pw.system.win_center_keep(idWin01)

local tmp = pw.system.key_action[57];
pw.system.key_action[57] = function ()
  pw.system.win_close(idWin01);
  pw.system.key_action[57]=tmp;
  end;

  
-- Deactivate keys
pw.system.key_action[0] = function ()
  local idWin01=pw.system.create_window()
  local idWdg01=pw.system.create_widget("text")
  pw.system.widget_set_text(idWdg01, "\n\n\nDON'T CHEAT!\n\nPress Spacebar")
  pw.system.win_set_widget(idWin01, idWdg01)
  pw.system.win_set_title(idWin01, "Warning")
  pw.system.win_center_keep(idWin01)

  local tmp = pw.system.key_action[57];
  pw.system.key_action[57] = function ()
    pw.system.win_close(idWin01);
    pw.system.key_action[57]=tmp;
    end;
  end;

pw.system.key_action[67] = pw.system.key_action[0];
pw.system.key_action[10] = pw.system.key_action[0];
pw.system.key_action[12] = pw.system.key_action[0];
pw.system.key_action[13] = pw.system.key_action[0];

-- Setup camera
idCam01 = pw.system.create_camera()
pw.system.cam_set_resolution_mpx(idCam01, 1e9)


-- Setup callback functions
pw.system.register_lua_callback("e_lua_update", "update")

local time_warning= true;

function update()
  if time_warning and pw.physics.get_time() > 30 then
    local idWin01=pw.system.create_window()
    local idWdg01=pw.system.create_widget("text")
    pw.system.widget_set_text(idWdg01, "\n\n\nHurry up! We need to know what kind of object is entering the solar system.\n\nPress Spacebar")
    pw.system.win_set_widget(idWin01, idWdg01)
    pw.system.win_set_title(idWin01, "Incomming Message")
    pw.system.win_center_keep(idWin01)
    time_warning=false;
    
    local tmp = pw.system.key_action[57];
    pw.system.key_action[57] = function ()
      pw.system.win_close(idWin01);
      pw.system.key_action[57]=tmp;
      end;
    end;  
end

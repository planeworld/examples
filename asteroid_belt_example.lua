
        
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
earth = {}
earth.mass= 5.97219e24
earth.radius = 6378.16e3
-- 23h56m4.1s
earth.angle_vel = 2 * math.pi / ((23*60 + 56)*60 + 4.1)
idObjEarth=pw.system.create_obj()
pw.physics.obj_set_name(idObjEarth, "Earth")
pw.physics.obj_set_angle_vel(idObjEarth, earth.angle_vel)
idShpEarth=pw.system.create_shp("shp_planet")
pw.physics.shp_set_radius(idShpEarth, earth.radius)
pw.physics.shp_set_mass(idShpEarth, earth.mass)
-- height_max="8000.0"
-- sea_level="-0.2"
-- ground_resolution="0.001"
-- inertia="8.0e37"
-- gravity="true"
pw.system.obj_add_shp(idObjEarth, idShpEarth)       
pw.physics.obj_disable_dynamics(idObjEarth)


math.randomseed(1234)
-- Create asteroids
local asteroid = {}
asteroid.radius_min = 30
asteroid.radius_max = 300
asteroid.height_min = 1e7
asteroid.height_max = 1.2e7
local idObjAsteroid


for i = 10,1,-1 
do 
   print(i) 
end


for i=1,100,1 do
  io.write(i)
  idObjAsteroid = pw.system.create_obj()
  idShpAsteroid = pw.system.create_shp("shp_circle")
  pw.physics.shp_set_radius(idShpAsteroid, math.random(asteroid.radius_min, asteroid.radius_max))
  pw.physics.shp_set_mass(idShpAsteroid, 83.6)
  pw.system.obj_add_shp(idObjAsteroid, idShpAsteroid)


  local orbit_height = math.random(asteroid.height_min, asteroid.height_max)
  local angle = 2*math.pi*math.random()

  local velocity = math.sqrt(astrodynamics.G*earth.mass/orbit_height)
  pw.physics.obj_set_position(idObjAsteroid, orbit_height * math.sin(angle), orbit_height * math.cos(angle))
  pw.physics.obj_set_velocity(idObjAsteroid, velocity * math.cos(angle), - velocity * math.sin(angle))
  --pw.physics.obj_set_angle_vel(idObjSputnik, 0.0010158408908653759)
end





-- Setup camera
idCam01 = pw.system.create_camera()
--pw.system.cam_attach_to(idCam01, idObjAsteroid)
pw.system.cam_set_resolution_mpx(idCam01, 50000)
--pw.system.cam_rotate_by(idCam01, math.rad(-90))


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

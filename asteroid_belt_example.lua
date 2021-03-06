
        
-- Import input script
require('planeworld/pw_input_default')

astrodynamics = require('planeworld.astrodynamics')

-- Setup engine
pw.system.set_frequency_input(100)
pw.system.set_frequency_lua(30)
pw.system.set_frequency_physics(200)
pw.system.set_frequency_visuals(60)
pw.system.create_universe(23479, 10000)

pw.system.init_visuals()
pw.system.init_physics()

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
asteroid.radius_min = 300
asteroid.radius_max = 3000
asteroid.height_min = 1e7
asteroid.height_max = 1.2e7
local idObjAsteroid


for i=1,100,1 do
  idObjAsteroid = pw.system.create_obj()
  
  idShpAsteroid = pw.system.create_shp("shp_polygon")
  local vertices = {}
  for j=1,8,1 do
    local angle = 2*math.pi/8*j
    local radius = math.random(asteroid.radius_min, asteroid.radius_max)
    table.insert(vertices, radius * math.sin(angle))
    table.insert(vertices, radius * math.cos(angle))
  end
  pw.system.shp_set_vertices(idShpAsteroid, vertices)
  
  pw.system.obj_add_shp(idObjAsteroid, idShpAsteroid)


  local orbit_height = math.random(asteroid.height_min, asteroid.height_max)
  local angle = 2*math.pi*math.random()

  local velocity = math.sqrt(astrodynamics.G*earth.mass/orbit_height)
  pw.physics.obj_set_position(idObjAsteroid, orbit_height * math.sin(angle), orbit_height * math.cos(angle))
  pw.physics.obj_set_velocity(idObjAsteroid, velocity * math.cos(angle), - velocity * math.sin(angle))
  pw.physics.obj_set_angle_vel(idObjAsteroid, math.random()-0.5)
end



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

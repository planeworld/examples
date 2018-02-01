local M = {};

local max_nav_thrust = 50000

local createThruster = function(ObjId, position, angle)
  -- Create navigation thrusters
  local idNavThruster = pw.system.create_thruster()
  pw.physics.thruster_set_thrust_max(idNavThruster, max_nav_thrust)
  pw.system.thruster_set_object(idNavThruster, ObjId)
  pw.physics.thruster_set_origin(idNavThruster, position.x, position.y)
  pw.physics.thruster_set_angle(idNavThruster, angle)

  -- Create emitter
  local idEm = pw.system.create_emitter("particle")
  local idPa = pw.system.create_particles("thrust")
  pw.system.particles_set_size_birth(idPa, 0.5)
  pw.system.particles_set_size_death(idPa, 0.05)
  pw.system.particles_set_color_birth(idPa, 0.5, 1.0, 0.5, 0.75)
  pw.system.particles_set_color_death(idPa, 0.2, 0.2, 0.8, 0.25)
  pw.system.particles_set_maximum_age(idPa, 0.1)
  pw.system.emitter_set_particles(idEm, idPa)
  pw.system.emitter_set_distribution(idEm, "point_source")
  pw.system.emitter_set_mode(idEm, "timed")
  pw.system.emitter_set_frequency(idEm, 500)
  pw.system.emitter_set_number(idEm, 50)
  pw.system.emitter_set_angle_std(idEm, math.rad(2))
  pw.system.emitter_set_velocity(idEm, 100.0)
  pw.system.emitter_set_velocity_std(idEm, 2.0)
  pw.system.emitter_set_velocity_inheritance(idEm, 1.0)
  pw.physics.emitter_set_position(idEm, position.x, position.y)
  pw.system.emitter_set_angle(idEm, angle+math.pi)

  pw.system.thruster_add_emitter(idNavThruster, idEm)
  
  local setThrust = function(thrust)
    if thrust > 0 then
      pw.sim.thruster_activate(idNavThruster, thrust)
    else
      pw.sim.thruster_deactivate(idNavThruster)
    end
  end
  setThrust(0)
  
  local O={}
  O.Id=idNavThruster
  O.setThrust=setThrust
  return O
end  
  
M.create=createThruster
M.maxThrust=max_nav_thrust

return M

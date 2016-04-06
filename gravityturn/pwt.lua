
local pwt= {};
pwt.universe={};

pwt.universe.get_object = function(name)
  local object = {};
  object.name=name;
  object.mass = pw.universe.get_mass(name);
  object.inertia = pw.universe.get_inertia(name);
  
  object.get_position = function()
    return pw.universe.get_position(name);
  end
  
  object.get_velocity = function()
    return pw.universe.get_velocity(name);
  end
  
  object.get_angle = function()
    return pw.universe.get_angle(name);
  end

  object.get_angle_vel = function()
    return pw.universe.get_angle_vel(name);
  end
  
  return object;
end


pwt.universe.get_component = function(name)
  local object = {};
  object.name=name;
  
  object.set_force = function(force)
    if (force<0.0) then
      pw.sim.deactivate_thruster(name);
    else
      pw.sim.activate_thruster(name, force);
    end
  end
  
  return object;
end

return pwt;

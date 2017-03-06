local pathOfThisFile = ...
local folderOfThisFile = (...):match("(.-)[^%.]+$")

vec= require(folderOfThisFile .. 'vector');

local pwt= {};
pwt.universe={};

pwt.universe.get_object = function(name)
  local object = {};
  object.name=name;
  object.mass = pw.physics.get_mass(name);
  object.inertia = pw.physics.get_inertia(name);
  
  object.get_position = function()
    local x,y;
    x, y = pw.physics.get_position(name);
    local vector=vec.Vector(x,y);
    return vector;
  end
  
  object.get_velocity = function()
    local x,y;
    x, y = pw.physics.get_velocity(name);
    return vec.Vector(x,y);
  end
  
  object.get_angle = function()
    return pw.physics.get_angle(name);
  end

  object.get_angle_vel = function()
    return pw.physics.get_angle_vel(name);
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

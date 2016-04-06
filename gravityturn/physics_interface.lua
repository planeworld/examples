
pwt= {};
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



objects = {}
objects.rocket = pwt.universe.get_object("RocketBody");


time=0.0;
-- Assumption, is updated each calculation
frequency=33.33333

pw.system.pause()

P2=2.0*frequency*0.03;
P1=objects.rocket.inertia*frequency/12.0*0.1

controller = function(phi, omega)
  local w=0.5;
  local phi_current = objects.rocket.get_angle()
  local phi_e=phi-phi_current;
  local omega_phi=P2*phi_e
  local omega_phi_current=objects.rocket.get_angle_vel()
  local omega_e=w*omega_phi+(1-w)*omega-omega_phi_current
  io.write("phi_e=" .. phi .. "-" .. phi_current .. "\n")
  io.write("omega_e=" .. omega .. "-" .. omega_phi_current .. "\n")
  
  return P1*omega_e;
end

objects.earth = pwt.universe.get_object("Earth");

function getOrbitVelocity(radius, mass)
  return math.sqrt(pw.universe.G * mass / radius)
end

phi_v_old=0.0;
thrust=true;

thrusters={}
thrusters.main=pwt.universe.get_component("MainThruster")
thrusters.boosterleft=pwt.universe.get_component("BoosterLeft")
thrusters.boosterright=pwt.universe.get_component("BoosterRight")
thrusters.ccw1=pwt.universe.get_component("ControllerThrusterCounterClockwiseLeft")
thrusters.ccw2=pwt.universe.get_component("ControllerThrusterCounterClockwiseRight")
thrusters.cw1=pwt.universe.get_component("ControllerThrusterClockwiseLeft")
thrusters.cw2=pwt.universe.get_component("ControllerThrusterClockwiseRight")



function physics_interface()
    physics_frequency = pw.system.get_frequency()
    luatime=pw.universe.get_time()-time;
    time=pw.universe.get_time();
    frequency=1.0/luatime;

    v_x, v_y = objects.rocket.get_velocity();
    phi_v=math.atan(v_y, v_x)-math.pi/2.0;
    
    p_x, p_y = objects.rocket.get_position();
    r_abs=math.sqrt(p_x^2+p_y^2)
    e_r= {}
    e_r["x"]=p_x/r_abs
    e_r["y"]=p_y/r_abs
    e_phi ={}
    e_phi.x= e_r.y;
    e_phi.y=-e_r.x;
    v_r=e_r["x"]*v_x+e_r["y"]*v_y
    v_phi=e_phi["x"]*v_x+e_phi["y"]*v_y
    io.write("Orbit Velocity at height " .. r_abs .. "m: ".. getOrbitVelocity(r_abs, objects.earth.mass) .. "\n")
    io.write("Current Velocity: ".. v_phi .. "m/s, " .. v_r .. "m/s\n");

    omega=(phi_v-phi_v_old)*frequency;
--     if (v_r<0.0001) then
--       pw.system.pause()
--     end
--     if (v_phi>getOrbitVelocity(r_abs, objects.earth.mass)) then
--       pw.system.pause()
--     end
      
    
    if thrust then
      F=controller(phi_v, omega);
      io.write("Force:  ", F, "\n")

      if F >= 0 then
        thrusters.cw1.set_force(0.0);
        thrusters.cw2.set_force(0.0);
        thrusters.ccw1.set_force(F/2.0);
        thrusters.ccw2.set_force(F/2.0);
      else
        thrusters.ccw1.set_force(0.0);
        thrusters.ccw2.set_force(0.0);
        thrusters.cw1.set_force(-F/2.0);
        thrusters.cw2.set_force(-F/2.0);
      end

      if v_r<0.0 then
        thrust=false
        thrusters.main.set_force(0.0);
        thrusters.boosterleft.set_force(0.0);
        thrusters.boosterright.set_force(0.0);
        thrusters.cw1.set_force(0.0);
        thrusters.cw2.set_force(0.0);
        thrusters.ccw1.set_force(0.0);
        thrusters.ccw2.set_force(0.0);
      end
    end
    phi_v_old=phi_v;
end

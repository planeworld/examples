
objects = {}
objects.rocket = {}
objects.rocket.mass = pw.universe.get_mass("RocketBody");
objects.rocket.inertia = pw.universe.get_inertia("RocketBody");


time=0.0;
-- Assumption, is updated each calculation
frequency=33.33333

pw.system.pause()

P2=2.0*frequency*0.03;
P1=objects.rocket.inertia*frequency/12.0*0.1

controller = function(phi, omega)
  local w=0.5;
  local phi_current = pw.universe.get_angle("RocketBody")
  local phi_e=phi-phi_current;
  local omega_phi=P2*phi_e
  local omega_phi_current=pw.universe.get_angle_vel("RocketBody")
  local omega_e=w*omega_phi+(1-w)*omega-omega_phi_current
  io.write("phi_e=" .. phi .. "-" .. phi_current .. "\n")
  io.write("omega_e=" .. omega .. "-" .. omega_phi_current .. "\n")
  
  return P1*omega_e;
end

earth_mass=pw.universe.get_mass("Earth");

function getOrbitVelocity(radius, mass)
  return math.sqrt(pw.universe.G * mass / radius)
end

phi_v_old=0.0;
thrust=true;

function physics_interface()
    physics_frequency = pw.system.get_frequency()
    luatime=pw.universe.get_time()-time;
    time=pw.universe.get_time();
    frequency=1.0/luatime;

    v_x, v_y = pw.universe.get_velocity("RocketBody");
    phi_v=math.atan(v_y, v_x)-math.pi/2.0;
    
    p_x, p_y = pw.universe.get_position("RocketBody");
    r_abs=math.sqrt(p_x^2+p_y^2)
    e_r= {}
    e_r["x"]=p_x/r_abs
    e_r["y"]=p_y/r_abs
    e_phi ={}
    e_phi.x= e_r.y;
    e_phi.y=-e_r.x;
    v_r=e_r["x"]*v_x+e_r["y"]*v_y
    v_phi=e_phi["x"]*v_x+e_phi["y"]*v_y
    io.write("Orbit Velocity at height " .. r_abs .. "m: ".. getOrbitVelocity(r_abs, earth_mass) .. "\n")
    io.write("Current Velocity: ".. v_phi .. "m/s, " .. v_r .. "m/s\n");

    omega=(phi_v-phi_v_old)*frequency;
--     if (v_r<0.0001) then
--       pw.system.pause()
--     end
--     if (v_phi>getOrbitVelocity(r_abs, earth_mass)) then
--       pw.system.pause()
--     end
      
    
    if thrust then
      F=controller(phi_v, omega);
      io.write("Force:  ", F, "\n")

      if F >= 0 then
        pw.sim.deactivate_thruster("ControllerThrusterClockwiseRight")
        pw.sim.deactivate_thruster("ControllerThrusterClockwiseLeft")
        pw.sim.activate_thruster("ControllerThrusterCounterClockwiseRight", F/2.0)
        pw.sim.activate_thruster("ControllerThrusterCounterClockwiseLeft", F/2.0)
      else
        pw.sim.deactivate_thruster("ControllerThrusterCounterClockwiseRight")
        pw.sim.deactivate_thruster("ControllerThrusterCounterClockwiseLeft")
        pw.sim.activate_thruster("ControllerThrusterClockwiseRight", -F/2.0)
        pw.sim.activate_thruster("ControllerThrusterClockwiseLeft", -F/2.0)
      end

      if v_r<0.0 then
        thrust=false
        pw.sim.deactivate_thruster("ControllerThrusterCounterClockwiseRight")
        pw.sim.deactivate_thruster("ControllerThrusterCounterClockwiseLeft")
        pw.sim.deactivate_thruster("ControllerThrusterClockwiseRight")
        pw.sim.deactivate_thruster("ControllerThrusterClockwiseLeft")
        pw.sim.deactivate_thruster("MainThruster")
        pw.sim.deactivate_thruster("BoosterRight")
        pw.sim.deactivate_thruster("BoosterLeft")
      end
    end
    phi_v_old=phi_v;
end

pwt = require("gravityturn.pwt")
astrodynamics = require("lua_modules.astrodynamics")



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

    velocity = objects.rocket.get_velocity();
    phi_v=math.atan(velocity.y, velocity.x)-math.pi/2.0;
    
    position = objects.rocket.get_position();
    height=position:norm();
    e_r= position:direction()
    e_phi = Vector:new({x=e_r.y; y=-e_r.x});
    v_r=e_r*velocity
    v_phi=e_phi*velocity
    io.write("Orbit Velocity at height " .. height .. "m: ".. astrodynamics.getOrbitVelocity(height, objects.earth.mass) .. "\n")
    io.write("Current Velocity: ".. v_phi .. "m/s, " .. v_r .. "m/s\n");

    omega=(phi_v-phi_v_old)*frequency;
--     if (v_r<0.0001) then
--       pw.system.pause()
--     end
--     if (v_phi>astrodynamics.getOrbitVelocity(height, objects.earth.mass)) then
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

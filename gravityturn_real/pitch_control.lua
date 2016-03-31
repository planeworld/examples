math.randomseed(os.time())

F_x_max=5000.0




objects = {}
objects.rocket = {}
objects.rocket.mass = pw.universe.get_mass("RocketBody");
objects.rocket.inertia = pw.universe.get_inertia("RocketBody");


time=0.0;
-- Assumption, is updated each calculation
frequency=33.33333

pw.system.pause()


P2=2.0*frequency*0.003;
P1=objects.rocket.inertia*frequency/12.0*0.01

controller = function(phi, omega)
  local w=0.5;
  local phi_e=phi-pw.universe.get_angle("RocketBody")
  local omega_phi=P2*phi_e
  local omega_e=w*omega_phi+(1-w)*omega-pw.universe.get_angle_vel("RocketBody")
  return P1*omega_e;
end

function physics_interface()
--     pw.system.pause()
    physics_frequency = pw.system.get_frequency()
    luatime=pw.universe.get_time()-time;
    time=pw.universe.get_time();
    frequency=1.0/luatime;

    F=controller(math.pi, 0.0);
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

    
end



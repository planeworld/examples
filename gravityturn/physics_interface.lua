
F_x_max=5000.0

Object = {}
Object["name"] = "RocketBody"

ObjectRef = {}
ObjectRef["name2"] = "Earth"

F=42674763.50438778-100.0
thrust=true

function getOrbitVelocity(radius, mass)
  return math.sqrt(pw.universe.G * mass / radius)
end




function physics_interface()
    
    frequency = pw.system.get_frequency()
    Frametime = 1.0/frequency
    
    Object["p_x"], Object["p_y"] = pw.universe.get_position(Object["name"])
    Object["v_x"], Object["v_y"] = pw.universe.get_velocity(Object["name"])
    earth_mass=pw.universe.get_mass("Earth");
    rocket_mass=pw.universe.get_mass("RocketBody");
   
    v_abs=math.sqrt(Object["v_x"]^2+Object["v_y"]^2)
    r_abs=math.sqrt(Object["p_x"]^2+Object["p_y"]^2)
    e_r= {}
    e_r["x"]=Object["p_x"]/r_abs
    e_r["y"]=Object["p_y"]/r_abs
    e_phi ={}
    e_phi.x= e_r.y;
    e_phi.y=-e_r.x;
    v_r=e_r["x"]*Object["v_x"]+e_r["y"]*Object["v_y"]
    v_phi=e_phi["x"]*Object["v_x"]+e_phi["y"]*Object["v_y"]
    
    
    F_x=F/v_abs*Object["v_x"]
    F_y=F/v_abs*Object["v_y"]

    
    if thrust then
      if v_r>=0 then
        pw.universe.apply_force(Object["name"], F_x, F_y , 0.0, 0.0)
      else
        thrust=false
        io.write("Engine stopped at ", r_abs,"m \n")
        io.write("V=(",v_phi, ",", v_r ,")\n");
        io.write(getOrbitVelocity(r_abs, earth_mass), "m/s \n");
      end
    end
    
--     if not thrust then
--       v_phi_soll=getOrbitVelocity(r_abs, earth_mass)
--       F_r=-v_r*rocket_mass/Frametime*1.1;
--       F_phi=0.0
-- --       (v_phi_soll-v_phi)*rocket_mass/Frametime*0.1;
--       
--       F_x=e_r["x"]*F_r+e_phi["x"]*F_phi;
--       F_y=e_r["y"]*F_r+e_phi["y"]*F_phi;
--       
--       pw.universe.apply_force(Object["name"], F_x, F_y , 0.0, 0.0)
--       io.write("Korrekturschub: ", F_phi, " ", F_r," \n")
--       io.write("Height: ", r_abs,"m \n")
--     end
    
end



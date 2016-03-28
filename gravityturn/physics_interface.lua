
F_x_max=5000.0

Object = {}
Object["name"] = "RocketBody"

ObjectRef = {}
ObjectRef["name2"] = "Earth"

F=44272463.35156199
thrust=true

function physics_interface()
    
    frequency = pw.system.get_frequency()
    Frametime = 1.0/frequency
    
    Object["p_x"], Object["p_y"] = pw.universe.get_position(Object["name"])
    Object["v_x"], Object["v_y"] = pw.universe.get_velocity(Object["name"])
   
    v_abs=math.sqrt(Object["v_x"]^2+Object["v_y"]^2)
    r_abs=math.sqrt(Object["p_x"]^2+Object["p_y"]^2)
    e_r= {}
    e_r["x"]=Object["p_x"]/r_abs
    e_r["y"]=Object["p_y"]/r_abs
    v_r=e_r["x"]*Object["v_x"]+e_r["y"]*Object["v_y"]
    
    
    F_x=F/v_abs*Object["v_x"]
    F_y=F/v_abs*Object["v_y"]

    
    if thrust then
      if v_r>0 then
        pw.universe.apply_force(Object["name"], F_x, F_y , 0.0, 0.0)
      else
        thrust=false
        io.write("Engine stopped at ", r_abs,"m \n")
      end
    end
    

    
end



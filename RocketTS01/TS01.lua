local M = {};

-- Create Rocket
local idObjRocket = pw.system.create_obj()
local idShpMainThruster = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpMainThruster,
    {-2.7, -27.0,
      2.7, -27.0,
      2.7,  18.0,
      0.0,  27.0,
     -2.7,  18.0}
)
pw.physics.shp_set_mass(idShpMainThruster, 196700.0)
pw.system.obj_add_shp(idObjRocket, idShpMainThruster)

local idShpThrusterLeft = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpThrusterLeft,
    { -2.7, -27.0,
      -5.7, -27.0,
      -5.7,   0.0,
      -4.2,   4.0,
      -2.7,   0.0}
)
pw.physics.shp_set_mass(idShpThrusterLeft, 273000.0)
pw.system.obj_add_shp(idObjRocket, idShpThrusterLeft)

local idShpThrusterRight = pw.system.create_shp("shp_polygon")
pw.system.shp_set_vertices(idShpThrusterRight,
    { 2.7, -27.0,
      5.7, -27.0,
      5.7,   0.0,
      4.2,   4.0,
      2.7,   0.0}
)
pw.physics.shp_set_mass(idShpThrusterRight, 273000.0)
pw.system.obj_add_shp(idObjRocket, idShpThrusterRight)

pw.physics.obj_disable_gravitation(idObjRocket)

pw.physics.obj_set_com(idObjRocket, 0,0);

--local inertia = pw.physics.obj_get_inertia(idObjRocket)
--local centerofmass = pw.physics.obj_get_com(idObjRocket)


-- Create main thruster
local idMainThruster = pw.system.create_thruster()
pw.system.thruster_set_object(idMainThruster, idObjRocket)
pw.physics.thruster_set_thrust_max(idMainThruster, 11500000.0)

local setThrust = function(thrust)
  if thrust > 0 then
    pw.sim.thruster_activate(idMainThruster, thrust)
  else
    pw.sim.thruster_deactivate(idMainThruster)
  end
end
setThrust(0)


-- Create navigation thrusters
local max_nav_thrust = 100000
local idNavThrusterTL = pw.system.create_thruster()
pw.system.thruster_set_object(idNavThrusterTL, idObjRocket)
pw.physics.thruster_set_origin(idNavThrusterTL, -2.7, 10)
pw.physics.thruster_set_angle(idNavThrusterTL, math.rad(0))
pw.physics.thruster_set_thrust_max(idNavThrusterTL, max_nav_thrust/2)

local idNavThrusterBL = pw.system.create_thruster()
pw.system.thruster_set_object(idNavThrusterBL, idObjRocket)
pw.physics.thruster_set_origin(idNavThrusterBL, -2.7, -10)
pw.physics.thruster_set_angle(idNavThrusterBL, math.rad(0))
pw.physics.thruster_set_thrust_max(idNavThrusterBL, max_nav_thrust/2)

local idNavThrusterTR = pw.system.create_thruster()
pw.system.thruster_set_object(idNavThrusterTR, idObjRocket)
pw.physics.thruster_set_origin(idNavThrusterTR, 2.7, 10)
pw.physics.thruster_set_angle(idNavThrusterTR, math.rad(180))
pw.physics.thruster_set_thrust_max(idNavThrusterTR, max_nav_thrust/2)

local idNavThrusterBR = pw.system.create_thruster()
pw.system.thruster_set_object(idNavThrusterBR, idObjRocket)
pw.physics.thruster_set_origin(idNavThrusterBR, 2.7, -10)
pw.physics.thruster_set_angle(idNavThrusterBR, math.rad(180))
pw.physics.thruster_set_thrust_max(idNavThrusterBR, max_nav_thrust/2)

local setYawThrust = function(thrust)
  if thrust > 0 then
    pw.sim.thruster_activate(idNavThrusterTR, thrust/2)
    pw.sim.thruster_activate(idNavThrusterBL, thrust/2)
    pw.sim.thruster_deactivate(idNavThrusterTL)
    pw.sim.thruster_deactivate(idNavThrusterBR)
  elseif thrust < 0 then
    pw.sim.thruster_activate(idNavThrusterTL, -thrust/2)
    pw.sim.thruster_activate(idNavThrusterBR, -thrust/2)
    pw.sim.thruster_deactivate(idNavThrusterTR)
    pw.sim.thruster_deactivate(idNavThrusterBL)
  else
    pw.sim.thruster_deactivate(idNavThrusterTL)
    pw.sim.thruster_deactivate(idNavThrusterTR)
    pw.sim.thruster_deactivate(idNavThrusterBL)
    pw.sim.thruster_deactivate(idNavThrusterBR)
  end
end

setYawThrust(0)
  
  
local sum_error = 0

local yawcontroller = function(target_angle)
  local current_angle = pw.physics.obj_get_angle(idObjRocket)
  local delta_angle = target_angle - current_angle
  if delta_angle < - math.pi then
    delta_angle = delta_angle + math.pi
  elseif delta_angle > math.pi then
    delta_angle = delta_angle - math.pi
  end
  io.write("Angle Error: ", delta_angle, "\n")

  sum_error = sum_error + delta_angle;
  io.write("Sum Angle Error: ", sum_error, "\n")
  
  
  local target_angle_vel = 0.0
  local current_angle_vel = pw.physics.obj_get_angle_vel(idObjRocket)
  local delta_angle_vel = target_angle_vel - current_angle_vel
  io.write("Vel Error: ", delta_angle_vel, "\n")
  
  local thrust = (delta_angle * 10000 + sum_error * 2 + (math.pi-math.abs(delta_angle)) * delta_angle_vel * 50000) *10
  io.write("Thrust: ", thrust, "\n")
  setYawThrust(thrust)
  
end

local calcTimes = function (current_angle_vel, angle_accel, delta_angle)
  local t1 = - 3/2 * current_angle_vel / angle_accel + math.sqrt( 7/4 * current_angle_vel^2 / angle_accel^2 + delta_angle / angle_accel )
  local t2 = 2*t1 + current_angle_vel / angle_accel
  return {t1,t2}
end

local yawcontroller2 = function(target_angle)
  local current_angle = pw.physics.obj_get_angle(idObjRocket)
  local delta_angle = target_angle - current_angle
  if delta_angle < - math.pi then
    delta_angle = delta_angle + 2* math.pi
  elseif delta_angle > math.pi then
    delta_angle = delta_angle - 2* math.pi
  end
  io.write("Angle Error: ", delta_angle, "\n")

  sum_error = sum_error + delta_angle;
  io.write("Sum Angle Error: ", sum_error, "\n")
  
  
  local target_angle_vel = 0.0
  local current_angle_vel = pw.physics.obj_get_angle_vel(idObjRocket)
  local delta_angle_vel = target_angle_vel - current_angle_vel
  io.write("Vel Error: ", delta_angle_vel, "\n")
  
  local inertia = pw.physics.obj_get_inertia(idObjRocket)
  io.write("Inertia: ", inertia, "\n")
  local angle_accel = max_nav_thrust*10 / inertia
  io.write("Angle acceleration: ", angle_accel, "\n")
  
  local tl, tr;
  if delta_angle > 0 then 
    tl = calcTimes(current_angle_vel, angle_accel, delta_angle)
    tr = calcTimes(current_angle_vel, -angle_accel, delta_angle - 2 * math.pi)
  else
    tl = calcTimes(current_angle_vel, angle_accel, delta_angle + 2 * math.pi)    
    tr = calcTimes(current_angle_vel, -angle_accel, delta_angle)
  end

  io.write("Rotate counter clockwise: t1= ", tl[1], " t2= ", tl[2], "\n")
  io.write("Rotate clockwise        : t1= ", tr[1], " t2= ", tr[2], "\n")
  
  if tl[2]<tr[2] then
    if tl[1] > 0 then 
      thrust = max_nav_thrust
    else
      thrust = -max_nav_thrust
    end
  else
    if tl[1] > 0 then 
      thrust = -max_nav_thrust
    else
      thrust = max_nav_thrust
    end
  end
  io.write("Thrust: ", thrust, "\n")
  setYawThrust(thrust)
  
end



M.Id=idObjRocket
M.setThrust=setThrust
M.yawcontroller=yawcontroller2

return M

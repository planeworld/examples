local pathOfThisFile = ...
local folderOfThisFile = pathOfThisFile:match("(.-)[^%.]+$")

Thruster= require(folderOfThisFile .. 'NavThrusterBK01');

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
local NavThrusterTL = Thruster.create(idObjRocket, {x=-2.7, y=10}, 0)
local NavThrusterBL = Thruster.create(idObjRocket, {x=-2.7, y=-10}, 0)
local NavThrusterTR = Thruster.create(idObjRocket, {x=2.7, y=10}, math.rad(180))
local NavThrusterBR = Thruster.create(idObjRocket, {x=2.7, y=-10}, math.rad(180))

local max_nav_torque = 2*Thruster.maxThrust * 10.0

local setYawTorque = function(torque)
  local thrust = torque/10.0
  if thrust > 0 then
    NavThrusterTR.setThrust(thrust/2)
    NavThrusterBL.setThrust(thrust/2)
    NavThrusterTL.setThrust(0)
    NavThrusterBR.setThrust(0)
  elseif thrust < 0 then
    NavThrusterTL.setThrust(-thrust/2)
    NavThrusterBR.setThrust(-thrust/2)
    NavThrusterTR.setThrust(0)
    NavThrusterBL.setThrust(0)
  else
    NavThrusterTR.setThrust(0)
    NavThrusterBL.setThrust(0)
    NavThrusterTL.setThrust(0)
    NavThrusterBR.setThrust(0)
  end
end

setYawTorque(0)
  
  
local sum_error = 0

local yawcontroller = function(target_angle)
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
  local dt = 1/200
  local torque = 1e-9* 2* inertia * (delta_angle - current_angle_vel* dt) / dt^2 
  io.write("Torque: ", torque, "\n")
  setYawTorque(torque)
  
end

local calcTimes = function (current_angle_vel, angle_accel, delta_angle)
  local t1 = - 3/2 * current_angle_vel / angle_accel + math.sqrt( 7/4 * current_angle_vel^2 / angle_accel^2 + delta_angle / angle_accel )
  local t2 = 2*t1 + current_angle_vel / angle_accel
  return {t1,t2}
end

local max_torque = max_nav_torque

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
  local angle_accel = max_torque / inertia
  io.write("Angle acceleration: ", angle_accel, "\n")
  
  local t, l, tr;
  if delta_angle > 0 then 
    tl = calcTimes(current_angle_vel, angle_accel, delta_angle)
    tr = calcTimes(current_angle_vel, -angle_accel, delta_angle - 2 * math.pi)
  else
    tl = calcTimes(current_angle_vel, angle_accel, delta_angle + 2 * math.pi)    
    tr = calcTimes(current_angle_vel, -angle_accel, delta_angle)
  end

  io.write("Rotate counter clockwise: t1= ", tl[1], " t2= ", tl[2], "\n")
  io.write("Rotate clockwise        : t1= ", tr[1], " t2= ", tr[2], "\n")
  
  local direction =1;
  
  if tl[2]<tr[2] then
    t=tl
    direction=1
  else
    t=tr
    direction=-1
  end
  

    if t[1] > 0 then 
      torque = max_torque* direction
    else
      torque = -max_torque* direction
    end

  if t[2]<1 then
    max_torque = max_torque /2
  end

  if t[2]>50 then
    max_torque = max_torque *2
  end
  
--   if t[2]>0.8 then
--     if t[1] > 0 then 
--       torque = max_nav_torque* direction
--     else
--       torque = -max_nav_torque* direction
--     end
--   else
-- --     local dt = 1/200
-- --     torque = 1e-7* 2* inertia * (delta_angle) / dt^2 
-- --     io.write("Second controller\n")
--   end

  io.write("Torque: ", torque, "\n")
  setYawTorque(torque)
end


local yawcontroller_angle_vel = function(target_angle_vel)
  local current_angle_vel = pw.physics.obj_get_angle_vel(idObjRocket)
  local delta_angle_vel = target_angle_vel - current_angle_vel
  io.write("Vel Error: ", delta_angle_vel, "\n")
  
  local inertia = pw.physics.obj_get_inertia(idObjRocket)
  io.write("Inertia: ", inertia, "\n")
  local angle_accel = max_torque / inertia
  io.write("Angle acceleration: ", angle_accel, "\n")
  
  
  local t= delta_angle_vel / angle_accel;
  
  if delta_angle_vel>0 then
    torque = max_torque
  else
    torque = -max_torque
  end

  if math.abs(t)<1 then
    max_torque = max_torque /2
  end

  if math.abs(t)>50 then
    max_torque = max_torque *2
  end
  
--   if t[2]>0.8 then
--     if t[1] > 0 then 
--       torque = max_nav_torque* direction
--     else
--       torque = -max_nav_torque* direction
--     end
--   else
-- --     local dt = 1/200
-- --     torque = 1e-7* 2* inertia * (delta_angle) / dt^2 
-- --     io.write("Second controller\n")
--   end

  io.write("Torque: ", torque, "\n")
  setYawTorque(torque)
end



M.Id=idObjRocket
M.setThrust=setThrust
M.yawcontroller=yawcontroller2
M.yawcontroller_angle_vel=yawcontroller_angle_vel

return M

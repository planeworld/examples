local module = {}

module.G = 6.67408e-11;

module.calcCircularOrbitVelocity = function(radius, mass)
  return math.sqrt(module.G * mass / radius)
end

module.calcGeostationaryOrbit = function(angle_velocity, mass)
  -- https://en.wikipedia.org/wiki/Geostationary_orbit
  return (module.G * mass / angle_velocity^2)^(1.0/3.0);
end

module.calcOrbitalParameters = function(mass, r, v)
  local result={}
  result.e = ( (v^2-module.G*mass/r:getLength()) * r - (r*v) *v) / module.G/mass
  result.l = (r:getLength()*v:getLength()*math.sin(v:getAngle()-r:getAngle()) )^2/module.G/mass
  return result
end


return module

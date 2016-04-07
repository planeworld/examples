
local astrodynamics = {}

astrodynamics.getOrbitVelocity = function(radius, mass)
  return math.sqrt(pw.universe.G * mass / radius)
end

astrodynamics.getGeostationaryOrbit = function(angle_velocity, mass)
  -- https://en.wikipedia.org/wiki/Geostationary_orbit
  return (pw.universe.G * mass / angle_velocity)^(1.0/3.0);
end

return astrodynamics

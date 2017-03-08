local ad = require('lua_modules.astrodynamics')
local vec = require('lua_modules.vector')


local data = {};
data.M=5.974e24;
data.omega= 2*math.pi/86164;

describe('Astrodynamics', function()
  it('calcs circular orbit velocity', function()
    local calculated=ad.calcCircularOrbitVelocity(42167986.54, data.M);
    local expected=3074.941663174549376;
    assert.are.same(expected, calculated);
  end)

  it('calcs geostationary orbit', function()
    local calculated=ad.calcGeostationaryOrbit(data.omega, data.M);
    local expected=42167986.540455915034;
    assert.are.same(expected, calculated);
  end)

  it('calcs oribtal parameters', function()
    local r=vec.Vector(45000000,0);
    local v=vec.Vector(0, 3000);
    local calculated=ad.calcOrbitalParameters(data.M, r, v);
    assert.are.same(45709967.302432671189, calculated.l);
    assert.are.same({x= 0.015777051165170453972, y= 0}, calculated.e.v);

  end)


end)

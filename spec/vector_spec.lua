local vec = require('lua_modules.vector')

describe('vector', function()
  it('adds vectors', function()
    local a=vec.Vector(1,2);
    local b=vec.Vector(3,4);
    local expected=vec.Vector(4,6);
    assert.are.same(expected.v, (a+b).v);
  end)

  it('substracts vectors', function()
    local a=vec.Vector(1,2);
    local b=vec.Vector(3,4);
    local expected=vec.Vector(-2,-2);
    assert.are.same(expected.v, (a-b).v);
  end)

  it('negates vectors', function()
    local a=vec.Vector(1,2);
    local expected=vec.Vector(-1,-2);
    assert.are.same(expected.v, (-a).v);
  end)

  it('gets direction of vectors', function()
    local a=vec.Vector(0,2);
    local expected=vec.Vector(0,1);
    assert.are.same(expected.v, (a:direction()).v);
  end)
  
  it('gets norm of vectors', function()
    local a=vec.Vector(3,4);
    local expected=5;
    assert.are.same(expected, a:norm(2));
  end)

  it('are equal', function()
    local a=vec.Vector(3,4);
    local b=vec.Vector(3,4);
    assert.is.True(a==b);
  end)

end)

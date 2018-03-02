local vec = require('planworld.vector')

describe('vector', function()
  it('adds vectors', function()
    local a=vec.Vector(1,2);
    local b=vec.Vector(3,4);
    local expected=vec.Vector(4,6);
    assert.are.same(expected.v, (a+b).v);
  end)

  it('subtracts vectors', function()
    local a=vec.Vector(1,2);
    local b=vec.Vector(3,4);
    local expected=vec.Vector(-2,-2);
    assert.are.same(expected.v, (a-b).v);
  end)

  it('multiplies vectors', function()
    local a=vec.Vector(1,2);
    local b=vec.Vector(3,4);
    local expected=vec.Vector(3,8);
    assert.are.same(expected.v, (a*b).v);
  end)

  it('multiplies scalar', function()
    local a=vec.Vector(1,2);
    local b=2;
    local expected=vec.Vector(2,4);
    assert.are.same(expected.v, (a*b).v);
    assert.are.same(expected.v, (b*a).v);
  end)

  it('divides vectors', function()
    local a=vec.Vector(3,4);
    local b=vec.Vector(1,2);
    local expected=vec.Vector(3,2);
    assert.are.same(expected.v, (a/b).v);
  end)

  it('divides scalar', function()
    local a=vec.Vector(2,3);
    local b=2;
    local expected=vec.Vector(1,1.5);
    assert.are.same(expected.v, (a/b).v);
    assert.has.error(function() local c=b/a end, "Number divided by vector not supported.");
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

  it('error on power of decimal number', function()
    local a=vec.Vector(3,4);
   
    assert.has.error(function() local b=a^1.1 end, "Power of a dezimal number is not supported.");
  end)

  it('power of even number', function()
    local a=vec.Vector(1,2);
    
    assert.is.same(25, a^4);
  end)

  it('power of odd number', function()
    local a=vec.Vector(1,2);
    local expected=vec.Vector(5,10)
    assert.is.same(expected, a^3);
  end)

  it('are equal', function()
    local a=vec.Vector(3,4);
    local b=vec.Vector(3,4);
    assert.is.True(a==b);
  end)

  it('less than', function()
    local a=vec.Vector(1,4);
    local b=vec.Vector(3,4);
    assert.is.True(a<b);
  end)

  it('less or equal', function()
    local a=vec.Vector(4,3);
    local b=vec.Vector(3,4);
    assert.is.True(a<=b);
  end)

end)

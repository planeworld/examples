local vec = require('lua_modules.vector')

describe('vector', function()
  it('adds vectors', function()
  	local a=vec.Vector(1,2);
	local b=vec.Vector(3,4);
	local expected=vec.Vector(4,6);
	assert.are.same(expected.v, (a+b).v);
  end)
end)

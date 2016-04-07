
Vector = { x = 0.0; y=0.0 }

function Vector:new(object)
  object = object or {}
  setmetatable(object,self)
  self.__index = self
  self.__mul = function(a,b)
    if type(a)=="table" then
      if type(b)=="table" then
        return a.x*b.x+a.y*b.y;
      else
        local result = Vector:new();
        result.x=a.x*b;
        result.y=a.y*b;
        return result
      end
    else
      local result = Vector:new();
      result.x=b.x*a;
      result.y=b.y*a;
      return result
    end
  end
  return object
end

function Vector:norm(p)
  p = p or 2;
  return (self.x^p + self.y^p)^(1.0/p)
end

function Vector:direction()
  local vector = Vector:new();
  local magnitude = self:norm(2);
  vector.x=self.x/magnitude;
  vector.y=self.y/magnitude;
  return vector;
end


Matrix = { xx = 0.0; xy=0.0; yx=0.0; yy=0.0 }

function Matrix:new(object)
  object = object or {}
  setmetatable(object,self)
  self.__index = self
  return object
end



return Vector, Matrix;

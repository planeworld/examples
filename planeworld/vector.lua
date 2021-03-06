--[[   
   vectorial2.lua ver 0.2 - A library for 2D vectors.
   Copyright (C) 2015 Leo Tindall (https://github.com/SilverWingedSeraph/Vectorial)

   ---
    All operators work as expected except modulo (%) which is vector distance and concat (..) which is linear distance.
   ---

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
]]
local module = {}
      module.Vector = function (ix, iy)
	local v2d = {}
	      v2d.v = {}
	      v2d.v.x = ix
	      v2d.v.y = iy
	      mt ={} --Metatable
	
	function v2d:deepcopy(orig) --Deeply copy a table. This is for the operation metatables.
    		local orig_type = type(orig)
    		local copy
    		if orig_type == 'table' then
        		copy = {}
        		for orig_key, orig_value in next, orig, nil do
            			copy[self:deepcopy(orig_key)] = self:deepcopy(orig_value)
        		end
        		setmetatable(copy, self:deepcopy(getmetatable(orig)))
   		else -- number, string, boolean, etc
        		copy = orig
    		end
    		return copy
	end

	--Vector Specific Math

	function v2d:getAngle() --Return the 2D angle of the vector IN RADIANS!.
		return math.atan2(self:getY(), self:getX())
	end
	
	function v2d:getLength() --Return the length of the vector (i.e. the distance from (0,0), see README.md for examples of using this)
		origin = self:deepcopy(self) --Get a new vector to work with
		origin:setX(0) --Set the origin equal to the geometric origin
		origin:setY(0)
		return self .. origin --Linear distance from us to the origin
	end
	
	function module.average (vectors)
		local n = #vectors
		local tmp = module.Vector(0, 0) 
		local j = 1 --Position in new_vectors
		if n == 0 then
			error("average() called with 0 inputs!")
		end
		for i, vector in ipairs(vectors) do
			tmp = tmp + vector	
		end
		return tmp / module.Vector(n, n)
	end
			

	--Comparisons

	mt.__eq = function(lhs, rhs)
		--Equal To operator for vector2Ds
		return (lhs:getX() == rhs:getX()) and (lhs:getY() == rhs:getY())
	end
	
	mt.__lt = function(lhs, rhs)
		--Less Than operator for vector2Ds
		return (math.sqrt((lhs:getX()^2) + (lhs:getY()^2)) < math.sqrt((rhs:getX()^2) + (rhs:getY()^2))) --We do this to compute the linear value of the vector so that, for example, (a % b) < (c % d) will not be broken.
	end
	
	mt.__le = function(lhs, rhs)
		--Less Than Or Equal To operator for vector2Ds
		return (math.sqrt((lhs:getX()^2) + (lhs:getY()^2)) <= math.sqrt((rhs:getX()^2) + (rhs:getY()^2))) --We do this to compute the linear value of the vector so that, for example, (a % b) < (c % d) will not be broken.
	end
	
	--Operations
	
	function v2d:setX(x)
		self.v.x = x
	end
	
	function v2d:setY(y)
		self.v.y = y
	end

	function v2d:getX()
		return self.v.x
	end
	
	function v2d:getY()
		return self.v.y
	end
        
        function v2d:norm(p)
          p = p or 2;
          return (self:getX()^p + self:getY()^p)^(1.0/p)
        end
        
        function v2d:direction()
          local result = self:deepcopy(self);
          local magnitude = self:norm(2);
          result:setX(self:getX()/magnitude);
          result:setY(self:getY()/magnitude);
          return result;
        end
	
	mt.__unm = function(rhs)
		--Unary Minus (negation) operator for Vectors
		out = rhs:deepcopy(rhs) --Copy the operand for the output (else the output won't have metamethods)
		out:setX(-rhs:getX()) --Operate on the X property
		out:setY(-rhs:getY()) --Operate on the Y property
		return out
	end
	
	mt.__add = function(lhs, rhs)
		--Addition operator for Vectors
		out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
		out:setX(lhs:getX() + rhs:getX()) --Operate on the X property
		out:setY(lhs:getY() + rhs:getY()) --Operate on the Y property
		return out
	end

	mt.__sub = function(lhs, rhs)
		--Subtraction operator for Vectors
		out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
		out:setX(lhs:getX() - rhs:getX()) --Operate on the X property
		out:setY(lhs:getY() - rhs:getY()) --Operate on the Y property
		return out
	end

	mt.__mul = function(lhs, rhs)
		--Multiplication operator for Vectors
		if type(lhs) == "number" then
                  out = rhs:deepcopy(rhs)--Copy the operand for the output (else the output won't have metamethods)
                  out:setX(lhs * rhs:getX())
		  out:setY(lhs * rhs:getY())
		elseif type(rhs) == "number" then
                  out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
                  out:setX(lhs:getX() * rhs)
                  out:setY(lhs:getY() * rhs)
                else
                  out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
                  out:setX(lhs:getX() * rhs:getX()) --Operate on the X property
                  out:setY(lhs:getY() * rhs:getY()) --Operate on the Y property
                end
                
		return out
	end

        mt.__div = function(lhs, rhs)
		--Division operator for Vectors
		if type(lhs) == "number" then
                  error ("Number divided by vector not supported.")
		elseif type(rhs) == "number" then
                  out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
                  out:setX(lhs:getX() / rhs)
                  out:setY(lhs:getY() / rhs)
                else
                  out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
                  out:setX(lhs:getX() / rhs:getX()) --Operate on the X property
                  out:setY(lhs:getY() / rhs:getY()) --Operate on the Y property
                end
                
		return out
	end
	
	mt.__pow = function(lhs, rhs)
		--Power operator for Vectors, see http://www.euclideanspace.com/maths/algebra/vectors/vecAlgebra/powers/index.htm
                
                assert(rhs==math.floor(rhs), "Power of a dezimal number is not supported.");
                local result;
                
                if (rhs%2==0) then -- rhs is even
                  result=(lhs:getX()^2+lhs:getY()^2)^(rhs/2)
                else -- rhs is even
                  result=lhs*lhs^(rhs-1)
                end
		--out = lhs:deepcopy(lhs)--Copy the operand for the output (else the output won't have metamethods)
		--out:setX(lhs:getX() / rhs:getX()) --Operate on the X property
		--out:setY(lhs:getY() / rhs:getY()) --Operate on the Y property
		return result
	end

        mt.__mod = function(lhs, rhs)
		--Vector distance operator for Vectors. Denoted by modulo (%)
		out = lhs:deepcopy(lhs)		--Copy the operand for the output (else the output won't have metamethods)
		out:setX(math.abs(rhs:getX() - lhs:getX())) --Operate on the X property
		out:setY(math.abs(rhs:getY() - lhs:getY())) --Operate on the Y property
		return out	
	end

	mt.__concat = function(lhs, rhs)
		--Linear distance operator for Vectors. Denoted by concat (..)
		out = 0		--This is a linear operation, so no deepcopy. 
		out = math.sqrt(((lhs:getX() - rhs:getX())^2) + ((rhs:getY() - lhs:getY())^2)) --Distance formula
		return out
	end

	mt.__tostring = function(self)
		--tostring handler for Vector
		out = ""	--This is a string operation, so no deepcopy.
		out = "[(X:"..self:getX().."),(Y:"..self:getY()..")]"
		return out
	end

	setmetatable(v2d, mt)

	return v2d
end
return module

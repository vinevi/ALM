local Key = {
	object = {},
	properties = {},
	increment = 4,
	timer = nil,
	timeline = nil
}

Key.onTimer = function(self, object, properties)
	local count = 0
	for key, value in pairs(properties) do
		if(object[key]) then
			local increment = self.increment
			local valueCurrent = object['get' .. key](object)
			local forward = value > valueCurrent
			local valueNew = valueCurrent
			if(forward == true) then
				valueNew = valueNew + self.increment
				if(valueNew > value) then
					valueNew = value
				end
			else
				valueNew = valueNew - self.increment
				if(valueNew < value) then
					valueNew = value
				end
			end
			object['set' .. key](object, valueNew)
			if(valueNew ~= value) then
				count = count + 1
			end
		end
	end
	if (count == 0) then
		RemoveTimer(self.timer)
		if(self.timeline) then
			self.timeline:next()
		end
	end
end

Key.to = function(self, object, properties, immediate, timeline)
	self.increment = increment or 4
	self.object = object
	self.properties = properties
	self.immediate = immediate
	self.timeline = timeline
end

Key.play = function(self)
	self.object:detach()
	if( self.immediate == false ) then
		RemoveTimer(self.timer)
		self.timer = Timer(function()
			self:onTimer(self.object, self.properties)
		end, const.Second)
	else
		self:set()
	end
end

Key.set = function(self)
	for key, value in pairs(self.properties) do
		if(self.object[key]) then
			self.object['set' .. key](self.object, value)
		end
	end
	if(self.timeline) then
		self.timeline:next()
	end
end

function Key:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

return Key
local Bromide, super = Class(Object)

function Bromide:init(sprite, audio, scroll_speed)
    super.init(self, 0, 0)
	self:setLayer(WORLD_LAYERS["above_ui"])

	self.con = 0
	self._bromide_sprite = Assets.getTexture(sprite)
	self._bromide_audio = Music()
	self._bromide_x = Game.world.camera.x - SCREEN_WIDTH / 2
	self._bromide_y = Game.world.camera.y - SCREEN_HEIGHT / 2
	self._bromide_y_target = Game.world.camera.y - (self._bromide_sprite:getHeight() - SCREEN_HEIGHT / 2)
	self._scroll_speed = scroll_speed or 2
	self._active = false

	if Game.world.music then
		Game.world.music:pause()
	end
	self._bromide_audio:play(audio, 1, 1)

	self.timer = -1
end

function Bromide:update()
	if self.con == 0 then
		if self._bromide_y ~= self._bromide_y_target then
			self._bromide_y = MathUtils.approach(self._bromide_y, self._bromide_y_target, self._scroll_speed * DTMULT)
			if math.abs(self._bromide_y - self._bromide_y_target) <= 1 then
				self._bromide_y = self._bromide_y_target
				self._bromide_y_target = Game.world.camera.y - SCREEN_HEIGHT / 2
				self.con = 5
			end
		end
	elseif self.con == 5 then
		if self._bromide_y ~= self._bromide_y_target then
			self._bromide_y = MathUtils.approach(self._bromide_y, self._bromide_y_target, self._scroll_speed * DTMULT)
			if math.abs(self._bromide_y - self._bromide_y_target) <= 1 then
				self._bromide_y = self._bromide_y_target
				self.con = 10
			end
		end
	elseif self.con == 10 then
		self.con = 11
		self.timer = 30
		self._bromide_audio:fade(0, 1)
	elseif self.con == 12 then
		self.con = -1
		self._bromide_audio:stop()
		if Game.world.music then
			Game.world.music:resume()
		end
		self:remove()
	end

	if self.timer == 0 then
		self.con = 12
		self.timer = -1
	end

	if self.timer > 0 then
		self.timer = MathUtils.approach(self.timer, 0, DTMULT)
	end

	super.update(self)
end

function Bromide:draw()
	Draw.setColor(1, 1, 1, self.alpha)
	Draw.draw(self._bromide_sprite, Game.world.camera.x - SCREEN_WIDTH / 2, self._bromide_y)

	super.draw(self)
end

return Bromide
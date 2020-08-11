Hooks:PostHook(PlayerTweakData,"_init_parachute","wz_init",function(self)
	self.parachute.movement.forward_speed = 200
	self.parachute.terminal_velocity = 700
	self.parachute.cooldown = 30
end)

Hooks:PostHook(PlayerTweakData,"_init_parachute","wz_init",function(self)
	self.parachute.movement.forward_speed = 450
	self.parachute.terminal_velocity = 550
	self.parachute.cooldown = 30
	self.parachute.trigger_delay = 1
end)

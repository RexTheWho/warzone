Hooks:PostHook(PlayerTweakData,"_init_parachute","wz_init",function(self)
	self.parachute.movement.forward_speed = 600
	self.parachute.terminal_velocity = 450
	self.parachute.cooldown = 20
	self.parachute.trigger_delay = 1.25
end)

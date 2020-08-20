function PlayerDamage:_bleed_out_damage(attack_data)

end

Hooks:PostHook(PlayerDamage,"revive","wz_revived",function(self)
    self._down_time = self._down_time - tweak_data.player.damage.DOWNED_TIME_DEC
    self._revives = Application:digest_value(self._lives_init + managers.player:upgrade_value("player", "additional_lives", 0), true)
end)

function PlayerDamage:respawn()
    managers.player:set_player_state("standard")
    self._bleed_out = false
	self._incapacitated = nil
	self._downed_timer = nil
    self._downed_start_time = nil
    self._downed_progression = 100
    
    self:_regenerated()
	self:_regenerate_armor(true)
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
    })
    self:_send_set_health()
    self:_set_health_effect()
    managers.hud:pd_stop_progress()
    self._revive_health_multiplier = nil
end
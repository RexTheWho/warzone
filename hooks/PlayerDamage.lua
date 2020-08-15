function PlayerDamage:_bleed_out_damage(attack_data)

end

Hooks:PostHook(PlayerDamage,"revive","wz_revived",function(self)
    self._down_time = self._down_time - tweak_data.player.damage.DOWNED_TIME_DEC
    self._revives = Application:digest_value(self._lives_init + managers.player:upgrade_value("player", "additional_lives", 0), true)
end)
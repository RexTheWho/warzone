function PlayerFatal:exit(state_data, new_state_name)
	PlayerFatal.super.exit(self, state_data, new_state_name)
	self:_end_action_dead(managers.player:player_timer():time())

	if Network:is_server() then
		PlayerBleedOut._unregister_revive_SO(self)
	end

	self._revive_SO_data = nil

	if self._stats_screen then
		self._stats_screen = false

		managers.hud:hide_stats_screen()
	end

	local exit_data = {
		equip_weapon = self._reequip_weapon
	}

	if new_state_name == "standard" then
		exit_data.wants_crouch = false
	end

	managers.network:session():send_to_peers_synched("sync_contour_state", self._unit, -1, table.index_of(ContourExt.indexed_types, "teammate_downed"), false, 1)

	return exit_data
end
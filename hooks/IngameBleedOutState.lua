function IngameBleedOutState:update(t, dt)
	local player = managers.player:player_unit()

	if not alive(player) then
		return
	end

	if player:movement():nav_tracker() and player:character_damage():update_downed(t, dt) then
		managers.player:set_player_state("fatal")
	end
end
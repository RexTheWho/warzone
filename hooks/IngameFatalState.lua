function IngameFatalState:update(t, dt)
	local player = managers.player:player_unit()

	if not alive(player) then
		return
	end

	if self._respawn_time then
		self._respawn_time = self._respawn_time - dt
		if self._respawn_time <= 0 then
			player:character_damage():revive(true)
			player:character_damage():_regenerated()
		end
	end

end

Hooks:PostHook(IngameFatalState,"at_enter","wz_death",function(self)
	local player = managers.player:player_unit()
	self._respawn_time = 3
	local closest = {}
	for _, script in pairs(managers.mission._missions) do
        for _, tbl in pairs(script) do
            if tbl.elements then
                for _, element in pairs(tbl.elements) do
                    if element.class == "ElementPlayerSpawner" and element.values.enabled then
						local dist = mvector3.distance(player:position(), element.values.position)
						if not closest.dist or dist < closest.dist then
							closest.dist = dist
							closest.elem = element
						end
					end
				end
			end
		end
	end
	player:movement():trigger_teleport({position = closest.elem.values.position, rotation = closest.elem.values.rotation, fade_in = 1, sustain = 4, fade_out = 2})
end)
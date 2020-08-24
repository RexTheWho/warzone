Hooks:PostHook(MissionScript,"_create_elements","wz_get_alert_points",function(self, elements)
	for id, element in pairs(self._element_groups["ElementSpecialObjective"]) do
		if element:value("is_alert_point") then
			self._alert_points = self._alert_points or {}
			self._alert_points[id] = element
		end
	end
end)

function MissionManager:find_alert_point(position)
	local distances = {}

	for name, script in pairs(self._scripts) do
		for _, alert_point in pairs(script._alert_points) do
			if alert_point:value("enabled") and not alert_point.executing then
				local distance = mvector3.distance(alert_point:value("position"), position)
				distances[distance] = alert_point
			end
		end
	end

	local min = -1

	for distance, alert_point in pairs(distances) do
		if min == -1 or distance < min then
			min = distance
		end
	end

	return distances[min]
end
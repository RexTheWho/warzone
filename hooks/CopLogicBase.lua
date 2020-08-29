function CopLogicArrest._call_the_police(data, my_data, paniced)
    if not my_data.is_on_alert_SO then
		CopLogicBase.register_alert_SO(data)
		--CopLogicArrest._say_call_the_police(data, my_data)
	end
end
function CopLogicBase.register_alert_SO(data)
	if not data.unit:unit_data().mission_element then
		return
	end

	local alert_point = managers.mission:find_alert_point(data.unit:position())

	if alert_point then
		alert_point:add_event_callback("complete", callback(data.unit, CopLogicBase, "on_alert_completed", {
			data = data,
			alert_point = alert_point
		}), tostring(data.unit:key()))
		alert_point:add_event_callback("fail", callback(data.unit, CopLogicBase, "on_alert_failed", {
			data = data,
			alert_point = alert_point
		}), tostring(data.unit:key()))
		alert_point:add_event_callback("administered", callback(data.unit, CopLogicBase, "on_alert_administered", {
			data = data,
			alert_point = alert_point
		}), tostring(data.unit:key()))

		alert_point.executing = true
		data.internal_data.is_on_alert_SO = true

        alert_point:on_executed(data.unit)
	end
end
function CopLogicBase.on_alert_administered(cop, params)
	if alive(cop) and Network:is_server() then
		local is_dead = cop:character_damage():dead()

		if not is_dead then
			managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "calling")
		else
			params.alert_point:remove_event_callback(tostring(cop:key()))

			params.alert_point.executing = false
			params.data.internal_data.is_on_alert_SO = false
		end
	end
end

function CopLogicBase.on_alert_completed(cop, params)
	params.alert_point.executing = false
	params.data.internal_data.is_on_alert_SO = false

	params.alert_point:remove_event_callback(tostring(cop:key()))

	if Network:is_server() then
		if not alive(cop) then
			managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "call_interrupted")

			return
		end

		local is_dead = cop:character_damage():dead()

		if is_dead then
			managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "call_interrupted")

			return
		end

		if not managers.groupai:state():is_ecm_jammer_active("call") then
			local group_state = managers.groupai:state()
			local cop_type = tostring(group_state.blame_triggers[cop:movement()._ext_base._tweak_table])

			managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "called")

			if cop_type == "civ" then
				group_state:on_police_called(cop:movement():coolness_giveaway())
			else
				group_state:on_police_called(cop:movement():coolness_giveaway())
			end
		else
			managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "call_interrupted")
		end
	end
end

function CopLogicBase.on_alert_failed(cop, params)
    params.alert_point.executing = false
	params.data.internal_data.is_on_alert_SO = false

	params.alert_point:remove_event_callback(tostring(cop:key()))

	if Network:is_server() then
		managers.groupai:state():on_criminal_suspicion_progress(nil, cop, "call_interrupted")
	end
end
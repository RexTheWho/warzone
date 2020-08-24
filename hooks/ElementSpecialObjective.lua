function ElementSpecialObjective:add_event_callback(name, callback, callback_id)
    local id = callback_id or "generic_id"
	self._events = self._events or {}
	self._events[name] = self._events[name] or {}
    self._events[name][id] = callback
end

function ElementSpecialObjective:remove_event_callback(callback_id)
    if self._events and self._events.complete then
		self._events.complete[callback_id] = nil
	end

	if self._events and self._events.fail then
		self._events.fail[callback_id] = nil
	end

	if self._events and self._events.administered then
		self._events.administered[callback_id] = nil
	end
end

function ElementSpecialObjective:event(name, unit)
	if self._events and self._events[name] then
		for _, callback in pairs(self._events[name]) do
			callback(unit)
		end
	end
end
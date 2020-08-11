Hooks:PreHook(PlayerParachuting,"enter","wz_chute",function(self, state_data, enter_data)
	self._unit:movement().fall_rotation = Rotation(0, 0, 0)
end)
function PlayerParachuting:_set_camera_limits()
	self._camera_unit:base():set_limits(self._tweak_data.camera.limits.spin, self._tweak_data.camera.limits.pitch)
end

function PlayerParachuting:_pitch_up()
	local t = Application:time()

	if self._camera_unit:base()._camera_properties.pitch > self._tweak_data.camera.target_pitch then
		self._camera_unit:base():animate_pitch(t, nil, self._tweak_data.camera.target_pitch, 1)
	end
end

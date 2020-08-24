
Hooks:PostHook(VehicleTweakData,"init","wz_init",function(self, tweak_data)

	self:_init_wz_cargo_truck()
	
end)

function VehicleTweakData:_init_wz_cargo_truck()
	self.wz_cargo_truck = {
		name = "",
		hud_label_offset = 0,
		animations = {
			passenger_back_right = "drive_muscle_back_right",
			vehicle_id = "muscle",
			passenger_back_left = "drive_muscle_back_left",
			passenger_front = "drive_muscle_passanger",
			driver = "drive_muscle_driver"
		},
		sound = {
			broken_engine = "falcogini_engine_broken_loop",
			bump = "car_bumper_01",
			lateral_slip_treshold = 0.35,
			bump_rtpc = "car_bump_vel",
			bump_treshold = 8,
			slip_stop = "car_skid_stop_01",
			slip = "car_skid_01",
			hit_rtpc = "car_hit_vel",
			engine_rpm_rtpc = "car_falcogini_rpm",
			longitudal_slip_treshold = 0.98,
			engine_speed_rtpc = "car_falcogini_speed",
			door_close = "car_door_open",
			engine_sound_event = "drive_truck",
			hit = "car_hit_gen_01"
		},
		seats = {
			driver = {
				driving = true,
				name = "driver"
			},
			passenger_front = {
				name = "passenger_front",
				has_shooting_mode = true,
				allow_shooting = false,
				driving = false,
				shooting_pos = Vector3(50, 0, 50)
			},
			passenger_back_left = {
				name = "passenger_back_left",
				driving = false,
				allow_shooting = true,
				has_shooting_mode = true
			},
			passenger_back_right = {
				name = "passenger_back_right",
				driving = false,
				allow_shooting = true,
				has_shooting_mode = true
			}
		},
		loot_points = {
			loot_left = {
				name = "loot_left"
			},
			loot_right = {
				name = "loot_right"
			}
		},
		damage = {
			max_health = 1200
		},
		camera_limits = {
			driver = {
				pitch = 45,
				yaw = 100
			},
			passenger = {
				pitch = 80,
				yaw = 140
			}
		},
		max_speed = 180,
		max_rpm = 6500,
		loot_drop_point = "interact_loot",
		max_loot_bags = 0,
		interact_distance = 400,
		driver_camera_offset = Vector3(0, 0.2, 2.5),
		fov = 75
	}
end


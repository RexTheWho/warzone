
function ElementVehicleSpawner:init(...)
	Application:trace("ElementVehicleSpawner:init")
	ElementVehicleSpawner.super.init(self, ...)

	self._vehicle_units = {}

	Application:trace("ElementVehicleSpawner:init")
	ElementVehicleSpawner.super.init(self, ...)

	self._vehicles = {
		wz_muscle_1 = "units/pd2_mod_wz/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1",
		wz_cargo_truck = "units/pd2_mod_wz/vehicles/fps_vehicle_m35_truck/fps_vehicle_m35_truck",
		wz_jeep_willy = "units/pd2_mod_wz/vehicles/fps_vehicle_jeep_willy/fps_vehicle_jeep_willy",
		wz_motorcross_bike = "units/pd2_mod_wz/vehicles/fps_vehicle_motorcross_bike/fps_vehicle_motorcross_bike",
		muscle = "units/pd2_dlc_shoutout_raid/vehicles/fps_vehicle_muscle_1/fps_vehicle_muscle_1",
		escape_van = "units/pd2_dlc_drive/vehicles/fps_vehicle_van_1/fps_vehicle_van_1",
		falcogini = "units/pd2_dlc_cage/vehicles/fps_vehicle_falcogini_1/fps_vehicle_falcogini_1"
	}
	
	self._vehicle_units = {}
end


function NavFieldBuilder:init()
	log("If you are seeing this I forgot to disable this, Yell at me. -Rex")
	self._door_access_types = {
		walk = 1
	}
	self._opposite_side_str = {
		x_neg = "x_pos",
		y_pos = "y_neg",
		y_neg = "y_pos",
		x_pos = "x_neg"
	}
	self._perp_pos_dir_str_map = {
		x_neg = "y_pos",
		y_pos = "x_pos",
		y_neg = "x_pos",
		x_pos = "y_pos"
	}
	self._perp_neg_dir_str_map = {
		x_neg = "y_neg",
		y_pos = "x_neg",
		y_neg = "x_neg",
		x_pos = "y_neg"
	}
	self._dim_str_map = {
		x_neg = "x",
		y_pos = "y",
		y_neg = "y",
		x_pos = "x"
	}
	self._perp_dim_str_map = {
		x_neg = "y",
		y_pos = "x",
		y_neg = "x",
		x_pos = "y"
	}
	self._neg_dir_str_map = {
		x_neg = true,
		y_neg = true
	}
	self._x_dir_str_map = {
		x_neg = true,
		x_pos = true
	}
	self._dir_str_to_vec = {
		x_pos = Vector3(1, 0, 0),
		x_neg = Vector3(-1, 0, 0),
		y_pos = Vector3(0, 1, 0),
		y_neg = Vector3(0, -1, 0)
	}
	
	--[[
		NOTES:
			Ground Padding:
				- Distance from ground
			Wall Padding:
				- Distance from wall in cm + 25cm
			Grid Size:
				- Going over 100 breaks navgen.
			
			
	]]--
	self._ground_padding = 35
	self._wall_padding = 24
	self._max_nr_rooms = 200000
	self._room_height = 70
	self._grid_size = 40
	self._air_ray_rad = self._grid_size * 1.2
	self._gnd_ray_rad = self._grid_size * 0.9
	self._room_dimention_max = 800
	self._raycast_dis_max = 8000
	self._max_fall = 800
	self._up_vec = Vector3(0, 0, self._ground_padding + self._grid_size)
	self._down_vec = Vector3(0, 0, -self._max_fall)
	self._slotmask = managers.slot:get_mask("AI_graph_obstacle_check")
	self._rooms = {}
	self._room_doors = {}
	self._visibility_groups = {}
	self._nav_segments = {}
	self._geog_segments = {}
	self._geog_segment_size = 500
	self._nr_geog_segments = nil
	self._geog_segment_offset = nil
end
/area/HS/planet
	name = "Mountains Air"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	default_gravity = STANDARD_GRAVITY
	requires_power = TRUE
	always_unpowered = TRUE
	static_lighting = TRUE
	base_lighting_alpha = 255
	base_lighting_color = "#FFF39F"
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	area_flags = UNIQUE_AREA
	outdoors = TRUE
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'modular_hsector/sound/ambient/wind-rustling-grass.ogg'
	ambient_buzz_vol = 35
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	allow_shuttle_docking = TRUE

/area/HS/planet/ground
	name = "Mountains Ground"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away2"
	requires_power = TRUE
	always_unpowered = TRUE
	static_lighting = TRUE
	base_lighting_alpha = 255
	base_lighting_color = "#FFF39F"
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	area_flags = UNIQUE_AREA
	outdoors = TRUE
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'modular_hsector/sound/ambient/wind-rustling-grass.ogg'
	ambient_buzz_vol = 35
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	allow_shuttle_docking = TRUE
	map_generator = /datum/map_generator/jungle_generator

/area/HS/underground
	name = "Mountain Caves"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED

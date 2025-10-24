/area/HS/bar/street
	name = "City Street"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	default_gravity = STANDARD_GRAVITY
	requires_power = FALSE
	always_unpowered = TRUE
	static_lighting = TRUE
	base_lighting_alpha = 0
	base_lighting_color = "#333121"
	power_light = TRUE
	power_equip = FALSE
	power_environ = TRUE
	area_flags = UNIQUE_AREA
	outdoors = TRUE
	ambience_index = AMBIENCE_GENERIC
	sound_environment = SOUND_ENVIRONMENT_CITY
	forced_ambience = TRUE
	ambientsounds = list('modular_hsector/sound/ambient/city_01.ogg', 'modular_hsector/sound/ambient/city_02.ogg', 'modular_hsector/sound/ambient/city_03.ogg', 'modular_hsector/sound/ambient/city_04.ogg')
	ambient_buzz = 'modular_hsector/sound/ambient/weather_storm.ogg'
	allow_shuttle_docking = TRUE

/area/HS/bar/street/bystreet
	name = "Bystreet"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away1"
	default_gravity = STANDARD_GRAVITY
	requires_power = FALSE
	always_unpowered = TRUE
	static_lighting = TRUE
	base_lighting_alpha = 0
	base_lighting_color = "#333121"
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	area_flags = UNIQUE_AREA
	outdoors = TRUE
	ambience_index = AMBIENCE_GENERIC
	sound_environment = SOUND_ENVIRONMENT_ALLEY
	forced_ambience = TRUE
	ambientsounds = list('modular_hsector/sound/ambient/city_01.ogg', 'modular_hsector/sound/ambient/city_02.ogg', 'modular_hsector/sound/ambient/city_03.ogg', 'modular_hsector/sound/ambient/city_04.ogg')
	ambient_buzz = 'modular_hsector/sound/ambient/weather_storm.ogg'
	allow_shuttle_docking = FALSE

/area/HS/bar/sewage
	name = "Sewage System"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away2"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	sound_environment = SOUND_ENVIRONMENT_STONE_CORRIDOR
	area_flags = UNIQUE_AREA

/area/HS/bar/laundry
	name = "Public Laundry"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away3"
	static_lighting = TRUE
	requires_power = FALSE
	ambient_buzz = 'modular_hsector/sound/ambient/laundry.ogg'
	default_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT

/area/HS/bar/news
	name = "News Room"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away4"
	static_lighting = TRUE
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT
	flags_1 = NONE

/area/HS/bar/indoors/nearwindow
	name = "Near Bar's Window"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away5"
	static_lighting = TRUE
	requires_power = FALSE
	ambient_buzz = 'modular_hsector/sound/ambient/indoor_weather_storm.ogg'
	ambient_buzz_vol = 20
	area_flags = UNIQUE_AREA

/area/HS/bar/indoors/staffroom
	name = "\improper Staff Storage"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away4"
	sound_environment = SOUND_AREA_STANDARD_STATION
	area_flags = UNIQUE_AREA

/area/HS/bar/indoors/bar
	name = "\improper Bar"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away5"
	mood_message = "I love being in the bar!"
	mood_trait = TRAIT_EXTROVERT
	ambient_buzz = FALSE
	ambient_buzz_vol = 0
	sound_environment = SOUND_AREA_WOODFLOOR

/area/HS/bar/indoors/bar/enter
	name = "\improper Bar Enter"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away2"
	forced_ambience = TRUE
	ambient_buzz = 'modular_hsector/sound/ambient/indoor_weather_storm.ogg'
	ambient_buzz_vol = 20
	sound_environment = SOUND_AREA_WOODFLOOR

/area/HS/bar/indoors/rooms
	name = "Motel Rooms"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away7"
	sound_environment = SOUND_AREA_STANDARD_STATION
	area_flags = UNIQUE_AREA

/area/HS/bar/indoors/rooms/room1
	name = "\improper Room 1"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/room2
	name = "\improper Room 2"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/room3
	name = "\improper Room 3"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/room4
	name = "\improper Room 4"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/room5
	name = "\improper Room 5"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/apartments/apartment1
	name = "\improper Apartment Room 1"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/apartments/apartment2
	name = "\improper Apartment Room 3"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/rooms/apartments/apartment3
	name = "\improper Apartment Corridor"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/corridor
	name = "\improper Corridor"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment1
	name = "\improper Apartment #217"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment2
	name = "\improper Apartment #218"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment3
	name = "\improper Apartment #219"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment4
	name = "\improper Apartment #220"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment5
	name = "\improper Apartment #221"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment6
	name = "\improper Apartment #222"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment7
	name = "\improper Apartment #223"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment8
	name = "\improper Apartment #224"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment9
	name = "\improper Apartment #225"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment10
	name = "\improper Apartment #226"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

/area/HS/bar/indoors/skyscraper/apartments/apartment11
	name = "\improper Apartment #227"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away8"

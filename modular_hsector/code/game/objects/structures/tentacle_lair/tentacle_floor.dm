#define TENTACLE_NODERANGE 3

/obj/structure/tentacle_lair/weeds
	gender = PLURAL
	name = "tentacle weeds"
	desc = "A thick tentacle surface covers the floor."
	anchored = TRUE
	density = FALSE
	layer = MID_TURF_LAYER
	plane = FLOOR_PLANE
	icon_state = "weeds"
	max_integrity = 15
	canSmoothWith = list(/obj/structure/tentacle_lair/weeds, /turf/closed/wall)
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_WEEDS + SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_WEEDS + SMOOTH_GROUP_WALLS
	var/last_expand = 0 //last world.time this weed expanded
	var/growth_cooldown_low = 150
	var/growth_cooldown_high = 200
	var/static/list/blacklisted_turfs

/obj/structure/tentacle_lair/weeds/Initialize(mapload)
	pixel_x = -4
	pixel_y = -4 //so the sprites line up right in the map editor
	. = ..()

	if(!blacklisted_turfs)
		blacklisted_turfs = typecacheof(list(
			/turf/open/space,
			/turf/open/chasm,
			/turf/open/lava,
			/turf/open/openspace))

	last_expand = world.time + rand(growth_cooldown_low, growth_cooldown_high)
	if(icon == initial(icon))
		switch(rand(1,3))
			if(1)
				icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_floor.dmi'
			if(2)
				icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_floor2.dmi'
			if(3)
				icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_fl_2.dmi'

	if(prob(33))
		new /obj/structure/tentacle_lair/moving_tentacle(src.loc)
	else if(prob(20))
		//new /mob/living/simple_animal/hostile/tentacles/old(src.loc)
	else if(prob(15))
		new /obj/structure/tentacle_lair/tentacle_nest(src.loc)
	else if(prob(10))
		new /obj/structure/tentacle_lair/tentacle_nest/large(src.loc)
	else if(prob(5))
		new /obj/structure/tentacle_lair/eye(src.loc)

/obj/structure/tentacle_lair/weeds/proc/expand()
	var/turf/U = get_turf(src)
	if(is_type_in_typecache(U, blacklisted_turfs))
		qdel(src)
		return FALSE

	for(var/turf/T in get_adjacent_open_turfs(U))
		if(locate(/obj/structure/tentacle_lair/weeds) in T)
			continue

		if(is_type_in_typecache(T, blacklisted_turfs))
			continue

		new /obj/structure/tentacle_lair/weeds(T)
	return TRUE

/obj/structure/tentacle_lair/weeds/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

//Weed nodes
/obj/structure/tentacle_lair/weeds/node
	name = "growing tentacles"
	desc = "A growing tentacle surface covers the floor."
	icon_state = "weednode"
	var/node_range = TENTACLE_NODERANGE

/obj/structure/tentacle_lair/weeds/node/Initialize(mapload)
	icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_fl_2.dmi'
	. = ..()
	var/obj/structure/tentacle_lair/weeds/W = locate(/obj/structure/tentacle_lair/weeds) in loc
	if(W && W != src)
		qdel(W)
	START_PROCESSING(SSobj, src)

	if(prob(33))
		new /obj/structure/tentacle_lair/moving_tentacle(src.loc)

/obj/structure/tentacle_lair/weeds/node/eye
	name = "tentacle watcher"
	desc = "A growing tentacle surface comes from it."
	icon_state = "eye"
	layer = TURF_DECAL_LAYER
	plane = FLOOR_PLANE

/obj/structure/tentacle_lair/weeds/node/eye/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	new /obj/structure/tentacle_lair/weeds(src.loc)

/obj/structure/tentacle_lair/weeds/node/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/tentacle_lair/weeds/node/process()
	for(var/obj/structure/tentacle_lair/weeds/W in range(node_range, src))
		if(W.last_expand <= world.time)
			if(W.expand())
				W.last_expand = world.time + rand(growth_cooldown_low, growth_cooldown_high)

#undef TENTACLE_NODERANGE

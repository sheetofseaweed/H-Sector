/obj/structure/tentacle_lair/tentacle_nest
	name = "tentacle nest"
	desc = "It's a gruesome pile of thick, sticky resin shaped like a nest."
	icon_state = "tentacle_nest"
	max_integrity = 120
	can_be_unanchored = FALSE
	can_buckle = TRUE
	buckle_lying = 0
	dir = 2
	//can_deconstruct = FALSE
	var/static/mutable_appearance/nest_overlay = mutable_appearance('modular_hsector/icons/obj/tentacle_lair/tentacle_unified.dmi', "nest_overlay", LYING_MOB_LAYER)

/obj/structure/tentacle_lair/tentacle_nest/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	if(has_buckled_mobs())
		for(var/buck in buckled_mobs) //breaking a nest releases all the buckled mobs, because the nest isn't holding them down anymore
			var/mob/living/M = buck

			if(M != user)
				M.visible_message(\
					"[user.name] pulls [M.name] free from the [src]!",\
					"<span class='notice'>[user.name] pulls you free from the [src].</span>",\
					"<span class='italics'>You hear squelching...</span>")
			else
				M.visible_message(\
					"<span class='warning'>[M.name] struggles to break free from the [src]!</span>",\
					"<span class='notice'>You struggle to break free from the [src]... (Stay still for two minutes.)</span>",\
					"<span class='italics'>You hear squelching...</span>")
				if(!do_after(M, 2 MINUTES, target = src, hidden = TRUE))
					if(M && M.buckled)
						to_chat(M, "<span class='warning'>You fail to unbuckle yourself!</span>")
					return
				if(!M.buckled)
					return
				M.visible_message(\
					"<span class='warning'>[M.name] breaks free from the [src]!</span>",\
					"<span class='notice'>You break free from the [src]!</span>",\
					"<span class='italics'>You hear squelching...</span>")

			unbuckle_mob(M)
			add_fingerprint(user)

/obj/structure/tentacle_lair/tentacle_nest/user_buckle_mob(mob/living/M, mob/living/carbon/user, check_loc)
	if ( !ismob(M) || (get_dist(src, user) > 1) || (M.loc != src.loc) || user.incapacitated || M.buckled )
		return

	if(buckle_mob(M))
		M.visible_message(\
			"[user.name] secretes a thick goo, securing [M.name] into [src]!",\
			"<span class='danger'>[user.name] drenches you in a resin, trapping you in [src]!</span>",\
			"<span class='italics'>You hear squelching...</span>")

/obj/structure/tentacle_lair/tentacle_nest/post_buckle_mob(mob/living/M)
	M.pixel_y = M.base_pixel_y
	M.pixel_x = M.base_pixel_x + 2
	M.layer = BELOW_MOB_LAYER
	add_overlay(nest_overlay)

/obj/structure/tentacle_lair/tentacle_nest/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.base_pixel_x + M.body_position_pixel_x_offset
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset
	M.layer = initial(M.layer)
	cut_overlay(nest_overlay)

/obj/structure/tentacle_lair/tentacle_nest/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, 1)
		if(BURN)
			playsound(loc, 'sound/items/tools/welder.ogg', 100, 1)

/obj/structure/tentacle_lair/tentacle_nest/large
	name = "tentacle pillar"
	desc = "It's a gruesome pile of thick, sticky resin shaped like a pillar."
	icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_blob_big.dmi'
	icon_state = "tentacle_nest"
	max_integrity = 240

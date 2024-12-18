/obj/structure/tentacle_lair
	icon = 'modular_hsector/icons/obj/tentacle_lair/tentacle_unified.dmi'
	max_integrity = 100

/obj/structure/tentacle_lair/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "melee")
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	. = ..()

/obj/structure/tentacle_lair/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, 1)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, 1)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, 1)

/obj/structure/tentacle_lair/eye
	name = "the watching eye"
	desc = "I watches."
	icon_state = "eye"

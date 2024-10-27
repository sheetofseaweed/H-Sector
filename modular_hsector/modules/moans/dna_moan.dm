/datum/species/get_moan_sound(mob/living/carbon/human/species)
	if(species.physique == FEMALE)
		return pick(
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg',
		)
	else
		return pick(
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
			'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg',
		)

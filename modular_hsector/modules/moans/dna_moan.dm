/datum/species/get_moan_sound(mob/living/carbon/human/species)
	if(species.physique == FEMALE)
		return pick(
			'modular_zzplurt/sound/interactions/moan_m1.ogg',
			'modular_zzplurt/sound/interactions/moan_m2.ogg',
			'modular_zzplurt/sound/interactions/moan_m3.ogg',
			'modular_zzplurt/sound/interactions/moan_m4.ogg',
			'modular_zzplurt/sound/interactions/moan_m5.ogg',
			'modular_zzplurt/sound/interactions/moan_m6.ogg',
			'modular_zzplurt/sound/interactions/moan_m7.ogg',
		)
	else
		return pick(
			'modular_zzplurt/sound/interactions/moan_f1.ogg',
			'modular_zzplurt/sound/interactions/moan_f2.ogg',
			'modular_zzplurt/sound/interactions/moan_f3.ogg',
			'modular_zzplurt/sound/interactions/moan_f4.ogg',
			'modular_zzplurt/sound/interactions/moan_f5.ogg',
			'modular_zzplurt/sound/interactions/moan_f6.ogg',
			'modular_zzplurt/sound/interactions/moan_f7.ogg',
		)

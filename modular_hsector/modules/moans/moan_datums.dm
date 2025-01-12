GLOBAL_LIST_EMPTY(moan_types)

/datum/moan_type
	var/name
	var/list/male_moansounds
	var/list/female_moansounds

///datum/moan_type/none //Why would you want this?
//	name = "No Moan"
//	male_moansounds = null
//	female_moansounds = null

/datum/moan_type/human_deafault
	name = "Default Moans - Both Sexes"
	male_moansounds = list(
		'modular_zzplurt/sound/interactions/moan_m1.ogg',
		'modular_zzplurt/sound/interactions/moan_m2.ogg',
		'modular_zzplurt/sound/interactions/moan_m3.ogg',
		'modular_zzplurt/sound/interactions/moan_m4.ogg',
		'modular_zzplurt/sound/interactions/moan_m5.ogg',
		'modular_zzplurt/sound/interactions/moan_m6.ogg',
		'modular_zzplurt/sound/interactions/moan_m7.ogg',
	)
	female_moansounds = list(
		'modular_zzplurt/sound/interactions/moan_f1.ogg',
		'modular_zzplurt/sound/interactions/moan_f2.ogg',
		'modular_zzplurt/sound/interactions/moan_f3.ogg',
		'modular_zzplurt/sound/interactions/moan_f4.ogg',
		'modular_zzplurt/sound/interactions/moan_f5.ogg',
		'modular_zzplurt/sound/interactions/moan_f6.ogg',
		'modular_zzplurt/sound/interactions/moan_f7.ogg',
	)

/datum/moan_type/human_male_1
	name = "Male Only"
	male_moansounds = list(
		'modular_zzplurt/sound/interactions/moan_m1.ogg',
		'modular_zzplurt/sound/interactions/moan_m2.ogg',
		'modular_zzplurt/sound/interactions/moan_m3.ogg',
		'modular_zzplurt/sound/interactions/moan_m4.ogg',
		'modular_zzplurt/sound/interactions/moan_m5.ogg',
		'modular_zzplurt/sound/interactions/moan_m6.ogg',
		'modular_zzplurt/sound/interactions/moan_m7.ogg',
	)
	female_moansounds = null

/datum/moan_type/human_female_1
	name = "Female Only"
	male_moansounds = list(
		'modular_zzplurt/sound/interactions/moan_f1.ogg',
		'modular_zzplurt/sound/interactions/moan_f2.ogg',
		'modular_zzplurt/sound/interactions/moan_f3.ogg',
		'modular_zzplurt/sound/interactions/moan_f4.ogg',
		'modular_zzplurt/sound/interactions/moan_f5.ogg',
		'modular_zzplurt/sound/interactions/moan_f6.ogg',
		'modular_zzplurt/sound/interactions/moan_f7.ogg',
	)
	female_moansounds = null

/datum/moan_type/human_male_2
	name = "Male Rough"
	male_moansounds = list(
		'modular_zzplurt/sound/interactions/moan_m4.ogg',
		'modular_zzplurt/sound/interactions/moan_m5.ogg',
		'modular_zzplurt/sound/interactions/moan_m6.ogg',
		'modular_zzplurt/sound/interactions/moan_m7.ogg',
		'modular_zzplurt/sound/interactions/moan_m12.ogg',
	)
	female_moansounds = null

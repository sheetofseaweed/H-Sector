GLOBAL_LIST_EMPTY(moan_types)

/datum/moan_type
	var/name
	var/list/male_moansounds
	var/list/female_moansounds

/datum/moan_type/none //Why would you want this?
	name = "No Moan"
	male_moansounds = null
	female_moansounds = null

/datum/moan_type/human
	name = "Moan Placeholder"
	male_moansounds = list(
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg',
	)
	female_moansounds = list(
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
		'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg',
	)

/datum/moan_type/human_two
	name = "Moan Placeholder 2"
	male_moansounds = list(
		'sound/mobs/humanoids/human/scream/malescream_1.ogg',
		'sound/mobs/humanoids/human/scream/malescream_2.ogg',
		'sound/mobs/humanoids/human/scream/malescream_3.ogg',
		'sound/mobs/humanoids/human/scream/malescream_4.ogg',
		'sound/mobs/humanoids/human/scream/malescream_5.ogg',
		'sound/mobs/humanoids/human/scream/malescream_6.ogg',
	)
	female_moansounds = list(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)
/datum/moan_type/human_two
	name = "Moan Placeholder only male"
	male_moansounds = list(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)
	female_moansounds = null


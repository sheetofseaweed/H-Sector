/obj/item/organ/external/genital/butt
	name = "butt"
	desc = "The thing you sit on."
	icon_state = "butt"
	icon = 'modular_hsector/icons/bodyparts/butt.dmi'//hack
	genital_type = "pair"
	mutantpart_key = ORGAN_SLOT_BUTT
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_BUTT
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	aroused = AROUSAL_CANT
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/butt

/obj/item/organ/external/genital/butt/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a butt."
	var/size_description
	var/translation = butt_size_to_text(genital_size)
	switch(translation)
		if("flat")
			size_description = " It's completely flat, however."
		else
			size_description = " It looks [translation]."
	returned_string += size_description
	return returned_string

/obj/item/organ/external/genital/butt/set_size(size)
	. = ..()
	spawn(0) //set_size is called by build_from_dna.. which executes before Insert assigns owner. This gets around that
		var/obj/item/organ/external/genital/anus/anus = owner?.get_organ_slot(ORGAN_SLOT_ANUS) //sometimes
		if(!anus)
			return

		anus.set_size(size)

/obj/item/organ/external/genital/butt/get_sprite_size_string()
	var/max_size = 4
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "[genital_type]_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/external/genital/butt/update_genital_icon_state()
	var/max_size = 4
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "butt_pair_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/external/genital/butt/proc/butt_size_to_text(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.butt_size_translation["[number]"]
	if(!returned)
		returned = "flat"
	return returned

/obj/item/organ/external/genital/butt/proc/butt_text_to_size(size)
	for(var/key in GLOB.butt_size_translation)
		if(GLOB.butt_size_translation[key] == size)
			return text2num(key)
	return 0

/obj/item/organ/external/genital/butt/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["butt_uses_skincolor"]
	set_size(DNA.features["butt_size"])

	return ..()

/obj/item/organ/external/genital/butt/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["butt_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/datum/bodypart_overlay/mutant/genital/butt
	feature_key = ORGAN_SLOT_BUTT
	layers = EXTERNAL_BODY_LAYER

/datum/bodypart_overlay/mutant/genital/butt/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BUTT]


/obj/item/organ/external/genital/belly
	name = "belly"
	desc = "You put food in there."
	icon = null //apparently theres no organ sprite?
	icon_state = null
	drop_when_organ_spilling = FALSE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BELLY
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/belly

	genital_location = CHEST
	aroused = AROUSAL_CANT

	mutantpart_key = ORGAN_SLOT_BELLY
	mutantpart_info = list(MUTANT_INDEX_NAME = "Belly", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	genital_type = "pair"

/obj/item/organ/external/genital/belly/update_genital_icon_state()
	var/max_size = 4
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "belly_pair_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/external/genital/belly/get_sprite_size_string()
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

/obj/item/organ/external/genital/belly/set_size(size)
	var/old_size = genital_size
	. = ..()
	if(size > old_size)
		to_chat(owner, span_warning("Your belly [pick("swell up to", "gurgle into", "expand into", "plump up into", "grow eagerly into", "fatten up into", "distend into")] a larger midsection."))
	else
		to_chat(owner, span_warning("Your belly [pick("shrink down to", "decrease into", "wobble down into", "diminish into", "deflate into", "contracts into")] a smaller midsection."))


/obj/item/organ/external/genital/belly/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["belly_uses_skincolor"]
	set_size(DNA.features["belly_size"])

	return ..()

/obj/item/organ/external/genital/belly/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["belly_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading


/obj/item/organ/external/genital/belly/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a belly."
	var/size_description
	var/translation = belly_size_to_text(genital_size)
	switch(translation)
		if("flat")
			size_description = " It's completely flat, however."
		else
			size_description = " It looks [translation]."
	returned_string += size_description
	return returned_string

/obj/item/organ/external/genital/belly/proc/belly_size_to_text(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.belly_size_translation["[number]"]
	if(!returned)
		returned = "flat"
	return returned

/obj/item/organ/external/genital/belly/proc/belly_text_to_size(size)
	for(var/key in GLOB.belly_size_translation)
		if(GLOB.belly_size_translation[key] == size)
			return text2num(key)
	return 0
/datum/bodypart_overlay/mutant/genital/belly
	feature_key = ORGAN_SLOT_BELLY
	layers = EXTERNAL_BODY_LAYER

/datum/bodypart_overlay/mutant/genital/belly/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BELLY]


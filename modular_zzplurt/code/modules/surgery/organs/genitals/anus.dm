/obj/item/organ/external/genital/anus/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see an [lowertext(genital_name)]."
	if(aroused == AROUSAL_PARTIAL)
		returned_string += " It looks tight."
	if(aroused == AROUSAL_FULL)
		returned_string += " It looks very tight."
	return returned_string

/obj/item/organ/external/genital/anus/get_sprite_size_string()
	. = "[genital_type]_[floor(genital_size)]"
	if(uses_skintones)
		. += "_s"

/obj/item/organ/external/genital/anus/build_from_dna(datum/dna/DNA, associated_key)
	set_size(DNA.features["butt_size"]) // yes
	uses_skin_color = DNA.features["anus_uses_skincolor"]

	return ..()

/datum/bodypart_overlay/mutant/genital/anus
	layers = EXTERNAL_BODY_LAYER
	feature_key = ORGAN_SLOT_ANUS

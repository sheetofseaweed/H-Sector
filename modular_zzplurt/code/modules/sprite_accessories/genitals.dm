/datum/sprite_accessory/genital/butt
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/butt_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/butt
	associated_organ_slot = ORGAN_SLOT_BUTT
	key = ORGAN_SLOT_BUTT
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	has_skintone_shading = TRUE
	relevent_layers = list(BODYPARTS_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/butt/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/butt/normal
	icon_state = "pair"
	name = "Butt"

/datum/sprite_accessory/genital/anus
	icon = 'modular_zzplurt/icons/mob/human/genitals/anus.dmi'
	color_src = USE_MATRIXED_COLORS
	has_skintone_shading = TRUE
	always_color_customizable = TRUE
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/genital/anus/is_hidden(mob/living/carbon/human/target_mob)
	//TODO: make this check use the butt sprite accessory just for good measure
	if(!target_mob.has_butt(REQUIRE_GENITAL_EXPOSED))
		return TRUE
	. = ..()

/datum/sprite_accessory/genital/anus/donut
	icon_state = "donut"
	name = "Donut"

/datum/sprite_accessory/genital/anus/squished
	icon_state = "squished"
	name = "Squished"

/datum/sprite_accessory/genital/belly //hsector add
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/belly_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/belly
	associated_organ_slot = ORGAN_SLOT_BELLY
	key = ORGAN_SLOT_BELLY
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	genetic = TRUE
	relevent_layers = list(BODYPARTS_LAYER)

/datum/sprite_accessory/genital/belly/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/belly/normal
	icon_state = "pair"
	name = "Belly"

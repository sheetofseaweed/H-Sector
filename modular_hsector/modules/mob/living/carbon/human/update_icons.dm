#define RESOLVE_ICON_STATE(worn_item) (worn_item.worn_icon_state || worn_item.icon_state)
#define CROTCH_INDEX 1
#define PENIS_INDEX 2
#define VAGINA_INDEX 3
#define ANUS_INDEX 4
#define NIPPLES_INDEX 5
#define MOUTH_INDEX 6

/mob/living/carbon/human/update_worn_penis(update_obscured = TRUE)
	remove_overlay(PENIS_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[PENIS_INDEX]
		inv.update_icon()

	if(istype(penis, /obj/item))
		var/obj/item/willy = penis
		update_hud_penis(willy)

		update_worn_penis(update_obscured = FALSE)

		if(penis_hidden())
			return

		var/target_overlay = willy.icon_state
		var/mutable_appearance/penis_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/mutant_styles = NONE
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, penis, src)


		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(willy)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		penis_overlay = willy.build_worn_icon(
			default_layer = PENIS_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)


		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(penis_overlay)
		overlays_standing[PENIS_LAYER] = penis_overlay
		apply_overlay(PENIS_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_vagina(update_obscured = TRUE)
	remove_overlay(VAGINA_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[VAGINA_INDEX]
		inv.update_icon()

	if(istype(vagina, /obj/item))
		var/obj/item/clothing/underwear/briefs/cooter = vagina
		update_hud_vagina(cooter)

		update_worn_vagina(update_obscured = FALSE)

		if(vagina_hidden())
			return

		var/target_overlay = cooter.icon_state
		var/mutable_appearance/vagina_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/mutant_styles = NONE
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, vagina, src)

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(cooter)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		vagina_overlay = cooter.build_worn_icon(
			default_layer = VAGINA_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)


		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(vagina_overlay)
		overlays_standing[VAGINA_LAYER] = vagina_overlay
		apply_overlay(VAGINA_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_anus(update_obscured = TRUE)
	remove_overlay(ANUS_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[ANUS_INDEX]
		inv.update_icon()

	if(istype(anus, /obj/item))

		var/obj/item/bum = anus
		update_hud_anus(bum)

		update_worn_anus(update_obscured = FALSE)

		if(anus_hidden())
			return

		var/target_overlay = bum.icon_state
		var/mutable_appearance/anus_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/mutant_styles = NONE
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, anus, src)


		anus_overlay = bum.build_worn_icon(
			default_layer = ANUS_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)


		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(anus_overlay)
		overlays_standing[ANUS_LAYER] = anus_overlay
		apply_overlay(ANUS_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_nipples(update_obscured = TRUE)
	remove_overlay(NIPPLES_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[NIPPLES_INDEX]
		inv.update_icon()

	if(istype(nipples, /obj/item))
		var/obj/item/clothing/underwear/shirt/bra/nips = nipples
		update_hud_nipples(nips)

		update_worn_nipples(update_obscured = FALSE)

		if(nipples_hidden())
			return

		var/target_overlay = nipples.icon_state
		var/mutable_appearance/nipples_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/mutant_styles = NONE


		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_SHIRT, nipples, src)

		nipples_overlay = nips.build_worn_icon(
			default_layer = NIPPLES_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_shirt_offset?.apply_offset(nipples_overlay)
		overlays_standing[NIPPLES_LAYER] = nipples_overlay
		apply_overlay(NIPPLES_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_mouth(update_obscured = TRUE)
	remove_overlay(MOUTH_LAYER)

	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	if(isnull(my_head)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[MOUTH_INDEX]
		inv.update_icon()

	if(istype(mouth, /obj/item))
		var/obj/item/worn_item = mouth
		update_hud_mouth(worn_item)

		update_worn_mouth(update_obscured = FALSE)

		if(obscured_slots & ITEM_SLOT_EARS_RIGHT)
			return

		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'//REPLACE

		// SKYRAT EDIT ADDITION
		var/mutant_override = FALSE
		if(bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_FACEMASK, mouth, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		// SKYRAT EDIT END

		var/mutable_appearance/mouth_overlay = mouth.build_worn_icon(default_layer = MOUTH_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		// SKYRAT EDIT ADDITION
		if(!mutant_override)
			my_head.worn_mask_offset?.apply_offset(mouth_overlay)
		// SKYRAT EDIT END
		overlays_standing[MOUTH_LAYER] = mouth_overlay
	apply_overlay(MOUTH_LAYER)

/mob/living/carbon/human/update_worn_crotch(update_obscured = TRUE)
	remove_overlay(CROTCH_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[CROTCH_INDEX]
		inv.update_icon()

	if(istype(crotch, /obj/item))
		var/obj/item/pubic = crotch
		update_hud_crotch(pubic)

		update_worn_nipples(update_obscured = FALSE)

		if(underwear_hidden())
			return

		var/target_overlay = pubic.icon_state
		var/mutable_appearance/crotch_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/mutant_styles = NONE
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, crotch, src)

		crotch = pubic.build_worn_icon(
			default_layer = CROTCH_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(crotch_overlay)
		overlays_standing[CROTCH_LAYER] = crotch_overlay
		apply_overlay(CROTCH_LAYER)

	update_body_parts()

#undef PENIS_INDEX
#undef VAGINA_INDEX
#undef ANUS_INDEX
#undef NIPPLES_INDEX
#undef MOUTH_INDEX
#undef CROTCH_INDEX
#undef RESOLVE_ICON_STATE

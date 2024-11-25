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

		if(update_obscured)
			update_obscured_slots(willy.flags_inv)

		if(penis_hidden())
			return

		var/target_overlay = willy.icon_state
		var/mutable_appearance/penis_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		//var/digi
		//var/woman
		//var/female_sprite_flags = penis.female_sprite_flags
		var/mutant_styles = NONE
		/*if((bodyshape & BODYSHAPE_DIGITIGRADE) && (willy.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = willy.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(willy.worn_icon_digi == willy.worn_icon)
				target_overlay += "_d"*/

		//else
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, penis, src)

		//Female sprites have lower priority than digitigrade sprites
		/*if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			*/// SKYRAT EDIT ADDITION END

		/*if(digi)
			mutant_styles |= STYLE_DIGI*/

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(willy)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		penis_overlay = willy.build_worn_icon(
			default_layer = PENIS_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			//female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		//if(willy.flags_1 & IS_PLAYER_COLORABLE_1)
		//	penis_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(penis_overlay)
		overlays_standing[PENIS_LAYER] = penis_overlay
		apply_overlay(PENIS_LAYER)

		/*
			if(!icon_exists(icon_file, RESOLVE_ICON_STATE(undies)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		underwear_overlay = undies.build_worn_icon(
			default_layer = UNDERWEAR_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		if(undies.flags_1 & IS_PLAYER_COLORABLE_1)
			underwear_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(underwear_overlay)
		overlays_standing[UNDERWEAR_LAYER] = underwear_overlay
		apply_overlay(UNDERWEAR_LAYER)

	update_mutant_bodyparts()
		*/
	update_mutant_bodyparts()

/mob/living/carbon/human/update_worn_vagina(update_obscured = TRUE)
	remove_overlay(VAGINA_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[VAGINA_INDEX]
		inv.update_icon()

	if(istype(vagina, /obj/item))
		var/obj/item/clothing/underwear/briefs/cooter = vagina
		update_hud_vagina(cooter)

		if(update_obscured)
			update_obscured_slots(cooter.flags_inv)

		if(vagina_hidden())
			return

		var/target_overlay = cooter.icon_state
		var/mutable_appearance/vagina_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		//var/digi
		//var/woman
		//var/female_sprite_flags = vagina.female_sprite_flags
		var/mutant_styles = NONE
		/*if((bodyshape & BODYSHAPE_DIGITIGRADE) && (cooter.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = cooter.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(cooter.worn_icon_digi == cooter.worn_icon)
				target_overlay += "_d"*/

		//else
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, vagina, src)

		//Female sprites have lower priority than digitigrade sprites
		/*if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			// SKYRAT EDIT ADDITION END

		if(digi)
			mutant_styles |= STYLE_DIGI*/

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(cooter)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE

		vagina_overlay = cooter.build_worn_icon(
			default_layer = VAGINA_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			//female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		//if(cooter.flags_1 & IS_PLAYER_COLORABLE_1)
		//	vagina_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(vagina_overlay)
		overlays_standing[VAGINA_LAYER] = vagina_overlay
		apply_overlay(VAGINA_LAYER)

	update_mutant_bodyparts()

/mob/living/carbon/human/update_worn_anus(update_obscured = TRUE)
	remove_overlay(ANUS_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[ANUS_INDEX]
		inv.update_icon()

	if(istype(anus, /obj/item))

		var/obj/item/bum = anus
		update_hud_anus(bum)

		if(update_obscured)
			update_obscured_slots(bum.flags_inv)

		if(anus_hidden())
			return

		var/target_overlay = bum.icon_state
		var/mutable_appearance/anus_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		//var/digi
		//var/woman
		//var/female_sprite_flags = anus.female_sprite_flags
		var/mutant_styles = NONE
		/*if((bodyshape & BODYSHAPE_DIGITIGRADE) && (willy.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = willy.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(willy.worn_icon_digi == willy.worn_icon)
				target_overlay += "_d"*/

		//else
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, anus, src)

		//Female sprites have lower priority than digitigrade sprites
		/*if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			*/// SKYRAT EDIT ADDITION END

		/*if(digi)
			mutant_styles |= STYLE_DIGI*/

		/*if(!icon_exists(icon_file, RESOLVE_ICON_STATE(willy)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE*/

		anus_overlay = bum.build_worn_icon(
			default_layer = ANUS_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			//female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		//if(bum.flags_1 & IS_PLAYER_COLORABLE_1)
		//	anus_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(anus_overlay)
		overlays_standing[ANUS_LAYER] = anus_overlay
		apply_overlay(ANUS_LAYER)

	update_mutant_bodyparts()

/mob/living/carbon/human/update_worn_nipples(update_obscured = TRUE)
	remove_overlay(NIPPLES_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.lewd_inventory[NIPPLES_INDEX]
		inv.update_icon()

	if(istype(nipples, /obj/item))
		var/obj/item/clothing/underwear/shirt/bra/nips = nipples
		update_hud_nipples(nips)

		if(update_obscured)
			update_obscured_slots(nips.flags_inv)

		if(nipples_hidden())
			return

		var/target_overlay = nipples.icon_state
		var/mutable_appearance/nipples_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		//var/digi
		//var/woman
		//var/female_sprite_flags = nipples.female_sprite_flags
		var/mutant_styles = NONE

		/*if((bodyshape & BODYSHAPE_DIGITIGRADE) && (bra.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = bra.worn_icon_digi || DIGITIGRADE_SHIRT_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(bra.worn_icon_digi == bra.worn_icon)
				target_overlay += "_d"*/

		//else
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_SHIRT, nipples, src)

		//Female sprites have lower priority than digitigrade sprites
		/*if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			*/// SKYRAT EDIT ADDITION END

		/*if(digi)
			mutant_styles |= STYLE_DIGI

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(bra)))
			icon_file = DEFAULT_SHIRT_FILE
			handled_by_bodyshape = FALSE*/

		nipples_overlay = nips.build_worn_icon(
			default_layer = NIPPLES_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			//female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		//if(bra.flags_1 & IS_PLAYER_COLORABLE_1)
		//	nipples_overlay.color = bra_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_shirt_offset?.apply_offset(nipples_overlay)
		overlays_standing[NIPPLES_LAYER] = nipples_overlay
		apply_overlay(NIPPLES_LAYER)

	update_mutant_bodyparts()

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

		if(update_obscured)
			update_obscured_slots(worn_item.flags_inv)

		var/obscured_slots = check_obscured_slots(transparent_protection = TRUE)
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

		if(update_obscured)
			update_obscured_slots(pubic.flags_inv)

		if(underwear_hidden())
			return

		var/target_overlay = pubic.icon_state
		var/mutable_appearance/crotch_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		//var/digi
		//var/woman
		//var/female_sprite_flags = crotch.female_sprite_flags
		var/mutant_styles = NONE
		/*if((bodyshape & BODYSHAPE_DIGITIGRADE) && (willy.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = willy.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE

			// Edit for legacy sprites
			if(willy.worn_icon_digi == willy.worn_icon)
				target_overlay += "_d"*/

		//else
		if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, crotch, src)

		//Female sprites have lower priority than digitigrade sprites
		/*if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			// SKYRAT EDIT ADDITION START - Digi female gender shaping
			if(digi)
				if(!(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
					female_sprite_flags &= ~FEMALE_UNIFORM_FULL // clear the FEMALE_UNIFORM_DIGI_FULL bit if it was set, we don't want that.
					female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY // And set the FEMALE_UNIFORM_TOP bit if it is unset.
			*/// SKYRAT EDIT ADDITION END

		/*if(digi)
			mutant_styles |= STYLE_DIGI*/

		/*if(!icon_exists(icon_file, RESOLVE_ICON_STATE(willy)))
			icon_file = DEFAULT_UNDERWEAR_FILE
			handled_by_bodyshape = FALSE*/

		crotch = pubic.build_worn_icon(
			default_layer = CROTCH_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			//female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		//if(pubic.flags_1 & IS_PLAYER_COLORABLE_1)
		//	crotch_overlay.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(crotch_overlay)
		overlays_standing[CROTCH_LAYER] = crotch_overlay
		apply_overlay(CROTCH_LAYER)

	update_mutant_bodyparts()

#undef PENIS_INDEX
#undef VAGINA_INDEX
#undef ANUS_INDEX
#undef NIPPLES_INDEX
#undef MOUTH_INDEX
#undef CROTCH_INDEX
#undef RESOLVE_ICON_STATE

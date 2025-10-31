#define RESOLVE_ICON_STATE(worn_item) (worn_item.worn_icon_state || worn_item.icon_state)

#define UNDERWEAR_INDEX 1
#define SOCKS_INDEX 2
#define SHIRT_INDEX 3
#define BRA_INDEX 4
#define EARS_EXTRA_INDEX 5
#define WRISTS_INDEX 6

/mob/living/carbon/human/regenerate_icons()
	. = ..()
	if(.)
		return
	update_worn_shirt()
	update_worn_bra()
	update_worn_underwear()
	update_worn_wrists()
	update_worn_ears_extra()
	update_worn_socks()
	//
	update_worn_penis()
	update_worn_vagina()
	update_worn_anus()
	update_worn_nipples()
	update_worn_mouth()
	update_worn_crotch()

/mob/living/carbon/human/update_worn_underwear()
	remove_overlay(UNDERWEAR_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[UNDERWEAR_INDEX]
		inv.update_icon()

	if(w_underwear)
		var/obj/item/clothing/underwear/briefs/undies = w_underwear

		update_hud_underwear(undies)

		if(underwear_hidden())
			return

		var/target_overlay = undies.icon_state
		var/mutable_appearance/underwear_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/digi
		var/woman
		var/female_sprite_flags = istype(undies) ? undies.female_sprite_flags : NONE
		var/mutant_styles = NONE

		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (undies.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = undies.worn_icon_digi || DIGITIGRADE_UNDERWEAR_FILE
			digi = TRUE
			if(undies.worn_icon_digi == undies.worn_icon)
				target_overlay += "_d"
		else if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_UNDERWEAR, w_underwear, src)

		if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			if(digi && !(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
				female_sprite_flags &= ~FEMALE_UNIFORM_FULL
				female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY

		if(digi)
			mutant_styles |= STYLE_DIGI

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
			undies.color = underwear_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_underwear_offset?.apply_offset(underwear_overlay)

		overlays_standing[UNDERWEAR_LAYER] = underwear_overlay
		apply_overlay(UNDERWEAR_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_shirt()
	remove_overlay(SHIRT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[SHIRT_INDEX]
		inv.update_icon()

	if(istype(w_shirt, /obj/item/clothing/underwear/shirt))
		var/obj/item/clothing/underwear/shirt/undershirt = w_shirt
		update_hud_shirt(undershirt)

		if(undershirt_hidden())
			return
		var/target_overlay = undershirt.icon_state
		var/mutable_appearance/shirt_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/digi
		var/woman
		var/female_sprite_flags = w_shirt.female_sprite_flags
		var/mutant_styles = NONE

		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (undershirt.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = undershirt.worn_icon_digi || DIGITIGRADE_SHIRT_FILE
			digi = TRUE
			if(undershirt.worn_icon_digi == undershirt.worn_icon)
				target_overlay += "_d"
		else if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_SHIRT, w_shirt, src)

		if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			if(digi && !(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
				female_sprite_flags &= ~FEMALE_UNIFORM_FULL
				female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY

		if(digi)
			mutant_styles |= STYLE_DIGI

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(undershirt)))
			icon_file = DEFAULT_SHIRT_FILE
			handled_by_bodyshape = FALSE

		shirt_overlay = undershirt.build_worn_icon(
			default_layer = SHIRT_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		if(undershirt.flags_1 & IS_PLAYER_COLORABLE_1)
			shirt_overlay.color = undershirt_color
			undershirt.color = undershirt_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_shirt_offset?.apply_offset(shirt_overlay)

		overlays_standing[SHIRT_LAYER] = shirt_overlay
		apply_overlay(SHIRT_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_bra()
	remove_overlay(BRA_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[BRA_INDEX]
		inv.update_icon()

	if(istype(w_bra, /obj/item/clothing/underwear/shirt/bra))
		var/obj/item/clothing/underwear/shirt/bra/bra = w_bra
		update_hud_bra(bra)

		if(bra_hidden())
			return

		var/target_overlay = bra.icon_state
		var/mutable_appearance/bra_overlay
		var/icon_file = 'modular_zzplurt/icons/mob/clothing/underwear.dmi'
		var/handled_by_bodyshape = TRUE
		var/digi
		var/woman
		var/female_sprite_flags = w_bra.female_sprite_flags
		var/mutant_styles = NONE

		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (bra.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			icon_file = bra.worn_icon_digi || DIGITIGRADE_SHIRT_FILE
			digi = TRUE
			if(bra.worn_icon_digi == bra.worn_icon)
				target_overlay += "_d"
		else if(bodyshape & BODYSHAPE_CUSTOM)
			icon_file = dna.species.generate_custom_worn_icon(OFFSET_SHIRT, w_bra, src)

		if(!dna.species.no_gender_shaping && dna.species.sexes && (bodyshape & BODYSHAPE_HUMANOID) && physique == FEMALE && !(female_sprite_flags & NO_FEMALE_UNIFORM))
			woman = TRUE
			if(digi && !(female_sprite_flags & FEMALE_UNIFORM_DIGI_FULL))
				female_sprite_flags &= ~FEMALE_UNIFORM_FULL
				female_sprite_flags |= FEMALE_UNIFORM_TOP_ONLY

		if(digi)
			mutant_styles |= STYLE_DIGI

		if(!icon_exists(icon_file, RESOLVE_ICON_STATE(bra)))
			icon_file = DEFAULT_SHIRT_FILE
			handled_by_bodyshape = FALSE

		bra_overlay = bra.build_worn_icon(
			default_layer = BRA_LAYER,
			default_icon_file = icon_file,
			isinhands = FALSE,
			female_uniform = woman ? female_sprite_flags : null,
			override_state = target_overlay,
			override_file = handled_by_bodyshape ? icon_file : null,
			mutant_styles = mutant_styles,
		)

		if(bra.flags_1 & IS_PLAYER_COLORABLE_1)
			bra_overlay.color = bra_color
			bra.color = bra_color

		var/obj/item/bodypart/chest/my_chest = get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_shirt_offset?.apply_offset(bra_overlay)

		overlays_standing[BRA_LAYER] = bra_overlay
		apply_overlay(BRA_LAYER)

	update_body_parts()

/mob/living/carbon/human/update_worn_wrists()
	remove_overlay(WRISTS_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[WRISTS_INDEX]
		inv.update_icon()

	if(wrists)
		var/obj/item/worn_item = wrists
		update_hud_wrists(worn_item)

		if(wrists_hidden())
			return

		var/icon_file = 'modular_zzplurt/icons/mob/clothing/wrists.dmi'

		// SKYRAT EDIT ADDITION
		var/mutant_override = FALSE
		if(bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_WRISTS, wrists, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		// SKYRAT EDIT END

		var/mutable_appearance/wrists_overlay = wrists.build_worn_icon(default_layer = WRISTS_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		overlays_standing[WRISTS_LAYER] = wrists_overlay
	apply_overlay(WRISTS_LAYER)

/mob/living/carbon/human/update_worn_ears_extra()
	remove_overlay(EARS_EXTRA_LAYER)

	var/obj/item/bodypart/head/my_head = get_bodypart(BODY_ZONE_HEAD)
	if(isnull(my_head)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[EARS_EXTRA_INDEX]
		inv.update_icon()

	if(ears_extra)
		var/obj/item/worn_item = ears_extra
		update_hud_ears_extra(worn_item)

		if(obscured_slots & HIDEEARS)
			return

		var/icon_file = 'icons/mob/clothing/ears.dmi'

		// SKYRAT EDIT ADDITION
		var/mutant_override = FALSE
		if(bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_EARS, ears_extra, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE
		// SKYRAT EDIT END

		var/mutable_appearance/ears_overlay = ears_extra.build_worn_icon(default_layer = EARS_EXTRA_LAYER, default_icon_file = icon_file, override_file = mutant_override ? icon_file : null) // SKYRAT EDIT CHANGE

		// SKYRAT EDIT ADDITION
		if(!mutant_override)
			my_head.worn_ears_offset?.apply_offset(ears_overlay)
		// SKYRAT EDIT END
		overlays_standing[EARS_EXTRA_LAYER] = ears_overlay
	apply_overlay(EARS_EXTRA_LAYER)

/mob/living/carbon/human/update_worn_socks()
	remove_overlay(SOCKS_LAYER)

	if(num_legs < 2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.extra_inventory[SOCKS_INDEX]
		inv.update_icon()

	if(istype(w_socks, /obj/item/clothing/underwear/socks))
		var/obj/item/clothing/underwear/socks/worn_item = w_socks
		update_hud_socks(worn_item)

		if(socks_hidden())
			return

		var/target_overlay = worn_item.icon_state
		var/icon_file = DEFAULT_SOCKS_FILE
		var/mutant_override = FALSE

		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (worn_item.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			var/obj/item/bodypart/leg = src.get_bodypart(BODY_ZONE_L_LEG)
			if(leg.limb_id == "digitigrade" || leg.bodyshape & BODYSHAPE_DIGITIGRADE)
				icon_file = worn_item.worn_icon_digi || DIGITIGRADE_SOCKS_FILE
				mutant_override = TRUE

				if(worn_item.worn_icon_digi == worn_item.worn_icon)
					target_overlay = "[worn_item.icon_state]_d"
					worn_item.worn_icon_state = target_overlay
		else if(!(bodyshape & BODYSHAPE_DIGITIGRADE) && worn_item.worn_icon_state && !isnull(worn_item.worn_icon_state))
			if(findtext(worn_item.worn_icon_state, "_d"))
				target_overlay = initial(worn_item.icon_state)
				worn_item.worn_icon_state = initial(worn_item.icon_state)

		if(!mutant_override && bodyshape & BODYSHAPE_CUSTOM)
			var/species_icon_file = dna.species.generate_custom_worn_icon(OFFSET_SOCKS, w_socks, src)
			if(species_icon_file)
				icon_file = species_icon_file
				mutant_override = TRUE

		if(bodyshape & BODYSHAPE_HIDE_SHOES)
			return

		var/mutable_appearance/socks_overlay = w_socks.build_worn_icon(
			default_layer = SOCKS_LAYER,
			default_icon_file = icon_file,
			override_file = mutant_override ? icon_file : null
		)

		if(!socks_overlay)
			return

		var/feature_y_offset = 0
		for (var/body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			var/obj/item/bodypart/leg/my_leg = get_bodypart(body_zone)
			if(isnull(my_leg))
				continue
			var/list/foot_offset = my_leg.worn_foot_offset?.get_offset()
			if (foot_offset && foot_offset["y"] > feature_y_offset)
				feature_y_offset = foot_offset["y"]

		if(worn_item.flags_1 & IS_PLAYER_COLORABLE_1)
			socks_overlay.color = socks_color
			worn_item.color = socks_color

		socks_overlay.pixel_y += feature_y_offset
		overlays_standing[SOCKS_LAYER] = socks_overlay

	apply_overlay(SOCKS_LAYER)

	update_body_parts()

// Function for updating back sprites
/mob/living/carbon/human/update_worn_back()
	. = ..()

	// Check for hidden backpack trait
	if(HAS_TRAIT(src, TRAIT_HIDE_BACKPACK))
		// Define back overlays
		var/mutable_appearance/back_overlay = overlays_standing[BACK_LAYER]

		// Check for existing overlay
		if(back_overlay)
			// Remove overlays
			remove_overlay(BACK_LAYER)

/mob/living/carbon/human/proc/update_hud_shirt(obj/item/worn_item)
	worn_item.screen_loc = ui_shirt
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_bra(obj/item/worn_item)
	worn_item.screen_loc = ui_bra
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_underwear(obj/item/worn_item)

	worn_item.screen_loc = ui_boxers

	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_wrists(obj/item/worn_item)
	worn_item.screen_loc = ui_wrists
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_ears_extra(obj/item/worn_item)
	worn_item.screen_loc = ui_ears_extra
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_socks(obj/item/worn_item)
	worn_item.screen_loc = ui_socks
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_vagina(obj/item/worn_item)
	worn_item.screen_loc = ui_vagina
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

// Updating anus hud slot
/mob/living/carbon/human/proc/update_hud_anus(obj/item/worn_item)
	worn_item.screen_loc = ui_anus
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

// Updating nipples hud slot
/mob/living/carbon/human/proc/update_hud_nipples(obj/item/worn_item)
	worn_item.screen_loc = ui_nipples
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

// Updating penis hud slot
/mob/living/carbon/human/proc/update_hud_penis(obj/item/worn_item)
	worn_item.screen_loc = ui_penis
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_mouth(obj/item/worn_item)
	worn_item.screen_loc = ui_mouth
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/mob/living/carbon/human/proc/update_hud_crotch(obj/item/worn_item)
	worn_item.screen_loc = ui_crotch
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown && hud_used.extra_shown))
		client.screen += worn_item
	update_observer_view(worn_item,TRUE)

/**
 * Helper functions to synchronize and update underwear when body types change
 */

/**
 * Updates all underwear items after leg/body type changes
 * This ensures that preview and in-game rendering remain consistent
 * Call this whenever digitigrade legs or other body types that affect clothing are changed
 */
/mob/living/carbon/human/proc/update_underwear_on_bodytype_change()
	// Force update all underwear items
	update_worn_underwear()
	update_worn_socks()
	update_worn_shirt()
	update_worn_bra()

	// Since we're changing body type, make sure colors are properly applied
	if(w_underwear && (w_underwear.flags_1 & IS_PLAYER_COLORABLE_1))
		w_underwear.color = underwear_color

	if(w_socks && (w_socks.flags_1 & IS_PLAYER_COLORABLE_1))
		w_socks.color = socks_color
		// Force update socks icon for digitigrade legs
		if((bodyshape & BODYSHAPE_DIGITIGRADE) && (w_socks.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
			// Update the icon state for digitigrade if needed
			if(w_socks.worn_icon_digi == w_socks.worn_icon)
				var/digit_state = "[w_socks.icon_state]_d"
				// This ensures the correct icon state is used for the current leg type
				w_socks.worn_icon_state = digit_state
		else if(!(bodyshape & BODYSHAPE_DIGITIGRADE) && w_socks.worn_icon_state)
			// Revert back to normal state when changing from digi to normal
			w_socks.worn_icon_state = initial(w_socks.worn_icon_state)

	if(w_shirt && (w_shirt.flags_1 & IS_PLAYER_COLORABLE_1))
		w_shirt.color = undershirt_color

	if(w_bra && (w_bra.flags_1 & IS_PLAYER_COLORABLE_1))
		w_bra.color = bra_color

	// Update the body parts to ensure everything renders correctly
	update_body_parts()

#undef RESOLVE_ICON_STATE

#undef UNDERWEAR_INDEX
#undef SOCKS_INDEX
#undef SHIRT_INDEX
#undef BRA_INDEX
#undef EARS_EXTRA_INDEX
#undef WRISTS_INDEX

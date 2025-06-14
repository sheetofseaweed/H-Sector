/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen


/mob/living/carbon/human/Destroy()
	QDEL_NULL(tgui)
	. = ..()

/mob/living/silicon/Destroy()
	QDEL_NULL(examine_panel)
	. = ..()

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	examine_panel_screen.hide_from(user)

/datum/examine_panel/Destroy(force)
	holder = null
	QDEL_NULL(examine_panel_screen)
	. = ..()

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!holder) //Splurt Edit Starts Here
		return
	if(!user.client)
		return //Splurt Edit Ends Here
	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExaminePanel")
		ui.open()
		examine_panel_screen.display_to(user, ui.window)


/datum/examine_panel/ui_data(mob/user)
	. = ..()
	var/list/data = .

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavor_text
	var/flavor_text_nsfw
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/name = ""
	var/obscurity_examine_pref = preferences?.read_preference(/datum/preference/toggle/obscurity_examine)
	var/ooc_notes = ""
	var/headshot = ""
	var/headshot_nsfw = ""
	var/art_ref = ""
	var/art_ref_nsfw = preferences?.read_preference(/datum/preference/toggle/art_ref_nsfw)
	var/character_ad = ""

	var/emote_length = preferences?.read_preference(/datum/preference/choiced/emote_length)
	var/approach = preferences?.read_preference(/datum/preference/choiced/approach_pref)
	var/furries = preferences?.read_preference(/datum/preference/choiced/directory_character_prefs/furry_pref)
	var/scalies = preferences?.read_preference(/datum/preference/choiced/directory_character_prefs/scalie_pref)
	var/others = preferences?.read_preference(/datum/preference/choiced/directory_character_prefs/other_pref)
	var/demihumans = preferences?.read_preference(/datum/preference/choiced/directory_character_prefs/demihuman_pref)
	var/humans = preferences?.read_preference(/datum/preference/choiced/directory_character_prefs/human_pref)
	var/show_nsfw_flavor_text = preferences?.read_preference(/datum/preference/choiced/show_nsfw_flavor_text)

	//  Handle OOC notes first
	if(preferences)
		//if(preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		var/e_prefs = preferences.read_preference(/datum/preference/choiced/erp_status)
		var/e_prefs_hypno = preferences.read_preference(/datum/preference/toggle/erp/hypnosis) ? "Yes" : "No"// HSECTOR EDIT
		var/e_prefs_v = preferences.read_preference(/datum/preference/choiced/erp_status_v)
		var/e_prefs_nc = preferences.read_preference(/datum/preference/choiced/erp_status_nc)
		// HSECTOR EDIT ADDITION
		//var/e_prefs_mechanical = preferences.read_preference(/datum/preference/choiced/erp_status_mechanics)
		var/e_prefs_event = preferences.read_preference(/datum/preference/toggle/erp/erp_event_participation) ? "Yes" : "No"
		// HSECTOR EDIT END
		// SPLURT EDIT ADDITION - Interaction preferences
		var/e_prefs_extm = preferences.read_preference(/datum/preference/choiced/erp_status_extm)
		//var/e_prefs_extmharm = preferences.read_preference(/datum/preference/choiced/erp_status_extmharm)
		//var/e_prefs_unholy = preferences.read_preference(/datum/preference/choiced/erp_status_unholy)
		// SPLURT EDIT END
		ooc_notes += "ERP: [e_prefs]\n"
		ooc_notes += "Hypnosis: [e_prefs_hypno]\n"
		ooc_notes += "Vore: [e_prefs_v]\n"
		ooc_notes += "Non-Con: [e_prefs_nc]\n"
		// SPLURT EDIT ADDITION - Interaction preferences
		ooc_notes += "Extreme ERP verbs: [e_prefs_extm]\n"
		//ooc_notes += "Harmful ERP verbs: [e_prefs_extmharm]\n"
		//ooc_notes += "Unholy ERP verbs: [e_prefs_unholy]\n"
		// SPLURT EDIT END
		// HSECTOR EDIT ADDITION
		//ooc_notes += "ERP Mechanics: [e_prefs_mechanical]\n"
		ooc_notes += "ERP Event Participation: [e_prefs_event]\n"
		// HSECTOR EDIT END
		ooc_notes += "\n"

		character_ad += "Preferred Emote Length: [emote_length]\n"
		character_ad += "How to Approach: [approach]\n"
		character_ad += "Furries: [furries] | Scalies: [scalies] | Other: [others]\n"
		character_ad += "Demis: [demihumans] | Humans: [humans]\n"
		character_ad += "\n"
		character_ad += preferences.read_preference(/datum/preference/text/character_ad)

		// Now we handle silicon and/or human, order doesn't really matter
		// If other variants of mob/living need to be handled at some point, put them here
		if(issilicon(holder))
			flavor_text = preferences.read_preference(/datum/preference/text/silicon_flavor_text)
			// Silicon prefs and headshot
			custom_species = preferences.read_preference(/datum/preference/text/custom_species/silicon)
			custom_species_lore = preferences.read_preference(/datum/preference/text/custom_species_lore/silicon)
			ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes/silicon)
			headshot += preferences.read_preference(/datum/preference/text/headshot/silicon)
			name = holder.name
			if(show_nsfw_flavor_text != "Never")
				flavor_text_nsfw = preferences.read_preference(/datum/preference/text/flavor_text_nsfw/silicon)
				headshot_nsfw = preferences.read_preference(/datum/preference/text/headshot/silicon/nsfw)

		//Round Removal opt in stuff
		if(CONFIG_GET(flag/use_rr_opt_in_preferences))
			var/rr_prefs = preferences.read_preference(/datum/preference/toggle/be_round_removed)
			ooc_notes += "\n"
			ooc_notes += "Round Removal Opt-In Status: [rr_prefs ? "Yes" : "No"]\n"
			ooc_notes += "\n"

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) && \
		obscurity_examine_pref || \
		(holder_human.head && (holder_human.head.flags_inv & HIDEFACE) && obscurity_examine_pref)

		//Check if the mob is obscured, then continue to headshot and species lore
		ooc_notes += holder_human.dna?.features["ooc_notes"]
		if((obscured || !holder_human.dna) && !isobserver(user))
			custom_species = "Obscured"
			custom_species_lore = "Obscured"
			flavor_text = "Obscured"
			name = "Unknown"
		else
			headshot = holder_human.dna.features["headshot"]
			flavor_text = holder_human.dna.features["flavor_text"]
			art_ref = holder_human.dna.features["art_ref"]
			name = holder.name
			if(show_nsfw_flavor_text == "Always On" || (show_nsfw_flavor_text == "Nude Only" && !(holder_human.w_uniform)))
				flavor_text_nsfw = holder_human.dna.features["flavor_text_nsfw"]
				headshot_nsfw = holder_human.dna.features["headshot_nsfw"]

		//Custom species handling. Reports the normal custom species if there is not one set.
			if(holder_human.dna.species.lore_protected || holder_human.dna.features["custom_species"] == "")
				custom_species = holder_human.dna.species.name
			else
				custom_species = holder_human.dna.features["custom_species"]
		//Custom species lore handling. Reports the species lore with summary if there is not one set. Does this separately so you can name your subrace without the lore changing.
			if(holder_human.dna.species.lore_protected || !holder_human.dna.features["custom_species_lore"] || holder_human.dna.features["custom_species_lore"] == "")
				var/list/desc = holder_human.dna.species.get_species_description()
				var/list/lore = holder_human.dna.species.get_species_lore()
				custom_species_lore += desc.Join("\n\n")
				custom_species_lore += "\n\n\n"
				custom_species_lore += lore.Join("\n\n")
			else
				custom_species_lore = holder_human.dna.features["custom_species_lore"]

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["assigned_map"] = examine_panel_screen.assigned_map
	data["flavor_text"] = flavor_text
	data["flavor_text_nsfw"] = flavor_text_nsfw
	data["ooc_notes"] = ooc_notes
	data["custom_species"] = custom_species
	data["custom_species_lore"] = custom_species_lore
	data["headshot"] = headshot
	data["headshot_nsfw"] = headshot_nsfw
	data["art_ref"] = art_ref
	data["art_ref_nsfw"] = art_ref_nsfw
	data["character_ad"] = character_ad
	return data

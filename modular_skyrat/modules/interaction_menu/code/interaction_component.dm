
/datum/component/interactable
	/// A hard reference to the parent
	var/mob/living/self = null 	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	/// A list of interactions that the user can engage in.
	var/list/datum/interaction/interactions
	var/interact_last = 0
	var/interact_next = 0
	///Holds a reference to a relayed body if one exists
	var/obj/body_relay = null

/datum/component/interactable/Initialize(...)
	if(QDELETED(parent))
		qdel(src)
		return

	if(!isliving(parent)) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
		return COMPONENT_INCOMPATIBLE

	self = parent

	build_interactions_list()

/datum/component/interactable/proc/build_interactions_list()
	interactions = list()
	//SPLURT EDIT CHANGE BEGIN - INTERACTIONS SUBSYSTEM - Changed to use SSinteractions
	if(!SSinteractions)
		return // Can't continue, no subsystem
	for(var/iterating_interaction_id in SSinteractions.interactions)
		var/datum/interaction/interaction = SSinteractions.interactions[iterating_interaction_id]
	//SPLURT EDIT CHANGE END
		if(interaction.lewd)
			#ifdef TESTING
			interactions.Add(interaction)
			continue
			#endif
			//HSECTOR EDIT - was: if(!self.client?.prefs?.read_preference(/datum/preference/toggle/erp) && !(!ishuman(self) && !self.client && !SSinteractions.is_blacklisted(self))) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
			if(!ishuman(self) && SSinteractions.is_blacklisted(self)) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
				continue
			/*
			SPLURT EDIT REMOVAL - Interactions
			if(interaction.sexuality != "" && interaction.sexuality != self.client?.prefs?.read_preference(/datum/preference/choiced/erp_sexuality))
				continue
			*/
		interactions.Add(interaction)

/datum/component/interactable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(open_interaction_menu))

/datum/component/interactable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)

/datum/component/interactable/Destroy(force, silent)
	self = null
	interactions = null
	return ..()

/datum/component/interactable/proc/open_interaction_menu(datum/source, mob/user)
	if(!isliving(user)) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
		return
	build_interactions_list()
	ui_interact(user)

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/living/target) 	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	if(!interaction.allow_act(target, self))
		return FALSE
	//HSECTOR EDIT - was: if(interaction.lewd && !target.client?.prefs?.read_preference(/datum/preference/toggle/erp) && !(!ishuman(target) && !target.client && !SSinteractions.is_blacklisted(target)))// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	if(interaction.lewd && (!ishuman(target) && !target.client && SSinteractions.is_blacklisted(target))) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
		return FALSE
	if(!interaction.distance_allowed && !target.Adjacent(self))
		if(!body_relay || !target.Adjacent(body_relay))
			return FALSE
	if(interaction.category == INTERACTION_CAT_HIDE)
		return FALSE
	if(self == target && interaction.usage == INTERACTION_OTHER)
		return FALSE
	return TRUE

/// UI Control
/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		//SPLURT EDIT CHANGE BEGIN - UI INTERFACE - New interaction menu interface
		//ui = new(user, src, "Interactions") - SPLURT EDIT - ORIGINAL
		ui = new(user, src, "MobInteraction")
		//SPLURT EDIT CHANGE END
		ui.open()

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	if(!isliving(user)) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
		return UI_CLOSE

	return UI_INTERACTIVE // This UI is always interactive as we handle distance flags via can_interact

/datum/component/interactable/ui_data(mob/living/user)  	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	var/list/data = list()
	var/list/descriptions = list()
	var/list/categories = list()
	var/list/display_categories = list()
	var/list/colors = list()
	// SPLURT EDIT START - INTERACTIONS
	var/list/additional_details = list()

	//var/mob/living/carbon/human/human_user = user
	var/mob/living/carbon/human/human_self = self

	var/datum/component/interactable/user_interaction_component = user.GetComponent(/datum/component/interactable)
	// SPLURT EDIT END

	for(var/datum/interaction/interaction in interactions)
		if(!can_interact(interaction, user))
			continue
		if(!categories[interaction.category])
			categories[interaction.category] = list(interaction.name)
		else
			categories[interaction.category] += interaction.name
			var/list/sorted_category = sort_list(categories[interaction.category])
			categories[interaction.category] = sorted_category
		descriptions[interaction.name] = interaction.description
		colors[interaction.name] = interaction.color
		// SPLURT EDIT START - INTERACTIONS
		if(length(interaction.additional_details))
			additional_details[interaction.name] = interaction.additional_details
		// SPLURT EDIT END

	data["descriptions"] = descriptions
	data["colors"] = colors
	data["additional_details"] = additional_details // SPLURT EDIT ADDITION - INTERACTIONS
	for(var/category in categories)
		display_categories += category
	data["categories"] = sort_list(display_categories)
	data["ref_user"] = REF(user)
	data["ref_self"] = REF(self)
	data["self"] = self.name
	data["block_interact"] = user_interaction_component?.interact_next >= world.time // SPLURT EDIT - INTERACTIONS - Original: interact_next >= world.time
	if(body_relay)
		if(!can_see(user, self))
			data["self"] = body_relay.name
	data["interactions"] = categories

	var/list/parts = list()
	if(ishuman(user) && ishuman(self) && can_lewd_strip(user, self)) // SPLURT EDIT - INTERACTIONS - Original: if(ishuman(user) && can_lewd_strip(user, self))
		if(self.has_vagina())
			parts += list(generate_strip_entry(ORGAN_SLOT_VAGINA, self, user, human_self.vagina)) // SPLURT EDIT - INTERACTIONS - Original: generate_strip_entry(ORGAN_SLOT_VAGINA, self, user, self.vagina)
		if(self.has_penis())
			parts += list(generate_strip_entry(ORGAN_SLOT_PENIS, self, user, human_self.penis)) // SPLURT EDIT - INTERACTIONS - Original: generate_strip_entry(ORGAN_SLOT_PENIS, self, user, self.penis)
		if(self.has_anus())
			parts += list(generate_strip_entry(ORGAN_SLOT_ANUS, self, user, human_self.anus)) // SPLURT EDIT - INTERACTIONS - Original: generate_strip_entry(ORGAN_SLOT_ANUS, self, user, self.anus)
		parts += list(generate_strip_entry(ORGAN_SLOT_NIPPLES, self, user, human_self.nipples)) // SPLURT EDIT - INTERACTIONS - Original: generate_strip_entry(ORGAN_SLOT_NIPPLES, self, user, self.nipples)

	data["lewd_slots"] = parts

	return data

/**
 *  Takes the organ slot name, along with a target and source, along with the item on the target that the source can potentially interact with.
 *  If the source can't interact with said slot, or there is no item in the first place, it'll set the icon to null to indicate that TGUI should put a placeholder sprite.
 *
 * Arguments:
 * * name - The name of slot to check and return inside the generated list.
 * * target - The mob that's being interacted with.
 * * source - The mob that's interacting.
 * * item - The item that's currently inside said slot. Can be null.
 */
/datum/component/interactable/proc/generate_strip_entry(name, mob/living/carbon/human/target, mob/living/carbon/human/source, obj/item/clothing/sextoy/item)
	return list(
		"name" = name,
		"img" = (item && can_lewd_strip(source, target, name)) ? icon2base64(icon(item.icon, item.icon_state, SOUTH, 1)) : null,
		)

/datum/component/interactable/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	// SPLURT EDIT START - INTERACTIONS - Fully reworked by us
	if(!isliving(usr)) 		// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
		return

	var/mob/living/user = usr 	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	var/datum/preferences/prefs = user.client?.prefs

	switch(action)
		if("interact")
			var/interaction_id = params["interaction"]
			var/mob/living/source = locate(params["userref"]) 	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
			var/mob/living/target = locate(params["selfref"]) 	// SPLURT EDIT - INTERACTIONS - All mobs should be interactable
			if(!interaction_id || !source || !target)
				return FALSE

			// Find the interaction by name
			var/datum/interaction/selected_interaction
			for(var/datum/interaction/interaction in interactions)
				if(interaction.name == interaction_id)
					selected_interaction = interaction
					break

			if(!selected_interaction)
				return FALSE

			if(!can_interact(selected_interaction, source))
				return FALSE

			if(interact_next >= world.time)
				return FALSE

			if(body_relay && !can_see(user, self))
				selected_interaction.act(source, target, body_relay)
			else
				selected_interaction.act(source, target)
			var/datum/component/interactable/interaction_component = source.GetComponent(/datum/component/interactable)
			interaction_component.interact_last = world.time
			interaction_component.interact_next = interaction_component.interact_last + INTERACTION_COOLDOWN
			return TRUE

		if("favorite")
			if(!prefs)
				return FALSE

			var/interaction_id = params["interaction"]
			if(!interaction_id)
				return FALSE

			var/list/favorite_interactions = prefs.read_preference(/datum/preference/blob/favorite_interactions) || list()
			if(interaction_id in favorite_interactions)
				favorite_interactions -= interaction_id
			else
				favorite_interactions += interaction_id
			prefs.update_preference(GLOB.preference_entries[/datum/preference/blob/favorite_interactions], favorite_interactions)
			modified_preferences |= "favorite_interactions"
			update_cached_preferences(user, list("favorite_interactions"))
			return TRUE

		if("pref")
			if(!prefs)
				return
			var/pref_path = LAZYACCESS(preference_paths, params["pref"])
			if(!pref_path)
				return

			if(params["amount"])
				prefs.update_preference(GLOB.preference_entries[pref_path], params["amount"])
			else
				prefs.update_preference(GLOB.preference_entries[pref_path], !prefs.read_preference(pref_path))
			modified_preferences |= pref_path
			update_cached_preferences(user, list(params["pref"]))
			return TRUE

		if("char_pref")
			if(!prefs)
				return
			var/pref_path = LAZYACCESS(character_preference_paths, params["char_pref"])
			if(!pref_path)
				return

			var/value = params["value"]
			var/datum/preference/choiced/pref_type = GLOB.preference_entries[pref_path]
			// Validate that the value is one of the allowed options
			var/list/valid_values = pref_type.get_choices()
			if(!(value in valid_values))
				return

			prefs.update_preference(pref_type, value)
			modified_preferences |= pref_path
			update_cached_preferences(user, list(params["char_pref"]))
			return TRUE

		if("item_slot")
			var/item_index = params["item_slot"]
			var/mob/living/carbon/human/source = locate(params["userref"])
			var/mob/living/carbon/human/target = locate(params["selfref"])
			if(!source || !istype(target))
				return FALSE

			var/obj/item/clothing/sextoy/new_item = source.get_active_held_item()
			var/obj/item/clothing/sextoy/existing_item = target.vars[item_index]

			if(!existing_item && !new_item)
				source.show_message(span_warning("No item to insert or remove!"))
				return

			if(!existing_item && !istype(new_item))
				source.show_message(span_warning("The item you're holding is not a toy!"))
				return

			if(can_lewd_strip(source, target, item_index) && is_toy_compatible(new_item, item_index))
				var/internal = (item_index in list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_ANUS))
				var/insert_or_attach = internal ? "insert" : "attach"
				var/into_or_onto = internal ? "into" : "onto"

				if(existing_item)
					source.visible_message(span_purple("[source.name] starts trying to remove something from [target.name]'s [item_index]."), span_purple("You start to remove [existing_item.name] from [target.name]'s [item_index]."), span_purple("You hear someone trying to remove something from someone nearby."), vision_distance = 1, ignored_mobs = list(target))
				else if (new_item)
					source.visible_message(span_purple("[source.name] starts trying to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You start to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You hear someone trying to [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1, ignored_mobs = list(target))
				if (source != target)
					target.show_message(span_warning("[source.name] is trying to [existing_item ? "remove the [existing_item.name] [internal ? "in" : "on"]" : new_item ? "is trying to [insert_or_attach] the [new_item.name] [into_or_onto]" : span_alert("What the fuck, impossible condition? interaction_component.dm!")] your [item_index]!"))
				if(do_after(
					source,
					5 SECONDS,
					target,
					interaction_key = "interaction_[item_index]"
					) && can_lewd_strip(source, target, item_index))

					if(existing_item)
						source.visible_message(span_purple("[source.name] removes [existing_item.name] from [target.name]'s [item_index]."), span_purple("You remove [existing_item.name] from [target.name]'s [item_index]."), span_purple("You hear someone remove something from someone nearby."), vision_distance = 1)
						target.dropItemToGround(existing_item, force = TRUE) // Force is true, cause nodrop shouldn't affect lewd items.
						source.put_in_hands(existing_item, forced = TRUE) // SPLURT EDIT - puts it in the source's hands, it still needs to be dropped for specific sextoy behavior
						target.vars[item_index] = null
					else if (new_item)
						source.visible_message(span_purple("[source.name] [internal ? "inserts" : "attaches"] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You hear someone [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1)
						target.vars[item_index] = new_item
						new_item.forceMove(target)
						new_item.on_equipped(target, item_index)
				if(ishuman(target)) // SPLURT EDIT - INTERACTIONS
					target.update_inv_lewd()

			else
				source.show_message(span_warning("Failed to adjust [target.name]'s toys!"))

			return TRUE

		if("toggle_genital_visibility")
			if(!ishuman(user))
				return FALSE
			var/obj/item/organ/genital/genital = user.get_organ_slot(params["genital"])
			if(!genital || !istype(genital))
				return FALSE

			var/visibility = params["visibility"]
			if(!(visibility in list(GENITAL_NEVER_SHOW, GENITAL_HIDDEN_BY_CLOTHES, GENITAL_ALWAYS_SHOW)))
				return FALSE

			genital.visibility_preference = visibility
			user.update_body()
			return TRUE

		if("toggle_genital_arousal")
			if(!ishuman(user))
				return FALSE
			var/obj/item/organ/genital/genital = user.get_organ_slot(params["genital"])
			if(!genital || !istype(genital) || genital.aroused == AROUSAL_CANT)
				return FALSE

			var/arousal = params["arousal"]
			if(!(arousal in list(AROUSAL_NONE, AROUSAL_PARTIAL, AROUSAL_FULL)))
				return FALSE

			genital.aroused = arousal
			genital.update_sprite_suffix()
			user.update_body()
			return TRUE

		if("toggle_genital_accessibility")
			if(!ishuman(user))
				return FALSE
			var/obj/item/organ/genital/genital = user.get_organ_slot(params["genital"])
			if(!genital || !istype(genital))
				return FALSE

			genital.always_accessible = !genital.always_accessible
			return TRUE

		if("toggle_genital_active")
			if(ishuman(user))
				return FALSE
			var/genital_name = params["genital"]
			if(!genital_name)
				return FALSE
			user.simulated_genitals[genital_name] = !user.simulated_genitals[genital_name]
			return TRUE

		if("auto_interaction")
			var/datum/interaction/interaction = SSinteractions.interactions[splittext(params["interaction_text"], "_target_")[1]]
			var/datum/component/interactable/user_interaction_component = user.GetComponent(/datum/component/interactable)
			if(!interaction)
				return FALSE
			if(params["action"] == "stop")
				user_interaction_component.auto_interaction_info -= params["interaction_text"]
			else
				var/already_processing = LAZYLEN(user_interaction_component.auto_interaction_info)
				user_interaction_component.auto_interaction_info[params["interaction_text"]] = list(
					"speed" = clamp(round(params["speed"], 0.5), (INTERACTION_SPEED_MIN * (1 / (1 SECONDS))), (INTERACTION_SPEED_MAX * (1 / (1 SECONDS)))),
					"target" = params["selfref"],
					"target_name" = self.name,
				)
				if(!already_processing)
					START_PROCESSING(SSinteractions, user_interaction_component)
			return TRUE
	// SPLURT EDIT END

	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")

/// Checks if the target has ERP toys enabled, and can be logially reached by the user.
/datum/component/interactable/proc/can_lewd_strip(mob/living/carbon/human/source, mob/living/carbon/human/target, slot_index)
	if(!(source.loc == target.loc || source.Adjacent(target)))
		return FALSE
	if(ishuman(source) && !source.has_arms()) // SPLURT EDIT - INTERACTIONS
		return FALSE
	if(!slot_index) // This condition is for the UI to decide if the button is shown at all. Slot index should never be null otherwise.
		return TRUE

	switch(slot_index)
		if(ORGAN_SLOT_NIPPLES)
			var/chest_exposed = target.has_breasts(required_state = REQUIRE_GENITAL_EXPOSED)
			if(!chest_exposed)
				chest_exposed = target.is_topless() // for when we don't have breasts

			return chest_exposed

		if(ORGAN_SLOT_PENIS)
			return target.has_penis(required_state = REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_VAGINA)
			return target.has_vagina(required_state = REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_ANUS)
			return target.has_anus(required_state = REQUIRE_GENITAL_EXPOSED)

/// Decides if a player should be able to insert or remove an item from a provided lewd slot_index.
/datum/component/interactable/proc/is_toy_compatible(obj/item/clothing/sextoy/item, slot_index)
	if(!item) // Used for UI code, should never be actually null during actual logic code.
		return TRUE

	switch(slot_index)
		if(ORGAN_SLOT_VAGINA)
			return item.lewd_slot_flags & ORGAN_SLOT_VAGINA
		if(ORGAN_SLOT_PENIS)
			return item.lewd_slot_flags & ORGAN_SLOT_PENIS
		if(ORGAN_SLOT_ANUS)
			return item.lewd_slot_flags & ORGAN_SLOT_ANUS
		if(ORGAN_SLOT_NIPPLES)
			return item.lewd_slot_flags & ORGAN_SLOT_NIPPLES
		else
			return FALSE

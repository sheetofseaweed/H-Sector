/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, ignore_equipped, indirect_action)
	//if we're not trying to equip it to an extra slot
	if(!(slot & ITEM_SLOT_EXTRA))
		return ..()

	if((no_equip_flags & slot) && (no_equip_flags & ITEM_SLOT_EXTRA) && !(I.is_mod_shell_component() && (modsuit_slot_exceptions & slot))) // SKYRAT EDIT ADDITION - ORIGINAL: if(no_equip_flags & slot)
		if(!I.species_exception || !is_type_in_list(src, I.species_exception))
			return FALSE

	// if there's an item in the slot we want, fail
	if(!ignore_equipped)
		if(H.get_item_by_slot(slot))
			return FALSE

	// this check prevents us from equipping something to a slot it doesn't support, WITH the exceptions of storage slots (pockets, suit storage, and backpacks)
	// we don't require having those slots defined in the item's slot_flags, so we'll rely on their own checks further down
	if(!((I.extra_slot_flags & (slot & ~ITEM_SLOT_EXTRA)) || (I.lewd_slot_flags & (slot & ~ITEM_SLOT_EXTRA))))
		return FALSE

	switch(slot)
		if(ITEM_SLOT_WRISTS)
			if(H.num_hands < 2)
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_UNDERWEAR)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_SOCKS)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_SHIRT)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_BRA)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		//hsector
		if(ITEM_SLOT_PENIS)
			var/obj/item/organ/genital/G = H.get_organ_slot(ORGAN_SLOT_PENIS)
			if(G)
				return equip_delay_self_check(I, H, bypass_equip_delay_self)
			if(!disable_warning)
				to_chat(H, span_warning("You need a penis to use that!"))
			return FALSE
		if(ITEM_SLOT_VAGINA)
			var/obj/item/organ/genital/G = H.get_organ_slot(ORGAN_SLOT_VAGINA)
			if(G)
				return equip_delay_self_check(I, H, bypass_equip_delay_self)
			if(!disable_warning)
				to_chat(H, span_warning("You need a vagina to use that!"))
			return FALSE
		if(ITEM_SLOT_ANUS)
			var/obj/item/organ/genital/G = H.get_organ_slot(ORGAN_SLOT_ANUS)
			if(G)
				return equip_delay_self_check(I, H, bypass_equip_delay_self)
			if(!disable_warning)
				to_chat(H, span_warning("You need an anus to use that!"))
			return FALSE
		if(ITEM_SLOT_NIPPLES)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_MOUTH)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_CROTCH)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
	return FALSE //Unsupported slot

//Species types
/mob/living/carbon/human/species/arachnid
	race = /datum/species/arachnid

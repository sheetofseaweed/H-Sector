/obj/item
	// Extra inventory
	var/hide_underwear_examine = FALSE
	/// Underwear and extra slots
	var/extra_slot_flags = NONE

/obj/item/update_slot_icon()
	. = ..()
	if(!ismob(loc))
		return
	var/mob/owner = loc
	var/flags = extra_slot_flags
	// Extra inventory
	if((flags & ITEM_SLOT_UNDERWEAR) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_underwear()
	if((flags & ITEM_SLOT_SOCKS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_socks()
	if((flags & ITEM_SLOT_SHIRT) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_shirt()
	if((flags & ITEM_SLOT_BRA) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_bra()
	if((flags & ITEM_SLOT_EARS_RIGHT))
		owner.update_worn_ears_extra()
	if((flags & ITEM_SLOT_WRISTS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_wrists()
	//hsector
	if((flags & ITEM_SLOT_PENIS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_penis()
	if((flags & ITEM_SLOT_VAGINA) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_vagina()
	if((flags & ITEM_SLOT_ANUS) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_anus()
	if((flags & ITEM_SLOT_NIPPLES) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_nipples()
	if((flags & ITEM_SLOT_MOUTH) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_mouth()
	if((flags & ITEM_SLOT_CROTCH) && (flags & ITEM_SLOT_EXTRA))
		owner.update_worn_crotch()

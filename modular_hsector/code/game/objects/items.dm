/obj/item
	/// Lewd slots
	var/lewd_slot_flags = NONE

/obj/item/update_slot_icon()
	. = ..()
	if(!ismob(loc))
		return
	var/mob/owner = loc
	var/flags = lewd_slot_flags
	//lewd slots
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

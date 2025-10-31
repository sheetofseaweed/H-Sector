/mob/update_clothing(slot_flags)
	. = ..()
	if((slot_flags & ITEM_SLOT_WRISTS) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_wrists()
	if((slot_flags & ITEM_SLOT_SOCKS) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_socks()
	if((slot_flags & ITEM_SLOT_UNDERWEAR) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_underwear()
	if((slot_flags & ITEM_SLOT_SHIRT) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_shirt()
	if((slot_flags & ITEM_SLOT_BRA) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_bra()
		//
	if((slot_flags & ITEM_SLOT_PENIS) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_penis()
	if((slot_flags & ITEM_SLOT_VAGINA) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_vagina()
	if((slot_flags & ITEM_SLOT_ANUS) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_anus()
	if((slot_flags & ITEM_SLOT_NIPPLES) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_nipples()
	if((slot_flags & ITEM_SLOT_MOUTH) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_mouth()
	if((slot_flags & ITEM_SLOT_CROTCH) && (slot_flags & ITEM_SLOT_EXTRA))
		update_worn_crotch()
		//
	if((slot_flags & ITEM_SLOT_EARS_RIGHT))
		update_worn_ears_extra()

///Updates the underwear overlay & HUD element.
/mob/proc/update_worn_underwear()
	return

///Updates the shirt overlay & HUD element.
/mob/proc/update_worn_shirt()
	return

///Updates the bra overlay & HUD element.
/mob/proc/update_worn_bra()
	return

///Updates the socks overlay & HUD element.
/mob/proc/update_worn_socks()
	return

///Updates the wrists overlay & HUD element.
/mob/proc/update_worn_wrists()
	return

///Updates the headset on the other side overlay & HUD element.
/mob/proc/update_worn_ears_extra()
	return

/mob/proc/update_worn_penis(update_obscured = FALSE)
	return

/mob/proc/update_worn_vagina(update_obscured = FALSE)
	return

/mob/proc/update_worn_anus(update_obscured = FALSE)
	return

/mob/proc/update_worn_nipples(update_obscured = FALSE)
	return

/mob/proc/update_worn_mouth(update_obscured = FALSE)
	return

/mob/proc/update_worn_crotch(update_obscured = FALSE)
	return

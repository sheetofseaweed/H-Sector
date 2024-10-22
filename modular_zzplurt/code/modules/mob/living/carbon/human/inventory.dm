/mob/living/carbon/human/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_EARS_RIGHT)
			return ears_extra
		if(ITEM_SLOT_WRISTS)
			return wrists
		if(ITEM_SLOT_UNDERWEAR)
			return w_underwear
		if(ITEM_SLOT_SOCKS)
			return w_socks
		if(ITEM_SLOT_SHIRT)
			return w_shirt
		if(ITEM_SLOT_BRA)
			return w_bra
		if(ITEM_SLOT_PENIS)
			return penis
		if(ITEM_SLOT_VAGINA)
			return vagina
		if(ITEM_SLOT_ANUS)
			return anus
		if(ITEM_SLOT_NIPPLES)
			return nipples
		if(ITEM_SLOT_MOUTH)
			return mouth
		if(ITEM_SLOT_CROTCH)
			return crotch
	. = ..()

/mob/living/carbon/human/get_slot_by_item(obj/item/looking_for)
	if(looking_for == ears_extra)
		return ITEM_SLOT_EARS_RIGHT

	if(looking_for == wrists)
		return ITEM_SLOT_WRISTS

	if(looking_for == w_underwear)
		return ITEM_SLOT_UNDERWEAR

	if(looking_for == w_socks)
		return ITEM_SLOT_SOCKS

	if(looking_for == w_shirt)
		return ITEM_SLOT_SHIRT

	if(looking_for == w_bra)
		return ITEM_SLOT_BRA
	///
	if(looking_for == penis)
		return ITEM_SLOT_PENIS
	if(looking_for == vagina)
		return ITEM_SLOT_VAGINA
	if(looking_for == anus)
		return ITEM_SLOT_ANUS
	if(looking_for == nipples)
		return ITEM_SLOT_NIPPLES
	if(looking_for == mouth)
		return ITEM_SLOT_MOUTH
	if(looking_for == crotch)
		return ITEM_SLOT_CROTCH

	. = ..()

/mob/living/carbon/human/get_body_slots()
	. = ..()
	var/list/extra_body_slots = list(
		w_uniform,
		w_underwear,
		w_socks,
		w_shirt,
		w_bra,
		penis,
		vagina,
		anus,
		nipples,
		mouth,
		crotch,
	)
	LAZYADD(., extra_body_slots)

/mob/living/carbon/human/get_head_slots()
	. = ..()
	var/list/extra_head_slots = list(
		ears_extra,
	)
	LAZYADD(., extra_head_slots)

// Variables for ERP slots
/datum/outfit
	/// Type path of item for vagina slot
	var/vagina = null
	/// Type path of item for anus slot
	var/anus = null
	/// Type path of item for nipples slot
	var/nipples = null
	/// Type path of item for penis slot
	var/penis = null

	var/mouth = null

	var/crotch = null

// Complementing the equipment procedure
/datum/outfit/equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(.)
		pre_equip(H, visualsOnly)
		if(vagina)
			H.equip_to_slot_or_del(new vagina(H),ITEM_SLOT_VAGINA, TRUE)
		if(anus)
			H.equip_to_slot_or_del(new anus(H),ITEM_SLOT_ANUS, TRUE)
		if(nipples)
			H.equip_to_slot_or_del(new nipples(H),ITEM_SLOT_NIPPLES, TRUE)
		if(penis)
			H.equip_to_slot_or_del(new penis(H),ITEM_SLOT_PENIS, TRUE)
		post_equip(H, visualsOnly)
		H.update_body()
		H?.hud_used?.hidden_inventory_update(H)
	return TRUE


// Supplementing the data structure with ERP slot data
/datum/outfit/get_json_data()
	. = ..()

	.["vagina"] = vagina
	.["anus"] = anus
	.["nipples"] = nipples
	.["penis"] = penis
	.["mouth"] = nipples
	.["crotch"] = penis

// Supplementing the data structure with ERP slot data
/datum/outfit/load_from(list/outfit_data)
	vagina = text2path(outfit_data["vagina"])
	anus = text2path(outfit_data["anus"])
	nipples = text2path(outfit_data["nipples"])
	penis = text2path(outfit_data["penis"])
	mouth = text2path(outfit_data["mouth"])
	crotch = text2path(outfit_data["crotch"])
	. = ..()


////////////////////////////////////
// STRIPPING ERP SYSTEM EXTENTION //
////////////////////////////////////

// Extend stripping menus with ERP slots
/*/datum/strippable_item/mob_item_slot/vagina
	key = STRIPPABLE_ITEM_VAGINA
	item_slot = ITEM_SLOT_VAGINA

/datum/strippable_item/mob_item_slot/anus
	key = STRIPPABLE_ITEM_ANUS
	item_slot = ITEM_SLOT_ANUS

/datum/strippable_item/mob_item_slot/nipples
	key = STRIPPABLE_ITEM_NIPPLES
	item_slot = ITEM_SLOT_NIPPLES

/datum/strippable_item/mob_item_slot/penis
	key = STRIPPABLE_ITEM_PEINS
	item_slot = ITEM_SLOT_PENIS*/

// Obscuring for ERP slots
/*/datum/strippable_item/mob_item_slot/vagina/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/anus/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/nipples/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/penis/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY*/

// Strippable ERP items slot list
/*GLOBAL_LIST_INIT(strippable_human_erp_items, create_erp_strippable_list(list(
	/datum/strippable_item/mob_item_slot/vagina,
	/datum/strippable_item/mob_item_slot/anus,
	/datum/strippable_item/mob_item_slot/nipples,
	/datum/strippable_item/mob_item_slot/penis,
)))*/

// This list is only needed in order to immediately add the necessary elements to a typical global list
/*/proc/create_erp_strippable_list(types)
	var/list/strippable_items = list()

	for (var/strippable_type in types)
		var/datum/strippable_item/strippable_item = new strippable_type
		strippable_items[strippable_item.key] = strippable_item
	GLOB.strippable_human_items += strippable_items
	return strippable_items*/

/*//Disables ERP strippable inventory depending on config
/datum/element/strippable/Attach(datum/target, list/items, should_strip_proc_path)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		src.items -= GLOB.strippable_human_erp_items*/

///Proc to check if penis is hidden.
/mob/living/carbon/human/proc/penis_hidden()
	if(underwear_visibility & UNDERWEAR_HIDE_UNDIES)
		return TRUE
	for(var/obj/item/I in list(w_uniform, wear_suit, w_underwear))
		if(istype(I) && ((I.body_parts_covered & GROIN) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if vagina is hidden.
/mob/living/carbon/human/proc/vagina_hidden()
	if(underwear_visibility & UNDERWEAR_HIDE_UNDIES)
		return TRUE
	for(var/obj/item/I in list(w_uniform, wear_suit, w_underwear))
		if(istype(I) && ((I.body_parts_covered & GROIN) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if anus is hidden.
/mob/living/carbon/human/proc/anus_hidden()
	if(underwear_visibility & UNDERWEAR_HIDE_UNDIES)
		return TRUE
	for(var/obj/item/I in list(w_uniform, wear_suit, w_underwear))
		if(istype(I) && ((I.body_parts_covered & GROIN) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

///Proc to check if nipples are hidden.
/mob/living/carbon/human/proc/nipples_hidden()
	if(underwear_visibility & UNDERWEAR_HIDE_SHIRT)
		return TRUE
	for(var/obj/item/I in list(w_uniform, wear_suit, w_bra))
		if(istype(I) && ((I.body_parts_covered & CHEST)))
			return TRUE
	return FALSE

///Proc to check if mouth is hidden.
/mob/living/carbon/human/proc/mouth_hidden()
	for(var/obj/item/I in list(wear_mask, wear_suit))
		if(istype(I) && ((I.body_parts_covered & HEAD) || (I.flags_inv & HIDEFACE)))
			return TRUE
	return FALSE

///Proc to check if crotch is hidden.
/mob/living/carbon/human/proc/crotch_hidden()
	if(underwear_visibility & UNDERWEAR_HIDE_UNDIES)
		return TRUE
	for(var/obj/item/I in list(w_uniform, wear_suit, w_underwear))
		if(istype(I) && ((I.body_parts_covered & GROIN) || (I.flags_inv & HIDEUNDERWEAR)))
			return TRUE
	return FALSE

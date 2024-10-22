/datum/hud/human/New(mob/living/carbon/human/owner)
	. = ..()
	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	// SPLURT EDIT - Extra inventory
	using = new /atom/movable/screen/human/toggle/extra(null, src)
	using.icon = extra_inventory_ui_style(ui_style)
	using.screen_loc = ui_inventory_extra
	toggleable_inventory += using
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "underwear"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "underwear"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "underwear"
	inv_box.screen_loc = ui_boxers
	inv_box.slot_id = ITEM_SLOT_UNDERWEAR
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "socks"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "socks"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "socks"
	inv_box.screen_loc = ui_socks
	inv_box.slot_id = ITEM_SLOT_SOCKS
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "shirt"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "shirt"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "shirt"
	inv_box.screen_loc = ui_shirt
	inv_box.slot_id = ITEM_SLOT_SHIRT
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "bra"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "bra"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "bra"
	inv_box.screen_loc = ui_bra
	inv_box.slot_id = ITEM_SLOT_BRA
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right ear"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "ears_extra"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "ears_extra"
	inv_box.screen_loc = ui_ears_extra
	inv_box.slot_id = ITEM_SLOT_EARS_RIGHT
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "wrists"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "wrists"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "wrists"
	inv_box.screen_loc = ui_wrists
	inv_box.slot_id = ITEM_SLOT_WRISTS
	extra_inventory += inv_box

	using = new /atom/movable/screen/human/toggle/lewd(null, src)
	using.icon = extra_inventory_ui_style(ui_style)
	using.screen_loc = ui_inventory_lewd
	extra_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "penis"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "penis"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "penis"
	inv_box.screen_loc = ui_penis
	inv_box.slot_id = ITEM_SLOT_PENIS
	lewd_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "vagina"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "vagina"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "vagina"
	inv_box.screen_loc = ui_vagina
	inv_box.slot_id = ITEM_SLOT_VAGINA
	lewd_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "anus"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "anus"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "anus"
	inv_box.screen_loc = ui_anus
	inv_box.slot_id = ITEM_SLOT_ANUS
	lewd_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "nipples"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "nipples"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "nipples"
	inv_box.screen_loc = ui_nipples
	inv_box.slot_id = ITEM_SLOT_NIPPLES
	lewd_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "mouth"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "mouth"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "mouth"
	inv_box.screen_loc = ui_mouth
	inv_box.slot_id = ITEM_SLOT_MOUTH
	lewd_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "crotch"
	inv_box.icon = erp_ui_style2icon(ui_style)
	inv_box.icon_state = "crotch"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "crotch"
	inv_box.screen_loc = ui_crotch
	inv_box.slot_id = ITEM_SLOT_CROTCH
	lewd_inventory += inv_box

	//

	for(var/atom/movable/screen/inventory/inv in (extra_inventory + lewd_inventory))
		if(inv.slot_id)
			inv_slots.Add(inv) // Bit shift stuffs don't work for this situation
			inv.update_appearance()

/atom/movable/screen/human/toggle/extra
	name = "toggle extra"
	icon_state = "toggle_extra"

/atom/movable/screen/human/toggle/extra/Click()
	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.extra_shown && targetmob.hud_used)
		usr.hud_used.extra_shown = FALSE
		usr.client.screen -= targetmob.hud_used.extra_inventory
		if(usr.hud_used.lewd_shown)
			usr.client.screen -= targetmob.hud_used.lewd_inventory
	else
		usr.hud_used.extra_shown = TRUE
		usr.client.screen += targetmob.hud_used.extra_inventory
		if(usr.hud_used.lewd_shown)
			usr.client.screen += targetmob.hud_used.lewd_inventory

	targetmob.hud_used.extra_inventory_update(usr)
	targetmob.hud_used.lewd_inventory_update(usr)

/datum/hud/human/extra_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.extra_shown && screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.ears_extra)
			H.ears_extra.screen_loc = ui_ears_extra
			screenmob.client.screen += H.ears_extra
		if(H.w_underwear)
			H.w_underwear.screen_loc = ui_boxers
			screenmob.client.screen += H.w_underwear
		if(H.w_socks)
			H.w_socks.screen_loc = ui_socks
			screenmob.client.screen += H.w_socks
		if(H.w_shirt)
			H.w_shirt.screen_loc = ui_shirt
			screenmob.client.screen += H.w_shirt
		if(H.w_bra)
			H.w_bra.screen_loc = ui_bra
			screenmob.client.screen += H.w_bra
		if(H.wrists)
			H.wrists.screen_loc = ui_wrists
			screenmob.client.screen += H.wrists
	else
		if(H.ears_extra)
			screenmob.client.screen -= H.ears_extra
		if(H.w_underwear)
			screenmob.client.screen -= H.w_underwear
		if(H.w_socks)
			screenmob.client.screen -= H.w_socks
		if(H.w_shirt)
			screenmob.client.screen -= H.w_shirt
		if(H.w_bra)
			screenmob.client.screen -= H.w_bra
		if(H.wrists)
			screenmob.client.screen -= H.wrists


/atom/movable/screen/human/toggle/lewd
	name = "toggle lewd"
	icon_state = "toggle_extra"

/atom/movable/screen/human/toggle/lewd/Click()
	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.lewd_shown && targetmob.hud_used)
		usr.hud_used.lewd_shown = FALSE
		usr.client.screen -= targetmob.hud_used.lewd_inventory
	else
		usr.hud_used.lewd_shown = TRUE
		usr.client.screen += targetmob.hud_used.lewd_inventory

	targetmob.hud_used.lewd_inventory_update(usr)

/datum/hud/human/lewd_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.lewd_shown && screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.penis)
			H.penis.screen_loc = ui_penis
			screenmob.client.screen += H.penis
		if(H.vagina)
			H.vagina.screen_loc = ui_vagina
			screenmob.client.screen += H.vagina
		if(H.anus)
			H.anus.screen_loc = ui_anus
			screenmob.client.screen += H.anus
		if(H.nipples)
			H.nipples.screen_loc = ui_nipples
			screenmob.client.screen += H.nipples
		if(H.mouth)
			H.mouth.screen_loc = ui_mouth
			screenmob.client.screen += H.mouth
		if(H.crotch)
			H.crotch.screen_loc = ui_wrists
			screenmob.client.screen += H.crotch
	else
		if(H.penis)
			screenmob.client.screen -= H.penis
		if(H.vagina)
			screenmob.client.screen -= H.vagina
		if(H.anus)
			screenmob.client.screen -= H.anus
		if(H.nipples)
			screenmob.client.screen -= H.nipples
		if(H.mouth)
			screenmob.client.screen -= H.mouth
		if(H.crotch)
			screenmob.client.screen -= H.crotch

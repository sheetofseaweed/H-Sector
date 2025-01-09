/datum/preference/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!(GLOB.interaction_menu_preferences.Find(type)))
		return
	for(var/datum/tgui/ui in preferences.parent?.mob?.tgui_open_uis)
		if(ui.interface == "MobInteraction")
			return TRUE

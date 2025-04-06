/datum/preference/toggle/hide_splashscreen
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "hide_splashscreen"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/datum/preference/toggle/hide_splashscreen/apply_to_client_updated(client/client, value)
	. = ..()
	if(istype(client?.mob, /mob/dead/new_player))
		INVOKE_ASYNC(client.mob, TYPE_PROC_REF(/mob/dead/new_player, show_title_screen))

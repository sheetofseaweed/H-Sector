#define VETTED_TOML_FILE "[global.config.directory]/splurt/roles.toml"

/datum/controller/subsystem/player_ranks/get_user_vetted_status_hot(ckey)
	if(IsAdminAdvancedProcCall())
		return
	var/list/vetted = rustg_read_toml_file(VETTED_TOML_FILE)
	if(vetted & vetted.Find(ckey))
		return TRUE
	. = ..()

#undef VETTED_TOML_FILE

/// Remove robocop module from AI research node
/datum/techweb_node/ai/New()
	. = ..()
	design_ids -= "robocop_module"

/datum/design/board/robocop_module/Initialize(mapload)
	return INITIALIZE_HINT_QDEL

/// Remove robocop from harmless AI module spawner
/obj/effect/spawner/random/aimodule/harmless/Initialize(mapload)
	. = ..()
	loot -= /obj/item/ai_module/core/full/robocop

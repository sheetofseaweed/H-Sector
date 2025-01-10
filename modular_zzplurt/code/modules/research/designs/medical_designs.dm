/datum/design/implant_gfluid
	name = "Genital Fluid Implant Case"
	desc = "A glass case containing a Genital Fluid Infuser implant."
	id = "implant_gfluid"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/implantcase/genital_fluid
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

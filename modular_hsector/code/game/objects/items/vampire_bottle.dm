/datum/reagent/blood/fancy
	name = "High Quality Blood"
	description = "A noble virgin donor's blood."
	taste_description = "sweet innocence"

/datum/glass_style/drinking_glass/blood/fancy
	required_drink_type = /datum/reagent/blood/fancy
	name = "glass of Vampire Delight"
	desc = "To sate the fanged gentlemen and gentlewomen."
	icon_state = "glass_red"

/obj/item/reagent_containers/cup/glass/bottle/vampire_bottle
	name = "Vampire Delight"
	desc = "To sate the fanged gentlemen and gentlewomen."
	list_reagents = list(/datum/reagent/blood/fancy = 90)

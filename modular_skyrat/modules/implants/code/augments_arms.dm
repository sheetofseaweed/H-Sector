#define KNIFE_HITSOUND 'sound/items/weapons/bladeslice.ogg'
#define KNIFE_USESOUND 'sound/items/weapons/bladeslice.ogg'
#define KNIFE_ATTACK_VERB_CONTINUOUS list("slashes", "tears", "slices", "tears", "lacerates", "rips", "dices", "cuts", "rends")
#define KNIFE_ATTACK_VERB_SIMPLE list("slash", "tear", "slice", "tear", "lacerate", "rip", "dice", "cut", "rend")
#define KNIFE_SHARPNESS SHARP_EDGED
#define KNIFE_EXPOSED_WOUND_BONUS 15
#define CUTTER_HITSOUND 'sound/items/tools/wirecutter.ogg'
#define CUTTER_USESOUND 'sound/items/tools/wirecutter.ogg'
#define CUTTER_ATTACK_VERB_CONTINUOUS list("bashes", "batters", "bludgeons", "thrashes", "whacks")
#define CUTTER_ATTACK_VERB_SIMPLE list("bash", "batter", "bludgeon", "thrash", "whack")
#define CUTTER_FORCE 6
#define CUTTER_WOUND_BONUS 0
#define ENHANCED_KNIFE_FORCE 15
#define ENHANCED_KNIFE_WOUND_BONUS 15
#define ENHANCED_KNIFE_ARMOR_PENETRATION 10

/obj/item/melee/implantarmblade
	name = "implanted arm blade"
	desc = "A long, sharp, mantis-like blade implanted into someones arm. Cleaves through flesh like its particularly strong butter."
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_lefthand.dmi'
	icon_state = "mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	sharpness = SHARP_EDGED
	force = 20
	armour_penetration = 20
	item_flags = NEEDS_PERMIT //Beepers gets angry if you get caught with this.
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'

/obj/item/melee/implantarmblade/energy
	name = "energy arm blade"
	desc = "A long mantis-like blade made entirely of blazing-hot energy. Stylish and EXTRA deadly!"
	icon_state = "energy_mantis_blade"
	force = 30
	armour_penetration = 10 //Energy isn't as good at going through armor as it is through flesh alone.
	hitsound = 'sound/items/weapons/blade1.ogg'

/obj/item/organ/cyberimp/arm/toolkit/armblade
	name = "arm blade implant"
	desc = "An integrated blade implant designed to be installed into a persons arm. Stylish and deadly; Although, being caught with this without proper permits is sure to draw unwanted attention."
	items_to_create = list(/obj/item/melee/implantarmblade)
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	icon_state = "mantis_blade"

/obj/item/organ/cyberimp/arm/toolkit/armblade/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated energy arm blade! You madman!"))
	items_list += WEAKREF(new /obj/item/melee/implantarmblade/energy(src))
	obj_flags |= EMAGGED
	return TRUE


/obj/item/organ/cyberimp/arm/toolkit/hacker
	name = "hacking arm implant"
	desc = "An small arm implant containing an advanced screwdriver, wirecutters, and multitool designed for engineers and on-the-field machine modification. Actually legal, despite what the name may make you think."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_multitool"
	items_to_create = list(/obj/item/screwdriver/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/abductor/implant)

/obj/item/organ/cyberimp/arm/toolkit/botany
	name = "botany arm implant"
	desc = "A rather simple arm implant containing tools used in gardening and botanical research."
	items_to_create = list(/obj/item/cultivator, /obj/item/shovel/spade, /obj/item/hatchet, /obj/item/gun/energy/floragun, /obj/item/plant_analyzer, /obj/item/geneshears, /obj/item/secateurs, /obj/item/storage/bag/plants, /obj/item/storage/bag/plants/portaseeder)

/obj/item/implant_mounted_chainsaw
	name = "integrated chainsaw"
	desc = "A chainsaw that conceals inside your arm."
	icon = 'icons/obj/weapons/chainsaw.dmi'
	icon_state = "chainsaw_on"
	inhand_icon_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	force = 24
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/organ/cyberimp/arm/toolkit/botany/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s deluxe landscaping equipment!"))
	items_list += WEAKREF(new /obj/item/implant_mounted_chainsaw(src)) //time to landscape the station
	obj_flags |= EMAGGED
	return TRUE

/obj/item/multitool/abductor/implant
	name = "multitool"
	desc = "An optimized, highly advanced stripped-down multitool able to interface with electronics far better than its standard counterpart."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_multitool"

/obj/item/organ/cyberimp/arm/toolkit/janitor
	name = "janitorial tools implant"
	desc = "A set of janitorial tools on the user's arm."
	items_to_create = list(/obj/item/lightreplacer, /obj/item/holosign_creator, /obj/item/soap/nanotrasen, /obj/item/reagent_containers/spray/cyborg_drying, /obj/item/mop/advanced, /obj/item/paint/paint_remover, /obj/item/reagent_containers/cup/beaker/large, /obj/item/reagent_containers/spray/cleaner) //Beaker if for refilling sprays

/obj/item/organ/cyberimp/arm/toolkit/janitor/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated deluxe cleaning supplies!"))
	items_list += WEAKREF(new /obj/item/soap/syndie(src)) //We add not replace.
	items_list += WEAKREF(new /obj/item/reagent_containers/spray/cyborg_lube(src))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/organ/cyberimp/arm/toolkit/lighter
	name = "lighter implant"
	desc = "A... implanted lighter. Incredibly useless."
	items_to_create = list(/obj/item/lighter/greyscale) //Hilariously useless.

/obj/item/organ/cyberimp/arm/toolkit/lighter/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated Zippo lighter! Finally, classy smoking!"))
	items_list += WEAKREF(new /obj/item/lighter(src)) //Now you can choose between bad and worse!
	obj_flags |= EMAGGED
	return TRUE

#undef KNIFE_HITSOUND
#undef KNIFE_USESOUND
#undef KNIFE_ATTACK_VERB_CONTINUOUS
#undef KNIFE_ATTACK_VERB_SIMPLE
#undef KNIFE_SHARPNESS
#undef KNIFE_EXPOSED_WOUND_BONUS
#undef CUTTER_HITSOUND
#undef CUTTER_USESOUND
#undef CUTTER_ATTACK_VERB_CONTINUOUS
#undef CUTTER_ATTACK_VERB_SIMPLE
#undef CUTTER_FORCE
#undef CUTTER_WOUND_BONUS
#undef ENHANCED_KNIFE_FORCE
#undef ENHANCED_KNIFE_WOUND_BONUS
#undef ENHANCED_KNIFE_ARMOR_PENETRATION

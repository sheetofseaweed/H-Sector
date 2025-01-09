/// Plushie choise beacon ///
// Box Delivery Code
/obj/item/choice_beacon/box
	name = "choice box (default)"
	desc = "Think really hard about what you want, and then rip it open!"
	icon = 'icons/obj/storage/wrapping.dmi'
	icon_state = "deliverypackage3"

/obj/item/choice_beacon/box/spawn_option(atom/choice, mob/living/M)
	var/choice_text = choice
	if(ispath(choice_text))
		choice_text = initial(choice.name)
	to_chat(M, "<span class='hear'>The box opens, revealing the [choice_text]!</span>")
	playsound(src.loc, 'sound/items/poster/poster_ripped.ogg', 50, 1)
	M.temporarilyRemoveItemFromInventory(src, TRUE)
	M.put_in_hands(new choice)
	qdel(src)

// Standart
/obj/item/choice_beacon/box/plushie
	name = "choice box (plushie)"
	desc = "Using the power of quantum entanglement, this box contains every plush, until the moment it is opened!"
	icon = 'icons/obj/storage/wrapping.dmi'
	icon_state = "deliverypackage3"

/obj/item/choice_beacon/box/plushie/generate_display_names()
	var/static/list/plushie_list = list()
	if(!length(plushie_list))
		var/list/plushies_set_one = subtypesof(/obj/item/toy/plush)
		plushies_set_one = remove_bad_plushies(plushies_set_one)
		for(var/V in plushies_set_one)
			var/atom/A = V
			plushie_list[initial(A.name)] = A
	return plushie_list

/obj/item/choice_beacon/box/plushie/proc/remove_bad_plushies(list/plushies)
	plushies -= list(
		/obj/item/toy/plush/narplush,
		/obj/item/toy/plush/awakenedplushie
		)
	return plushies

// Deluxe
/obj/item/choice_beacon/box/plushie/deluxe
	name = "Deluxe choice box (plushie)"
	desc =  "Using the power of quantum entanglement, this box contains five times every plush, until the moment it is opened!"
	uses = 5

/obj/item/choice_beacon/box/plushie/deluxe/spawn_option(choice, mob/living/M)
	//I don't wanna recode two different procs just for it to do the same as doing this
	if(uses > 1)
		var/obj/item/choice_beacon/box/plushie/deluxe/replace = new
		replace.uses = uses - 1
		M.put_in_hands(replace)
	. = ..()

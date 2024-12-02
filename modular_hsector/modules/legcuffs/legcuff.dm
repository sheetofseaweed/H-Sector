#define LEGCUFFS_TYPE_WEAK 0
#define LEGCUFFS_TYPE_STRONG 1

/mob/living/carbon/proc/canBeLegcuffed()
	return FALSE

/mob/living/carbon/human/canBeLegcuffed()
	if(num_legs < 2)
		return FALSE
	return TRUE

/obj/item/restraints/legcuffs
	///How long it takes to legcuff someone
	var/legcuff_time = 4 SECONDS
	///Multiplier for legcuff time
	var/legcuff_time_mod = 1
	///Sound that plays when starting to put legcuffs on someone
	var/cuffsound = 'sound/items/weapons/handcuffs.ogg'
	///Sound that plays when restrain is successful
	var/cuffsuccesssound = 'sound/items/handcuff_finish.ogg'
	///If set, legcuffs will be destroyed on application and leave behind whatever this is set to.
	var/trashtype = null
	/// How strong the cuffs are
	var/restraint_strength = LEGCUFFS_TYPE_STRONG
	var/can_put_on_manually = TRUE

/obj/item/restraints/legcuffs/attack(mob/living/target_mob, mob/living/user)
	if(!iscarbon(target_mob))
		return

	attempt_to_legcuff(target_mob, user)

/// Handles all of the checks and application in a typical situation where someone attacks a carbon victim with the legcuff item.
/obj/item/restraints/legcuffs/proc/attempt_to_legcuff(mob/living/carbon/victim, mob/living/user)
	if(!can_put_on_manually)
		return

	if(SEND_SIGNAL(victim, COMSIG_CARBON_CUFF_ATTEMPTED, user) & COMSIG_CARBON_CUFF_PREVENT)
		victim.balloon_alert(user, "can't be legcuffed!")
		return

	if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))) //Clumsy people have a 50% chance to legcuff themselves instead of their target.
		to_chat(user, span_warning("Uh... how do those things work?!"))
		apply_legcuffs(user, user)
		return

	if(!isnull(victim.legcuffed))
		victim.balloon_alert(user, "already legcuffed!")
		return

	if(!victim.canBeLegcuffed())
		victim.balloon_alert(user, "can't be legcuffed!")
		return

	victim.visible_message(
		span_danger("[user] is trying to put [src] on [victim]!"),
		span_userdanger("[user] is trying to put [src] on you!"),
	)

	if(victim.is_blind())
		to_chat(victim, span_userdanger("You feel someone grab your legs and start putting [src] on them!"))

	playsound(loc, cuffsound, 30, TRUE, -2)
	log_combat(user, victim, "attempted to legcuff")

	if(HAS_TRAIT(user, TRAIT_FAST_CUFFING)) //maybe add shibari trait or smth
		legcuff_time_mod = 0.75
	else
		legcuff_time_mod = 1

	if(!do_after(user, legcuff_time * legcuff_time_mod, victim, timed_action_flags = IGNORE_SLOWDOWNS) || !victim.canBeLegcuffed())
		victim.balloon_alert(user, "failed to legcuff!")
		to_chat(user, span_warning("You fail to legcuff [victim]!"))
		log_combat(user, victim, "failed to legcuff")
		return

	apply_legcuffs(victim, user, dispense = iscyborg(user))
	playsound(loc, cuffsuccesssound, 30, TRUE, -2)

	victim.visible_message(
		span_notice("[user] legcuffs [victim]."),
		span_userdanger("[user] legcuffs you."),
	)

	log_combat(user, victim, "successfully legcuffed")
	SSblackbox.record_feedback("tally", "legcuffs", 1, type)


/**
 * When called, this instantly puts legcuffs on someone (if actually possible)
 *
 * Arguments:
 * * mob/living/carbon/target - Who is being legcuffed
 * * mob/user - Who or what is doing the legcuffing
 * * dispense - True if the cuffing should create a new item instead of using putting src on the mob, false otherwise. False by default.
*/
/obj/item/restraints/legcuffs/proc/apply_legcuffs(mob/living/carbon/target, mob/user, dispense = FALSE)
	if(target.legcuffed)
		return

	if(!user.temporarilyRemoveItemFromInventory(src) && !dispense)
		return

	var/obj/item/restraints/legcuffs/cuffs = src
	if(trashtype)
		cuffs = new trashtype()
	else if(dispense)
		cuffs = new type()

	target.equip_to_slot(cuffs, ITEM_SLOT_LEGCUFFED)

	if(trashtype && !dispense)
		qdel(src)


#undef LEGCUFFS_TYPE_WEAK
#undef LEGCUFFS_TYPE_STRONG

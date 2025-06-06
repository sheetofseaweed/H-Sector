/obj/item/clothing/erp_leash
	name = "leash"
	desc = "A guiding hand's best friend; in a sleek, semi-elastic package. Can either clip to a collar or be affixed to the neck on its own."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	icon_state = "neckleash_pink"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	slot_flags = ITEM_SLOT_BELT
	breakouttime = 3 SECONDS
	/// Weakref to the leash component we're using, if it exists.
	var/datum/weakref/our_leash_component

	/// Leash line visual for the hooked item
	var/datum/beam/leash_line/leash_line

	unique_reskin = list(
		"Pink" = "neckleash_pink",
		"Teal" = "neckleash_teal",
	)

	COOLDOWN_DECLARE(tug_cd)

/// HERE BE DRAGONS ///

/// Checks; leashing start
/obj/item/clothing/erp_leash/attack(mob/living/to_be_leashed, mob/living/user, params)
	var/datum/component/leash/erp/the_leash_component = our_leash_component?.resolve()
	if(the_leash_component)
		if(the_leash_component.parent == to_be_leashed) // We're hooked to them; and we have a component. Get 'em out!
			remove_leash(to_be_leashed)
			return
	else
		our_leash_component = null
	/// Check if we even CAN leash someone / if someone is leashing themselves. If so; prevent it.
	if(user == to_be_leashed)
		return
	if(!istype(to_be_leashed,/mob/living/carbon/human) && !istype(to_be_leashed,/mob/living/silicon/robot))
		return
	if(!istype(user,/mob/living/carbon/human) && !istype(user,/mob/living/silicon/robot))
		return
	/// Actually start the leashing part here
	to_be_leashed.visible_message(span_warning("[user] raises the [src] to [to_be_leashed]'s neck!"),\
				span_userdanger("[user] starts to bring the [src] to your neck!"),\
				span_hear("You hear a light click as pressure builds in the air around your neck."))
	if(!do_after(user, 2 SECONDS, to_be_leashed))
		return
	create_leash(user, to_be_leashed)

/// Leash Initialization
/obj/item/clothing/erp_leash/proc/create_leash(mob/user, mob/ouppy)
	if(!istype(ouppy))
		return

	ouppy.AddComponent(/datum/component/leash/erp, src, 2)
	if(our_leash_component.resolve()) // The component will immediately delete itself if there's an existing one; this sanity checks for feedback on if it failed.
		ouppy.balloon_alert(user, "leashed!")
		create_leash_line(ouppy)
		return
	else to_chat(user, span_danger("There's a leash attached to [ouppy] already."))

/// Leash removal
/obj/item/clothing/erp_leash/proc/remove_leash(mob/free_bird)
	free_bird?.balloon_alert_to_viewers("unhooked")
	clear_line(src)
	qdel(our_leash_component.resolve())

/*
	Leash Component
*/

/datum/component/leash/erp
	dupe_mode = COMPONENT_DUPE_UNIQUE

// 'owner' refers the leash item, while 'parent' refers to the one it's affixed to.
/datum/component/leash/erp/RegisterWithParent()
	. = ..()
	// Owner Signals
	RegisterSignal(owner, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_item_attack_self))
	RegisterSignal(owner, COMSIG_ITEM_DROPPED, PROC_REF(on_item_dropped))
	RegisterSignal(owner, COMSIG_ITEM_EQUIPPED, PROC_REF(on_item_dropped))
	RegisterSignal(owner, COMSIG_ITEM_EQUIPPED_AS_OUTFIT, PROC_REF(on_item_dropped))
	// Parent Signals
	RegisterSignal(parent, COMSIG_LIVING_RESIST, PROC_REF(on_parent_resist))
	if(istype(owner, /obj/item/clothing/erp_leash))
		var/obj/item/clothing/erp_leash/our_leash = owner
		our_leash.our_leash_component = WEAKREF(src)

/datum/component/leash/erp/UnregisterFromParent()
	if(owner) // Destroy() sets owner to null
		UnregisterSignal(owner, list(COMSIG_ITEM_ATTACK_SELF, COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_EQUIPPED_AS_OUTFIT))
		UnregisterSignal(parent, COMSIG_LIVING_RESIST)
	return ..()

/datum/component/leash/erp/Destroy() // Have to do this here too
	UnregisterSignal(owner, list(COMSIG_ITEM_ATTACK_SELF, COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_EQUIPPED_AS_OUTFIT))
	if(istype(owner, /obj/item/clothing/erp_leash))
		var/obj/item/clothing/erp_leash/our_leash = owner
		our_leash.our_leash_component = null
	return ..()


/datum/component/leash/erp/proc/on_item_attack_self(datum/source, mob/user)
	SIGNAL_HANDLER

	if(istype(source, /obj/item/clothing/erp_leash))
		var/obj/item/clothing/erp_leash/leash_hookin = source
		if(!COOLDOWN_FINISHED(leash_hookin, tug_cd))
			return
		if(istype(parent, /mob/living))
			var/mob/living/yoinked = parent
			yoinked.Move(get_step_towards(yoinked,user))
			yoinked.adjustStaminaLoss(10)
			yoinked.visible_message(span_warning("[yoinked] is pulled in as [user] tugs the [source]!"),\
					span_userdanger("[user] suddenly tugs the [source], pulling you closer!"),\
					span_userdanger("A sudden tug against your neck pulls you ahead!"))
			COOLDOWN_START(leash_hookin, tug_cd, 1 SECONDS)

/datum/component/leash/erp/proc/on_item_dropped(datum/source, mob/user)
	SIGNAL_HANDLER

	if(istype(parent, /mob))
		var/mob/our_parent = parent
		our_parent.balloon_alert_to_viewers("unhooked")
	qdel(src)

/datum/component/leash/erp/proc/on_parent_resist(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(do_resist))

/datum/component/leash/erp/proc/do_resist(datum/source, mob/user)
	if(istype(parent, /mob) && istype(owner,/obj/item))
		var/mob/our_parent = parent
		var/obj/item/our_owner = owner
		our_parent.visible_message(span_warning("[our_parent] attempts to unhook [our_parent.p_them()]self from the leash!"), \
			span_userdanger("You start to unhook yourself from the leash..."), \
			span_userdanger("You fumble in the dark, looking to unhook the leash..."))
		if(do_after(our_parent, our_owner.breakouttime, target = our_parent))
			to_chat(our_parent, span_notice("You unhook yourself from the leash."))
			qdel(src)
	else qdel(src) // If they're not an item; something is very wrong - qdel anyways without the breakout time.

/// create_leash_line
/// Adds leash as beam, definetly not copy pasted from fishing line
/obj/item/clothing/erp_leash/proc/create_leash_line(atom/movable/target, target_py = null)
	var/mob/user = loc
	if(!istype(user))
		return
	if(leash_line)
		QDEL_NULL(leash_line)
	var/beam_color = "purple"
	leash_line = new(user, target, icon_state = "fishing_line", beam_color = beam_color,  emissive = FALSE, override_target_pixel_y = target_py)
	leash_line.lefthand = user.get_held_index_of_item(src) % 2 == 1
	RegisterSignal(leash_line, COMSIG_BEAM_BEFORE_DRAW, PROC_REF(check_los))
	RegisterSignal(leash_line, COMSIG_QDELETING, PROC_REF(clear_line))
	INVOKE_ASYNC(leash_line, TYPE_PROC_REF(/datum/beam/, Start))
	user.update_held_items()
	return leash_line

/obj/item/clothing/erp_leash/proc/check_los(datum/beam/source)
	SIGNAL_HANDLER
	. = NONE

	if(!CheckToolReach(src, source.target, 6)) // More distance than leash itself, prevents it from suddenly dissapearing...HOPEFULLY
		qdel(source)
		return BEAM_CANCEL_DRAW

/obj/item/clothing/erp_leash/proc/clear_line(datum/source)
	SIGNAL_HANDLER
	if(ismob(loc))
		var/mob/user = loc
		user.update_held_items()
	leash_line = null

/obj/item/clothing/erp_leash/dropped(mob/user, silent)
	. = ..()
	QDEL_NULL(leash_line)

/datum/beam/leash_line
	// Is the fishing rod held in left side hand
	var/lefthand = FALSE

	// Make these inline with final sprites

	var/righthand_px = 0
	var/righthand_py = 0

	var/lefthand_px = 0
	var/lefthand_py = 0

/datum/beam/leash_line/Start()
	update_offsets(origin.dir)
	. = ..()
	RegisterSignal(origin, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_dir_change))

/datum/beam/leash_line/Destroy()
	UnregisterSignal(origin, COMSIG_ATOM_DIR_CHANGE)
	. = ..()

/datum/beam/leash_line/proc/handle_dir_change(atom/movable/source, olddir, newdir)
	SIGNAL_HANDLER
	update_offsets(newdir)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/beam/, redrawing))

/datum/beam/leash_line/proc/update_offsets(user_dir)
	override_origin_pixel_x = lefthand ? lefthand_px : righthand_px
	override_origin_pixel_y = lefthand ? lefthand_py : righthand_py

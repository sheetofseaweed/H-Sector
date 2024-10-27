//todo

/*/datum/emote/living/moan
	vary = TRUE
	mob_type_blacklist_typecache = list(/mob/living/carbon/human, /mob/living/brain) //Humans get specialized moan.

/datum/emote/living/moan/get_sound(mob/living/user)
	if(issilicon(user))
		var/mob/living/silicon/silicon_user = user
		var/datum/scream_type/selected_scream = silicon_user.selected_scream
		if(isnull(selected_scream))
			return 'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg'
		if(user.gender == FEMALE && LAZYLEN(selected_scream.female_screamsounds))
			return pick(selected_scream.female_screamsounds)
		else
			return pick(selected_scream.male_screamsounds)
	//todo:add default moans for various mob types

/datum/emote/living/moan/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user

		if(robot_user.cell?.charge < STANDARD_CELL_CHARGE * 0.2)
			to_chat(robot_user , span_warning("Moan module deactivated. Please recharge."))
			return FALSE
		robot_user.cell.use(STANDARD_CELL_CHARGE * 0.2)
	return ..()*/

/datum/emote/living/carbon/moan
	only_forced_audio = FALSE

/datum/emote/living/carbon/moan/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(isnull(user.selected_moan) || !(LAZYLEN(user.selected_moan.male_moansounds) && LAZYLEN(user.selected_moan.female_moansounds))) //For things that don't have a selected scream(npcs)
		return user.dna.species.get_moan_sound(user)
	var/voice_type = user.client.prefs.read_preference(/datum/preference/choiced/voice_type)
	if(voice_type == "Based on Gender")
		if((user.client.prefs.read_preference(/datum/preference/choiced/gender) == MALE) || isnull(user.selected_moan.female_moansounds))
			return pick(user.selected_moan.male_moansounds)
		else
			return pick(user.selected_moan.female_moansounds)
	else if((voice_type == "Male") || isnull(user.selected_moan.female_moansounds))
		return pick(user.selected_moan.male_moansounds)
	else
		return pick(user.selected_moan.female_moansounds)

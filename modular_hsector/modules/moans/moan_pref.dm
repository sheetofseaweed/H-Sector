/datum/preference/choiced/voice_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_voice_type"

/datum/preference/choiced/voice_type/init_possible_values()
	return list("Based on Gender", "Male", "Female")

/datum/preference/choiced/voice_type/create_default_value()
	return "Based on Gender"

/datum/preference/choiced/moan
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_moan"

/datum/preference/choiced/moan/init_possible_values()
	return assoc_to_keys(GLOB.moan_types)

/datum/preference/choiced/moan/apply_to_human(mob/living/carbon/human/target, value)
	var/moan_id = GLOB.moan_types[value]
	if(moan_id)
		var/datum/moan_type/moan_type = new moan_id
		target.selected_moan = moan_type

/datum/preference_middleware/moan
	/// Cooldown on requesting a moan preview.
	COOLDOWN_DECLARE(moan_cooldown)

	action_delegations = list(
		"play_moan" = PROC_REF(play_moan),
	)

/datum/preference_middleware/moan/proc/play_moan(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, moan_cooldown))
		return TRUE

	var/value = preferences.read_preference(/datum/preference/choiced/moan)
	var/moan_id = GLOB.moan_types[value]
	var/voice_type = preferences.read_preference(/datum/preference/choiced/voice_type)
	var/sound/moan
	if(moan_id)
		var/datum/moan_type/moan_type = new moan_id
		if(voice_type == "Based on Gender")
			if((preferences.read_preference(/datum/preference/choiced/gender) == MALE) || isnull(moan_type.female_moansounds))
				moan = pick(moan_type.male_moansounds)
			else
				moan = pick(moan_type.female_moansounds)
		else if((voice_type == "Male") || isnull(moan_type.female_moansounds))
			moan = pick(moan_type.male_moansounds)
		else
			moan = pick(moan_type.female_moansounds)
		var/mob/living/carbon/human/u = user
		var/turf/T = get_turf(src)
		u.playsound_local(T, vol = 100, vary = TRUE, frequency = 1, max_distance = 1, falloff_distance = 0, falloff_exponent = 2, soundin = moan, distance_multiplier = 1)
		COOLDOWN_START(src, moan_cooldown, 2 SECONDS)
		return TRUE
	return FALSE

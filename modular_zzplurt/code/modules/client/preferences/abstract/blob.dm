/datum/preference/blob
	abstract_type = /datum/preference/blob
	can_randomize = FALSE

/datum/preference/blob/create_default_value()
	return list()

/datum/preference/blob/deserialize(input, datum/preferences/preferences)
	if(!islist(input))
		return list()
	return input

/datum/preference/blob/is_valid(value)
	return islist(value)

/datum/preference/blob/apply_to_human(mob/living/carbon/human/target, value)
	return

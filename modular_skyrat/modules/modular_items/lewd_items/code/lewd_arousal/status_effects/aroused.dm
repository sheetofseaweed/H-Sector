#define AUTO_EMOTE_CHANCE 3

#define MASOCHISM_PAIN_OFFSET 0.5
#define NEVERBONER_PLEASURE_OFFSET 50

#define TOO_MUCH_PAIN_MODIFIER 0.1
#define ITS_PRETTY_HOT_IN_HERE_MODIFIER 0.1

#define BASE_AROUSAL_ADJUSTMENT -0.1
#define BASE_PAIN_AND_PLEASURE_ADJUSTMENT -0.5

/datum/status_effect/aroused
	id = "aroused"
	tick_interval = 1 SECONDS
	duration = STATUS_EFFECT_PERMANENT
	alert_type = null

/datum/status_effect/aroused/tick(seconds_between_ticks)
	//hsector edit - remove erp check
	//was: if(owner.stat >= DEAD || !(owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || (!ishuman(owner) && !owner.client && !SSinteractions.is_blacklisted(owner)))) // SPLURT EDIT - INTERACTIONS - All mobs should be interactable
	if((owner.stat >= DEAD) || (!ishuman(owner) && !owner.client && SSinteractions.is_blacklisted(owner)))
		return

	var/mob/living/carbon/human/affected_mob = owner
	var/temp_arousal = BASE_AROUSAL_ADJUSTMENT
	var/temp_pleasure = BASE_PAIN_AND_PLEASURE_ADJUSTMENT
	var/temp_pain = BASE_PAIN_AND_PLEASURE_ADJUSTMENT

	if(HAS_TRAIT(affected_mob, TRAIT_MASOCHISM))
		temp_pain -= MASOCHISM_PAIN_OFFSET
	if(HAS_TRAIT(affected_mob, TRAIT_NEVERBONER))
		temp_pleasure -= NEVERBONER_PLEASURE_OFFSET
		temp_arousal -= NEVERBONER_PLEASURE_OFFSET

	if(affected_mob.pain > affected_mob.pain_limit)
		temp_arousal -= TOO_MUCH_PAIN_MODIFIER
	if(affected_mob.arousal >= AROUSAL_MEDIUM)
		if(prob(AUTO_EMOTE_CHANCE))
			affected_mob.try_lewd_autoemote(pick("moan", "blush"))
		temp_pleasure += ITS_PRETTY_HOT_IN_HERE_MODIFIER
		//moan
	if(affected_mob.pleasure >= AROUSAL_HIGH && prob(AUTO_EMOTE_CHANCE))
		affected_mob.try_lewd_autoemote(pick("moan", "twitch_s"))
		//moan x2

	affected_mob.adjust_arousal(temp_arousal)
	affected_mob.adjust_pleasure(temp_pleasure * (ishuman(affected_mob) ? (affected_mob.dna.features["lust_tolerance"] || 1) : 1)) // SPLURT EDIT - Lust tolerance
	affected_mob.adjust_pain(temp_pain)

#undef AUTO_EMOTE_CHANCE

#undef MASOCHISM_PAIN_OFFSET
#undef NEVERBONER_PLEASURE_OFFSET

#undef TOO_MUCH_PAIN_MODIFIER
#undef ITS_PRETTY_HOT_IN_HERE_MODIFIER

#undef BASE_AROUSAL_ADJUSTMENT
#undef BASE_PAIN_AND_PLEASURE_ADJUSTMENT

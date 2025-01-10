/datum/interaction/lewd/boob_smack
	name = "Smack Tits"
	description = "Smack their tits."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	target_required_parts = list(ORGAN_SLOT_BREASTS = REQUIRE_GENITAL_EXPOSED)
	message = list(
		"smacks %TARGET%'s tits!",
		"slaps %TARGET%'s boobs!",
		"gives %TARGET%'s chest a slap!",
		"whacks %TARGET% right on the tits!"
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/slap.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pain = 5
	user_arousal = 2
	target_pleasure = 4
	target_arousal = 3

/datum/interaction/lewd/boob_smack/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/original_pleasure = target_pleasure
	if(HAS_TRAIT(target, TRAIT_MASOCHISM))
		target_pleasure = abs(original_pleasure) * 1.5 // Masochists get 50% more pleasure from the pain
	. = ..()
	target_pleasure = original_pleasure

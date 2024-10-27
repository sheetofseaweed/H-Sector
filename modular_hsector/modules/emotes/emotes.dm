
/datum/emote/living/ruffle
	key = "ruffle"
	key_third_person = "ruffles"
	message = "ruffles their wings for a moment."

/datum/emote/living/ruffle/run_emote(mob/user, params, type_override, intentional)
	message = "ruffles [user.p_their()] wings for a moment."
	. = ..()

/datum/emote/living/bleat
	key = "bleat"
	key_third_person = "bleats"
	message = "bleats loudly!"
	message_mime = "bleats silently!"
	sound = 'modular_zzplurt/sound/voice/bleat.ogg'
	cooldown = 0.7 SECONDS

/datum/emote/living/chitter2
	key = "chitter2"
	key_third_person = "chitters2"
	message = "chitters."
	message_mime = "chitters silently!"
	sound = 'modular_zzplurt/sound/voice/moth/mothchitter2.ogg'
	audio_cooldown = 0.3 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/yap
	key = "yap"
	key_third_person = "yaps"
	message = "yaps!"
	message_mime = "acts out a yap!"
	sound = 'modular_zzplurt/sound/voice/yap.ogg'
	audio_cooldown = 0.28 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "yips!"
	message_mime = "acts out a yip!"
	sound = 'modular_zzplurt/sound/voice/yip.ogg'
	audio_cooldown = 0.2 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bark2
	key = "bark2"
	key_third_person = "barks2"
	message = "barks!"
	message_mime = "acts out a bark!"
	sound = 'modular_zzplurt/sound/voice/bark_alt.ogg'
	audio_cooldown = 0.35 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/weh2
	key = "weh2"
	key_third_person = "wehs2"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_zzplurt/sound/voice/weh2.ogg'
	audio_cooldown = 0.25 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/weh3
	key = "weh3"
	key_third_person = "wehs3"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_zzplurt/sound/voice/weh3.ogg'
	audio_cooldown = 0.25 SECONDS
	emote_type = EMOTE_AUDIBLE


/datum/emote/living/weh4
	key = "weh4"
	key_third_person = "wehs4"
	message = "let out a surprised weh!"
	message_mime = "acts out a surprised weh!"
	sound = 'modular_zzplurt/sound/voice/weh_s.ogg'
	audio_cooldown = 0.35 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/mlem
	key = "mlem"
	key_third_person = "mlems"
	message = "sticks their tongue for a moment. Mlem!"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/coyhowl
	key = "coyhowl"
	key_third_person = "coyhowls"
	message = "howls like coyote!"
	message_mime = "acts out a coyote's howl!"
	sound = 'modular_zzplurt/sound/voice/coyotehowl.ogg'
	audio_cooldown = 2.94 SECONDS // Uses longest sound's time
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/coyhowl/get_sound(mob/living/user)
	. = ..()
	return pick('modular_zzplurt/sound/voice/coyotehowl.ogg', 'modular_zzplurt/sound/voice/coyotehowl2.ogg', 'modular_zzplurt/sound/voice/coyotehowl3.ogg', 'modular_zzplurt/sound/voice/coyotehowl4.ogg', 'modular_zzplurt/sound/voice/coyotehowl5.ogg')

/datum/emote/living/pant
	key = "pant"
	key_third_person = "pants"
	message = "pants!"

/datum/emote/living/pant/run_emote(mob/user, params, type_override, intentional)
	var/list/pants = list(
				"pants!",
		"pants like a dog.",
		"lets out soft pants.",
		"pulls [user.p_their()] tongue out, panting."
	)
	message = pick(pants)
	. = ..()

/datum/emote/living/yippee
	key = "yippee"
	key_third_person = "yippees"
	message = "lets out a yippee!"
	message_mime = "acts out a yippee!"
	cooldown = 1.2 SECONDS

/datum/emote/living/mewo
	key = "mewo"
	key_third_person = "mewos"
	message = "mewos!"
	message_mime = "mewos silently!"
	cooldown = 0.7 SECONDS

/datum/emote/living/ara_ara
	key = "ara"
	key_third_person = "aras"
	message = "coos with sultry surprise~..."
	message_mime = "exudes a sultry aura~"
	sound = 'modular_zzplurt/sound/voice/ara-ara.ogg'
	cooldown = 1.25 SECONDS

/datum/emote/living/ara_ara/alt
	key = "ara2"
	sound = 'modular_zzplurt/sound/voice/ara-ara2.ogg'
	cooldown = 1.25 SECONDS

/datum/emote/living/meow2/get_sound(mob/living/user)
	. = ..()
	return  pick('modular_zzplurt/sound/voice/catpeople/cat_meow1.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_meow2.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_meow3.ogg')


/datum/emote/living/meow2
	key = "meow2"
	key_third_person = "meows"
	message = "meows!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_meow1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/meow2/get_sound(mob/living/user)
	. = ..()
	return pick('modular_zzplurt/sound/voice/catpeople/cat_mew1.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_mew2.ogg')

/datum/emote/living/meow3
	key = "meow3"
	key_third_person = "mews!"
	message = "mews!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mew1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/mrrp
	key = "mrrp"
	key_third_person = "mrrps"
	message = "trills like a cat!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mrrp1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/mrrp2
	key = "mrrp2"
	key_third_person = "mrrps"
	message = "trills like a cat!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mrrp2.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

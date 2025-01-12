/mob/living/carbon/human/adjust_pain(change_amount, mob/living/carbon/human/partner, datum/interaction/interaction, position)
	var/old_pain = pain
	. = ..()
	if(pain > old_pain)
		if(client?.prefs?.read_preference(/datum/preference/toggle/erp/autoemote))
			//HSECTOR EDIT ADDITION BEGIN - moan selection
			var/moan_type
			if(isnull(selected_moan) || !(LAZYLEN(selected_moan.male_moansounds) && LAZYLEN(selected_moan.female_moansounds))) //For things that don't have a selected scream(npcs)
				moan_type = gender
			var/voice_type = client.prefs.read_preference(/datum/preference/choiced/voice_type)
			if(voice_type == "Based on Gender")
				moan_type = gender
			else if((voice_type == "Male") || isnull(selected_moan.female_moansounds))
				moan_type = MALE
			else
				moan_type = FEMALE
			//HSECTOR EDIT ADDITION END
			if(moan_type == FEMALE)
				playsound(src, pick('modular_zzplurt/sound/voice/painmoanf (1).ogg',
								'modular_zzplurt/sound/voice/painmoanf (2).ogg',
								'modular_zzplurt/sound/voice/painmoanf (3).ogg',
								'modular_zzplurt/sound/voice/painmoanf (4).ogg',
								'modular_zzplurt/sound/voice/painmoanf (5).ogg',
								'modular_zzplurt/sound/voice/painmoanf (6).ogg',
								'modular_zzplurt/sound/voice/painmoanf (7).ogg',
								'modular_zzplurt/sound/voice/painmoanf (8).ogg'))
			else
				playsound(src, pick('modular_zzplurt/sound/voice/painmoanm (1).ogg',
								'modular_zzplurt/sound/voice/painmoanm (2).ogg',
								'modular_zzplurt/sound/voice/painmoanm (3).ogg',
								'modular_zzplurt/sound/voice/painmoanm (4).ogg',
								'modular_zzplurt/sound/voice/painmoanm (5).ogg'))

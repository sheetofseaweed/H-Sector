//Underwear and extra slots
/// Right ear slot
#define ITEM_SLOT_EARS_RIGHT (1<<20) // It can't use extra because it's linked to ITEM_SLOT_EARS_LEFT
/// Slot to indicate it's an extra slot
#define ITEM_SLOT_EXTRA (1<<23) //this will work until TG decides to use this value for a slot for some reason
/// Underwear slot
#define ITEM_SLOT_UNDERWEAR ITEM_SLOT_EXTRA | (1<<0)
/// Socks slot
#define ITEM_SLOT_SOCKS ITEM_SLOT_EXTRA | (1<<1)
/// Shirt slot
#define ITEM_SLOT_SHIRT ITEM_SLOT_EXTRA | (1<<2)
/// Bra slot
#define ITEM_SLOT_BRA ITEM_SLOT_EXTRA | (1<<3)
/// Wrist slot
#define ITEM_SLOT_WRISTS ITEM_SLOT_EXTRA | (1<<4)
/// Penis slot
#define ITEM_SLOT_PENIS ITEM_SLOT_EXTRA | (1<<5)//hsector edit start
/// Vagina slot
#define ITEM_SLOT_VAGINA ITEM_SLOT_EXTRA | (1<<6)
/// Anus slot
#define ITEM_SLOT_ANUS ITEM_SLOT_EXTRA | (1<<7)
/// Nipples slot
#define ITEM_SLOT_NIPPLES ITEM_SLOT_EXTRA | (1<<8)
/// Mouth slot
#define ITEM_SLOT_MOUTH ITEM_SLOT_EXTRA | (1<<9)
/// Crotch slot
#define ITEM_SLOT_CROTCH ITEM_SLOT_EXTRA | (1<<10)//hsector edit end

/datum/bitfield/no_equip_flags/New()
	var/list/extra_flags = list(
		"BRIEFS" = ITEM_SLOT_UNDERWEAR,
		"SOCKS" = ITEM_SLOT_SOCKS,
		"SHIRT" = ITEM_SLOT_SHIRT,
		"BRA" = ITEM_SLOT_BRA,
		"EARPIECES_R" = ITEM_SLOT_EARS_RIGHT,
		"WRISTS" = ITEM_SLOT_WRISTS,
		"PENIS_ACC" = ITEM_SLOT_PENIS,//hsector edit start
		"VAGINA_ACC" = ITEM_SLOT_VAGINA,
		"ANUS_ACC" = ITEM_SLOT_ANUS,
		"NIP_ACC" = ITEM_SLOT_NIPPLES,
		"MOUTH_ACC" = ITEM_SLOT_MOUTH,
		"CROTCH_ACC" = ITEM_SLOT_CROTCH,//hsector edit end
	)
	flags += extra_flags
	. = ..()

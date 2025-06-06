///Bodypart ovarlay datum. These can be added to any limb to give them a proper overlay, that'll even stay if the limb gets removed
///This is the abstract parent, don't use it!!
/datum/bodypart_overlay
	///Sometimes we need multiple layers, for like the back, middle and front of the person (EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND)
	var/layers
	///List of all possible layers. Used for looping through in drawing
	var/static/list/all_layers = list(EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND, EXTERNAL_FRONT_UNDER_CLOTHES, EXTERNAL_FRONT_OVER, EXTERNAL_FRONT_ABOVE_HAIR, EXTERNAL_BODY_LAYER, EXTERNAL_BOOB_LAYER) // SKYRAT EDIT - Customization - ORIGINAL: var/static/list/all_layers = list(EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND) h-sector: + EXTERNAL_BODY_LAYER, EXTERNAL_BOOB_LAYER

	///Key of the icon states of all the sprite_datums for easy caching
	var/cache_key = ""

	/// Whether the overlay blocks emissive light
	var/blocks_emissive = EMISSIVE_BLOCK_UNIQUE

///Wrapper for getting the proper image, colored and everything
/datum/bodypart_overlay/proc/get_overlay(layer, obj/item/bodypart/limb)
	layer = bitflag_to_layer(layer)
	var/image/main_image = get_image(layer, limb)
	color_image(main_image, layer, limb)
	if(blocks_emissive == EMISSIVE_BLOCK_NONE || !limb)
		return main_image

	var/list/all_images = list(
		main_image,
		emissive_blocker(main_image.icon, main_image.icon_state, limb, layer = main_image.layer, alpha = main_image.alpha)
	)
	return all_images

///Generate the image. Needs to be overridden
/datum/bodypart_overlay/proc/get_image(layer, obj/item/bodypart/limb)
	CRASH("Get image needs to be overridden")

///Color the image
/datum/bodypart_overlay/proc/color_image(image/overlay, layer, obj/item/bodypart/limb)
	return

///Called on being added to a limb
/datum/bodypart_overlay/proc/added_to_limb(obj/item/bodypart/limb)
	return

///Called on being removed from a limb
/datum/bodypart_overlay/proc/removed_from_limb(obj/item/bodypart/limb)
	return

///Use this to change the appearance (and yes you must overwrite hahahahahah) (or don't use this, I just don't want people directly changing the image)
/datum/bodypart_overlay/proc/set_appearance()
	CRASH("Update appearance needs to be overridden")

/**This exists so sprite accessories can still be per-layer without having to include that layer's
*  number in their sprite name, which causes issues when those numbers change.
*/
/datum/bodypart_overlay/proc/mutant_bodyparts_layertext(layer)
	switch(layer)
		if(-BODY_BEHIND_LAYER)
			return "BEHIND"
		if(-BODY_ADJ_LAYER)
			return "ADJ"
		if(-BODY_FRONT_LAYER)
			return "FRONT"
		//SKYRAT EDIT ADDITION - Customization
		if(-BODY_FRONT_UNDER_CLOTHES)
			return "FRONT_UNDER"
		if(-ABOVE_BODY_FRONT_HEAD_LAYER)
			return "FRONT_OVER"
		if(-HEAD_LAYER)
			return "FRONT_OVER_HAIR"
		//SKYRAT EDIT ADDITION END
		//h-sector - hack
		if(-BREAST_LAYER)
			return "FRONT"
		if(-BODYPARTS_LAYER)
			return "FRONT"

///Converts a bitflag to the right layer. I'd love to make this a static index list, but byond made an attempt on my life when i did
/datum/bodypart_overlay/proc/bitflag_to_layer(layer)
	switch(layer)
		if(EXTERNAL_BEHIND)
			return -BODY_BEHIND_LAYER
		if(EXTERNAL_ADJACENT)
			return -BODY_ADJ_LAYER
		if(EXTERNAL_FRONT)
			return -BODY_FRONT_LAYER
		//SKYRAT EDIT ADDITION - Customization
		if(EXTERNAL_FRONT_UNDER_CLOTHES)
			return -BODY_FRONT_UNDER_CLOTHES
		if(EXTERNAL_FRONT_OVER)
			return -ABOVE_BODY_FRONT_HEAD_LAYER
		if(EXTERNAL_FRONT_ABOVE_HAIR)
			return -HEAD_LAYER
		//SKYRAT EDIT ADDITION END
		//h-sector
		if(EXTERNAL_BOOB_LAYER)
			return -BREAST_LAYER
		if(EXTERNAL_BODY_LAYER)
			return -BODYPARTS_LAYER

///Check whether we can draw the overlays. You generally don't want lizard snouts to draw over an EVA suit
/datum/bodypart_overlay/proc/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	return TRUE

///Colorizes the limb it's inserted to, if required.
/datum/bodypart_overlay/proc/override_color(obj/item/bodypart/bodypart_owner)
	CRASH("External organ color set to override with no override proc.")

///Generate a unique identifier to cache with. If you change something about the image, but the icon cache stays the same, it'll simply pull the unchanged image out of the cache
/datum/bodypart_overlay/proc/generate_icon_cache()
	return list()

/// Additionally color or texture the limb
/datum/bodypart_overlay/proc/modify_bodypart_appearance(datum/appearance)
	return

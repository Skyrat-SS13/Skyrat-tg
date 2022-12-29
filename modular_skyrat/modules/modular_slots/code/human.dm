/mob/living/carbon/human
	// The actual slot.
	/// The passport the human has in their passport slot.
	var/obj/item/passport

// Clean up your slots when a human mob is destroyed here.
/mob/living/carbon/human/Destroy()
	. = ..()
	if(passport)
		QDEL_NULL(passport)

// Copy and modify for your own slot. Make sure to do the same for the stub proc in mob.dm.
/mob/living/carbon/human/update_worn_passport()
	remove_overlay(PASSPORT_LAYER)

	if(hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_PASSPORT) + 1]
		inv.update_icon()

	var/mutable_appearance/id_overlay = overlays_standing[PASSPORT_LAYER]

	if(passport)
		var/obj/item/worn_item = passport
		update_hud_passport(worn_item)
		var/icon_file

		if(!icon_exists(icon_file, (worn_item.worn_icon_state || worn_item.icon_state)))
			icon_file = 'icons/mob/simple/mob.dmi'

		id_overlay = passport.build_worn_icon(default_layer = PASSPORT_LAYER, default_icon_file = icon_file)

		if(!id_overlay)
			return
		if(OFFSET_PASSPORT in dna.species.offset_features)
			id_overlay.pixel_x += dna.species.offset_features[OFFSET_PASSPORT][1]
			id_overlay.pixel_y += dna.species.offset_features[OFFSET_PASSPORT][2]
		overlays_standing[PASSPORT_LAYER] = id_overlay
		update_worn_id()

	apply_overlay(PASSPORT_LAYER)

// Copy and modify for your own slot.
/// Updates the current state of the passport item slot, showing the passport item if one is equipped.
/mob/living/carbon/human/proc/update_hud_passport(obj/item/worn_item)
	worn_item.screen_loc = ui_passport
	if((client && hud_used?.hud_shown))
		client.screen += worn_item
	update_observer_view(worn_item)

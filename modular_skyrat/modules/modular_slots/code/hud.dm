// Adds the new HUD icon.
/datum/hud/human/New(mob/living/carbon/human/owner)
	// For item slots, copy the next eight lines, and change it to be your desired slot.
	// Note: If you want custom icons for your slot, you will need to create an icon for each theme, and dynamically set it per slot. Good luck.
	var/atom/movable/screen/inventory/inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "passport"
	inv_box.icon = ui_style2icon(owner.client?.prefs?.read_preference(/datum/preference/choiced/ui_style))
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_passport
	inv_box.slot_id = ITEM_SLOT_PASSPORT
	inv_box.hud = src
	toggleable_inventory += inv_box

	return ..()

// Does this UI element have contents? Update that icon! Includes a couple checks to save cycles.
// For slots that CAN be hidden via the backpack button, or similar.
/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	. = ..()

	var/mob/living/carbon/human/human = mymob

	if(!human.passport || !human.client)
		return

	var/mob/screenmob = viewer || human

	// For item slots, Copy the contents of the if and else, and edit for your own needs.
	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		human.passport.screen_loc = ui_passport
		screenmob.client.screen += human.passport
		// Example:
		// human.ring.screen_loc = ui_ring
		// screenmob.client.screen += human.ring
	else
		screenmob.client.screen -= human.passport
		// Example:
		// screenmob.client.screen -= human.ring

// Does this UI element have contents? Update that icon! Includes a couple checks to save cycles.
// For slots that CAN'T be hidden via the backpack button, or similar.
/* Uncomment if ever used.
/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	. = ..()

	var/mob/living/carbon/human/human = mymob
	var/mob/screenmob = viewer || human

	if(!screenmob.hud_used || !screenmob.client)
		return

	if(screenmob.hud_used.inventory_shown)
		// Same here as hidden_inventory_update.
	else
		screenmob.client.screen -= human.passport
		// Same here as hidden_inventory_update.
*/

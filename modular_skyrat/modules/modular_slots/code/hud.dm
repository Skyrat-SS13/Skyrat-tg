// Modular slots UI code.
/datum/hud/human/New(mob/living/carbon/human/owner)
	var/atom/movable/screen/inventory/inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "passport"
	inv_box.icon = ui_style2icon(owner.client?.prefs?.read_preference(/datum/preference/choiced/ui_style))
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_passport
	inv_box.slot_id = ITEM_SLOT_PASSPORT
	inv_box.hud = src
	static_inventory += inv_box

	return ..()

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	. = ..()

	var/mob/living/carbon/human/human = mymob

	if(!human.passport)
		return

	var/mob/screenmob = viewer || human

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		human.passport.screen_loc = ui_passport
		screenmob.client.screen += human.passport
	else
		screenmob.client.screen -= human.passport

/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	. = ..()

	var/mob/living/carbon/human/human = mymob
	var/mob/screenmob = viewer || human

	if(!human.passport || !screenmob.hud_used)
		return

	if(screenmob.hud_used.inventory_shown)
		human.passport.screen_loc = ui_passport
		screenmob.client.screen += human.passport
	else
		screenmob.client.screen -= human.passport

/mob/living/carbon/human/proc/update_hud_passport(obj/item/worn_item)
	worn_item.screen_loc = ui_passport
	if((client && hud_used?.hud_shown))
		client.screen += worn_item
	update_observer_view(worn_item)

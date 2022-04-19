/atom/movable/screen/human
	icon = 'icons/hud/screen_midnight.dmi'

/atom/movable/screen/human/toggle
	name = "toggle"
	icon_state = "toggle"

/atom/movable/screen/human/toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.toggleable_inventory

	//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		for (var/atom/movable/screen/human/using in targetmob.hud_used.static_inventory)
			if(using.screen_loc == ui_erp_inventory)
				using.screen_loc = ui_erp_inventory_up // Move up ERP inventory button
		for (var/atom/movable/screen/inventory/inv in targetmob.hud_used.erp_toggleable_inventory)
			// Move up ERP hud slots
			if(inv.screen_loc == ui_vagina_down)
				inv.screen_loc = ui_vagina
			if(inv.screen_loc == ui_anus_down)
				inv.screen_loc = ui_anus
			if(inv.screen_loc == ui_nipples_down)
				inv.screen_loc = ui_nipples
			if(inv.screen_loc == ui_penis_down)
				inv.screen_loc = ui_penis
	else
		for (var/atom/movable/screen/human/using in targetmob.hud_used.static_inventory)
			if(using.screen_loc == ui_erp_inventory_up)
				using.screen_loc = ui_erp_inventory // Move down ERP inventory button
		for (var/atom/movable/screen/inventory/inv in targetmob.hud_used.erp_toggleable_inventory)
			// Move up ERP hud slots
			if(inv.screen_loc == ui_vagina)
				inv.screen_loc = ui_vagina_down
			if(inv.screen_loc == ui_anus)
				inv.screen_loc = ui_anus_down
			if(inv.screen_loc == ui_nipples)
				inv.screen_loc = ui_nipples_down
			if(inv.screen_loc == ui_penis)
				inv.screen_loc = ui_penis_down
	//SKYRAT EDIT ADDITION END

	targetmob.hud_used.hidden_inventory_update(usr)

/atom/movable/screen/human/equip
	name = "equip"
	icon_state = "act_equip"

/atom/movable/screen/human/equip/Click()
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return TRUE
	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/atom/movable/screen/ling
	icon = 'icons/hud/screen_changeling.dmi'

/atom/movable/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

/atom/movable/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling/sting/Click()
	if(isobserver(usr))
		return
	var/mob/living/carbon/carbon_user = usr
	carbon_user.unset_sting()

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/navigate
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	action_intent = new /atom/movable/screen/combattoggle/flashy()
	action_intent.hud = src
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent


	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "i_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_ICLOTHING
	inv_box.icon_state = "uniform"
	inv_box.screen_loc = ui_iclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "o_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_OCLOTHING
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_oclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "storage1"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "storage2"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	inv_box.hud = src
	static_inventory += inv_box

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_above_intent
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
	using = new /atom/movable/screen/human/erp_toggle()
	using.icon = ui_style
	using.screen_loc = ui_erp_inventory
	using.hud = src
	// When creating a character, we will check if the ERP is enabled on the client, if not, then the ERP button is immediately invisible
	if(!owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		using.invisibility = 100
	static_inventory += using
	//SKYRAT EDIT ADDITION END

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_EARS
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
// inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.hud = src
	static_inventory += inv_box

	//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "vagina"
	inv_box.icon = erp_ui_style
	inv_box.icon_state = "vagina"
	inv_box.screen_loc = ui_vagina_down
	inv_box.slot_id = ITEM_SLOT_VAGINA
	inv_box.hud = src
	erp_toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "anus"
	inv_box.icon = erp_ui_style
	inv_box.icon_state = "anus"
	inv_box.screen_loc = ui_anus_down
	inv_box.slot_id = ITEM_SLOT_ANUS
	inv_box.hud = src
	erp_toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "nipples"
	inv_box.icon = erp_ui_style
	inv_box.icon_state = "nipples"
	inv_box.screen_loc = ui_nipples_down
	inv_box.slot_id = ITEM_SLOT_NIPPLES
	inv_box.hud = src
	erp_toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "penis"
	inv_box.icon = erp_ui_style
	inv_box.icon_state = "penis"
	inv_box.screen_loc = ui_penis_down
	inv_box.slot_id = ITEM_SLOT_PENIS
	inv_box.hud = src
	erp_toggleable_inventory += inv_box
	//SKYRAT EDIT ADDITION END

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest()
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_above_movement
	rest_icon.hud = src
	static_inventory += rest_icon

	internals = new /atom/movable/screen/internals()
	internals.hud = src
	infodisplay += internals

	spacesuit = new /atom/movable/screen/spacesuit
	spacesuit.hud = src
	infodisplay += spacesuit

	healths = new /atom/movable/screen/healths()
	healths.hud = src
	infodisplay += healths

	healthdoll = new /atom/movable/screen/healthdoll()
	healthdoll.hud = src
	infodisplay += healthdoll

	stamina = new /atom/movable/screen/stamina()
	stamina.hud = src
	infodisplay += stamina

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_appearance()
	pull_icon.screen_loc = ui_above_intent
	pull_icon.hud = src
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	combo_display = new /atom/movable/screen/combo()
	infodisplay += combo_display

	//SKYRAT EDIT ADDITION
	ammo_counter = new /atom/movable/screen/ammo_counter()
	ammo_counter.hud = src
	infodisplay += ammo_counter
	//SKYRAT EDIT END

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		if(H.shoes) screenmob.client.screen -= H.shoes
		if(H.gloves) screenmob.client.screen -= H.gloves
		if(H.ears) screenmob.client.screen -= H.ears
		if(H.glasses) screenmob.client.screen -= H.glasses
		if(H.w_uniform) screenmob.client.screen -= H.w_uniform
		if(H.wear_suit) screenmob.client.screen -= H.wear_suit
		if(H.wear_mask) screenmob.client.screen -= H.wear_mask
		if(H.wear_neck) screenmob.client.screen -= H.wear_neck
		if(H.head) screenmob.client.screen -= H.head

	//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
	if(screenmob.hud_used.ERP_inventory_shown && screenmob.hud_used.hud_shown && H.client.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		if(H.vagina)
			// This shity code need for hanlde an moving UI stuff when default inventory expand/collapse
			if(screenmob.hud_used.inventory_shown && screenmob.hud_used)
				H.vagina.screen_loc = ui_vagina
			else
				H.vagina.screen_loc = ui_vagina_down
			screenmob.client.screen += H.vagina
		if(H.anus)
			if(screenmob.hud_used.inventory_shown && screenmob.hud_used)
				H.anus.screen_loc = ui_anus
			else
				H.anus.screen_loc = ui_anus_down
			screenmob.client.screen += H.anus
		if(H.nipples)
			if(screenmob.hud_used.inventory_shown && screenmob.hud_used)
				H.nipples.screen_loc = ui_nipples
			else
				H.nipples.screen_loc = ui_nipples_down
			screenmob.client.screen += H.nipples
		if(H.penis)
			if(screenmob.hud_used.inventory_shown && screenmob.hud_used)
				H.penis.screen_loc = ui_penis
			else
				H.penis.screen_loc = ui_penis_down
			screenmob.client.screen += H.penis
	else
		if(H.vagina) screenmob.client.screen -= H.vagina
		if(H.anus) screenmob.client.screen -= H.anus
		if(H.nipples) screenmob.client.screen -= H.nipples
		if(H.penis) screenmob.client.screen -= H.penis
	//SKYRAT EDIT ADDITION END



/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store

			//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
			if(H.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
				if(H.vagina)
					H.vagina.screen_loc = ui_vagina
					screenmob.client.screen += H.vagina
				if(H.anus)
					H.anus.screen_loc = ui_anus
					screenmob.client.screen += H.anus
				if(H.nipples)
					H.nipples.screen_loc = ui_nipples
					screenmob.client.screen += H.nipples
				if(H.penis)
					H.penis.screen_loc = ui_penis
					screenmob.client.screen += H.penis
			//SKYRAT EDIT ADDITION END

		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

			//SKYRAT EDIT ADDITION BEGIN - ERP_SLOT_SYSTEM
			if(H.vagina)
				screenmob.client.screen -= H.vagina
			if(H.anus)
				screenmob.client.screen -= H.anus
			if(H.nipples)
				screenmob.client.screen -= H.nipples
			if(H.penis)
				screenmob.client.screen -= H.penis
			//SKYRAT EDIT ADDITION END

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE

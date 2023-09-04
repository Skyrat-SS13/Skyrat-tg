/obj/item/disk/nifsoft_uploader/scryer
	name = "NIFSoft Scryer Uploader Disk"
	loaded_nifsoft = /datum/nifsoft/scryer

/datum/nifsoft/scryer
	name = "NIFLink Holocaller"
	program_desc = "This ubiquitous NIFSoft adds Scryer functionality similar to MODSuits to the user's NIF; allowing for real-time communication through AR hologlass screens from a hardlight projector sat around the wearer's neck"
	active_mode = TRUE
	active_cost = 1
	activation_cost = 20
	purchase_price = 200
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "video"
	/// What is the scryer currently associated with the NIFSoft?
	var/obj/item/clothing/neck/link_scryer/loaded/nifsoft/linked_scyer

/datum/nifsoft/scryer/New()
	. = ..()
	linked_scyer = new (parent_nif.resolve())
	linked_scyer.parent_nifsoft = WEAKREF(src)
	linked_scyer.label = linked_mob.name

/datum/nifsoft/scryer/Destroy()
	if(linked_scyer)
		qdel(linked_scyer)
		linked_scyer = null

	return ..()

/datum/nifsoft/scryer/activate()
	. = ..()
	if(. == FALSE)
		return FALSE

	if(!active)
		if(linked_scyer)
			linked_mob.transferItemToLoc(linked_scyer, parent_nif.resolve(), TRUE)
		return TRUE

	if(linked_mob.handcuffed)
		linked_mob.balloon_alert(linked_mob, "handcuffed")
		activate()
		return FALSE

	if(!linked_mob.equip_to_slot_if_possible(linked_scyer, ITEM_SLOT_NECK)) //This sends out a message to the mob if it can't be put on.
		activate()
		return FALSE

	return TRUE

/obj/item/clothing/neck/link_scryer
	/// Do we have custom controls? This is only affects the text shown when examining
	var/custom_examine_controls = FALSE

/obj/item/clothing/neck/link_scryer/loaded/nifsoft
	name = "\improper NIFLink Holocaller"
	desc = "A nanomachine construct working as a modified version of the MODlink scryer, conjured using a NIF; functionally the same, but able to carry out holocalls in a more portable format."
	custom_examine_controls = TRUE
	/// A weakref of the parent NIFSoft that the scryer belongs to.
	var/datum/weakref/parent_nifsoft

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/Initialize(mapload)
	. = ..()
	if(cell)
		qdel(cell)
		cell = null

	cell = new /obj/item/stock_parts/cell/infinite/nif_cell(src)

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/examine(mob/user)
	. = ..()
	. += span_notice("The MODlink ID is [mod_link.id], frequency is [mod_link.frequency || "unset"]. <b>Right-click</b> with multitool to copy/imprint frequency.")
	. += span_notice("<b>Right-click</b> with an empty hand to change the name.")

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/equipped(mob/living/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_NECK)
		return TRUE

	var/datum/nifsoft/scryer/scryer_nifsoft = parent_nifsoft.resolve()
	if(!istype(scryer_nifsoft))
		return FALSE

	scryer_nifsoft.activate() //If it's not on the neck, it shouldn't be active.
	return TRUE

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/screwdriver_act(mob/living/user, obj/item/tool)
	balloon_alert(user, "cell non-removable")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/neck/link_scryer/loaded/nifsoft/attack_hand_secondary(mob/user, list/modifiers)
	var/new_label = reject_bad_text(tgui_input_text(user, "Change the visible name", "Set Name", label, MAX_NAME_LEN))
	if(!new_label)
		balloon_alert(user, "invalid name!")
		return
	label = new_label
	balloon_alert(user, "name set")
	update_name()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// This cell is only meant for use in items temporarily created by a NIF. Do not let players extract this from devices.
/obj/item/stock_parts/cell/infinite/nif_cell
	name = "Nanite Cell"
	desc = "If you see this, please make an issue on GitHub."


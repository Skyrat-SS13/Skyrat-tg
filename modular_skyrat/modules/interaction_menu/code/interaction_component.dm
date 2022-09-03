
/datum/component/interactable
	/// A hard reference to the parent
	var/mob/living/carbon/human/self = null
	/// A list of interactions that the user can engage in.
	var/list/datum/interaction/interactions
	var/interact_last = 0
	var/interact_next = 0

/datum/component/interactable/Initialize(...)
	if(QDELETED(parent))
		qdel(src)
		return

	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	self = parent

	build_interactions_list()

/datum/component/interactable/proc/build_interactions_list()
	interactions = list()
	for(var/iterating_interaction_id in GLOB.interaction_instances)
		var/datum/interaction/interaction = GLOB.interaction_instances[iterating_interaction_id]
		if(interaction.lewd)
			if(!self.client?.prefs?.read_preference(/datum/preference/toggle/erp))
				continue
			if(interaction.sexuality != "" && interaction.sexuality != self.client?.prefs?.read_preference(/datum/preference/choiced/erp_sexuality))
				continue
		interactions.Add(interaction)

/datum/component/interactable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, .proc/open_interaction_menu)

/datum/component/interactable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)

/datum/component/interactable/Destroy(force, silent)
	self = null
	interactions = null
	return ..()

/datum/component/interactable/proc/open_interaction_menu(datum/source, mob/user)
	if(!ishuman(user))
		return
	build_interactions_list()
	ui_interact(user)

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/living/carbon/human/target)
	if(!interaction.allow_act(target, self))
		return FALSE
	if(interaction.lewd && !target.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE
	if(!interaction.distance_allowed && !target.Adjacent(self))
		return FALSE
	if(interaction.category == INTERACTION_CAT_HIDE)
		return FALSE
	if(self == target && interaction.usage == INTERACTION_OTHER)
		return FALSE
	return TRUE

/// UI Control
/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InteractionMenu")
		ui.open()

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE // This UI is always interactive as we handle distance flags via can_interact

/datum/component/interactable/ui_data(mob/user)
	var/list/data = list()
	var/list/descriptions = list()
	var/list/categories = list()
	var/list/colors = list()
	for(var/datum/interaction/interaction in interactions)
		if(!can_interact(interaction, user))
			continue
		if(!categories[interaction.category])
			categories[interaction.category] = list(interaction.name)
		else
			categories[interaction.category] += interaction.name
		descriptions[interaction.name] = interaction.description
		colors[interaction.name] = interaction.color
	data["categories"] = list()
	data["descriptions"] = descriptions
	data["colors"] = colors
	for(var/category in categories)
		data["categories"] += category
	data["ref_user"] = REF(user)
	data["ref_self"] = REF(self)
	data["self"] = self.name
	data["block_interact"] = interact_next >= world.time
	data["interactions"] = categories

	var/list/parts = list()

	if(ishuman(user) && can_lewd_strip(user, self))
		if(self.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			if(self.has_vagina())
				parts += list(list("name" = NAME_VAGINA, "img" = self.vagina? icon2base64(icon(self.vagina.icon, self.vagina.icon_state, SOUTH, 1)) : null))
			if(self.has_penis())
				parts += list(list("name" = NAME_PENIS, "img" = self.penis? icon2base64(icon(self.penis.icon, self.penis.icon_state, SOUTH, 1)) : null))
			if(self.has_anus())
				parts += list(list("name" = NAME_ANUS, "img" = self.anus? icon2base64(icon(self.anus.icon, self.anus.icon_state, SOUTH, 1)) : null))
			parts += list(list("name" = NAME_NIPPLES, "img" = self.nipples? icon2base64(icon(self.nipples.icon, self.nipples.icon_state, SOUTH, 1)) : null))

	data["lewd_slots"] = parts

	return data

/datum/component/interactable/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	if(params["interaction"])
		var/interaction_id = params["interaction"]
		if(GLOB.interaction_instances[interaction_id])
			var/mob/living/carbon/human/user = locate(params["userref"])
			if(!can_interact(GLOB.interaction_instances[interaction_id], user))
				return FALSE
			GLOB.interaction_instances[interaction_id].act(user, locate(params["selfref"]))
			var/datum/component/interactable/interaction_component = user.GetComponent(/datum/component/interactable)
			interaction_component.interact_last = world.time
			interact_next = interaction_component.interact_last + INTERACTION_COOLDOWN
			interaction_component.interact_next = interact_next
			return TRUE
	if(params["slot"]) // TODO: More detailed warnings and messages
		var/lewd_item_index = params["slot"]
		var/mob/living/carbon/human/source = locate(params["userref"])
		var/mob/living/carbon/human/target = locate(params["selfref"])
		var/obj/item/new_item = source.get_active_held_item()
		var/obj/item/existing_item = target.vars[lewd_item_index]

		if(!existing_item && !new_item)
			source.show_message(span_warning("No item to insert or remove!"))
			return

		if(!existing_item && !istype(new_item, /obj/item/clothing/sextoy))
			source.show_message(span_warning("The item you're holding is not a toy!"))
			return

		if(can_lewd_strip(source, target, lewd_item_index) && can_insert(new_item, lewd_item_index))
			var/internal = (lewd_item_index in list(NAME_VAGINA, NAME_ANUS))
			var/insert_or_attach = internal ? "insert" : "attach"
			var/into_or_onto = internal ? "into" : "onto"

			if(existing_item)
				source.visible_message(span_purple("[source.name] starts trying to remove something from [target.name]'s [lewd_item_index]."), span_purple("You start to remove [existing_item.name] from [target.name]'s [lewd_item_index]."), span_purple("You hear someone trying to remove something from someone nearby."), vision_distance = 1, ignored_mobs = list(target))
			else if (new_item)
				source.visible_message(span_purple("[source.name] starts trying to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [lewd_item_index]."), span_purple("You start to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [lewd_item_index]."), span_purple("You hear someone trying to [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1, ignored_mobs = list(target))
			if (source != target)
				target.show_message(span_warning("[source.name] is trying to [existing_item ? "remove the [existing_item.name] [internal ? "in" : "on"]" : new_item ? "is trying to [insert_or_attach] the [new_item.name] [into_or_onto]" : span_alert("What the fuck, impossible condition? interaction_component.dm!")] your [lewd_item_index]!"))
			if(do_after(
				source,
				5 SECONDS,
				target,
				interaction_key = "interation_[lewd_item_index]"
				) && can_lewd_strip(source, target, lewd_item_index))
				if(existing_item)
					source.visible_message(span_purple("[source.name] removes [existing_item.name] from [target.name]'s [lewd_item_index]."), span_purple("You remove [existing_item.name] from [target.name]'s [lewd_item_index]."), span_purple("You hear someone remove something from someone nearby."), vision_distance = 1)
					target.dropItemToGround(existing_item, force = TRUE) // Force is true, cause nodrop shouldn't affect lewd items.
					target.vars[lewd_item_index] = null
					target.update_inv_vagina()
					target.update_inv_penis()
					target.update_inv_anus()
					target.update_inv_nipples()
				else if (new_item)
					source.visible_message(span_purple("[source.name] [internal ? "inserts" : "attaches"] the [new_item.name] [into_or_onto] [target.name]'s [lewd_item_index]."), span_purple("You [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [lewd_item_index]."), span_purple("You hear someone [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1)
					target.vars[lewd_item_index] = new_item
					new_item.forceMove(target)
					target.update_inv_vagina()
					target.update_inv_penis()
					target.update_inv_anus()
					target.update_inv_nipples()

		else
			source.show_message(span_warning("Failed to adjust [target.name]'s toys!"))

		return TRUE

	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")

/datum/component/interactable/proc/can_lewd_strip(mob/living/carbon/human/user, mob/living/carbon/human/other_user, slot_index)
	if(!other_user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return FALSE
	if(!(user.loc == other_user.loc || user.Adjacent(other_user)))
		return FALSE
	if(!user.has_arms())
		return FALSE
	if(!slot_index) // Logic for displaying the icons in the first place.
		return TRUE
	if(slot_index == "slot_nipples" && !other_user.is_topless())
		return FALSE
	return other_user.is_bottomless()

// Used to decide if a player should be able to insert or remove an item from a provided slot.
/datum/component/interactable/proc/can_insert(obj/item/clothing/sextoy/item, slot_index)
	if(!item)
		return TRUE
	switch(slot_index)
		if(NAME_VAGINA)
			return item.lewd_slot_flags & LEWD_SLOT_VAGINA
		if(NAME_PENIS)
			return item.lewd_slot_flags & LEWD_SLOT_PENIS
		if(NAME_ANUS)
			return item.lewd_slot_flags & LEWD_SLOT_ANUS
		if(NAME_NIPPLES)
			return item.lewd_slot_flags & LEWD_SLOT_NIPPLES
		else
			return FALSE // Just in case.

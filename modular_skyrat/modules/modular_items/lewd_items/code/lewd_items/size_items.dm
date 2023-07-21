/// What areas are we allowed to use size items in?
#define SIZE_WHITELISTED_AREAS list(\
		/area/centcom/interlink/dorm_rooms,\
		/area/centcom/holding/cafedorms,\
		/area/misc/hilbertshotel,\
)

/obj/item/clothing/neck/size_collar
	name = "size collar"
	desc = "A shiny black collar embeded with technology that allows the user to change their own size."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_black"
	/// Have we given the user the warning message yet?
	var/warning_given = FALSE
	/// The `temporary_size` component we have attached to the wearer.
	var/datum/component/temporary_size/size_component
	/// What size do we want to set the wearer to when they wear the collar?
	var/target_size = 1

/obj/item/clothing/neck/size_collar/attack_self(mob/user, modifiers)
	. = ..()
	if(!warning_given)
		if(tgui_alert(user, "This item is strictly intended as an ERP item for use in dorm rooms. Failure to respect this will result in administrative action being taken. Do you wish to continue using this item?", "A word of warning.", list("Yes", "No")) != "Yes")
			return FALSE

		warning_given = TRUE

	var/chosen_size = tgui_input_number(user, "What size percentage do you wish to set the collar to?", name, 100, CONFIG_GET(number/size_collar_maximum), CONFIG_GET(number/size_collar_minimum))
	if(!chosen_size)
		balloon_alert(user, "invalid size!")
		return FALSE

	log_message("[src] had its target size changed to [chosen_size]% by [usr]", LOG_ATTACK)
	balloon_alert(user, "set to [chosen_size]%")
	target_size = (chosen_size * 0.01)
	return TRUE

/obj/item/clothing/neck/size_collar/mob_can_equip(mob/living/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!warning_given)
		return FALSE

	return ..()

/obj/item/clothing/neck/size_collar/equipped(mob/living/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot & ITEM_SLOT_NECK))
		return FALSE

	size_component = user.AddComponent(/datum/component/temporary_size, target_size)
	size_component.target_size = target_size

	user.log_message("[src] was equipped by [user].", LOG_ATTACK)

/obj/item/clothing/neck/size_collar/dropped(mob/living/user)
	. = ..()
	if(size_component)
		qdel(size_component)
		size_component = null

/obj/item/clothing/neck/size_collar/examine(mob/user)
	. = ..()
	var/list/area_names = list()
	for(var/area_index in SIZE_WHITELISTED_AREAS) //We can't do this typed.
		var/area/area_type = area_index //So we have to assign it to a typed variable after we get it from the loop.
		var/area_name = initial(area_type.name)
		if(!area_name)
			continue

		area_names += area_name

	if(length(area_names))
		. += span_cyan("This collar will work in the following areas: [english_list(area_names)]")

	return .

/// Component that temporarily applies a size to a human.
/datum/component/temporary_size
	/// List containing the areas that the size change works in. If this is empty, this will work everywhere.
	var/list/allowed_areas = SIZE_WHITELISTED_AREAS
	/// What is the stored size of the mob using this?
	var/original_size = 1
	/// What size are we changing the parent mob to?
	var/target_size = 1

/datum/component/temporary_size/Initialize(size_to_apply)
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/human_parent = parent
	original_size = human_parent?.dna.features["body_size"]

	if(!original_size) //If we aren't able to get the original size, we shouldn't exist.
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ENTER_AREA, .proc/check_area)

	target_size = size_to_apply
	check_area()

/// Checks if we need to revert our size when entering a different area.
/datum/component/temporary_size/proc/check_area()
	var/area/current_area = get_area(parent)
	if(!length(allowed_areas) || is_type_in_list(current_area, allowed_areas))
		apply_size(target_size)
		return TRUE

	apply_size(original_size)
	return FALSE

/// Adjusts the sprite size of the parent mob based off `size_to_apply`.
/datum/component/temporary_size/proc/apply_size(size_to_apply)
	var/mob/living/carbon/human/human_parent = parent
	if(!human_parent || !size_to_apply || (human_parent.dna.features["body_size"] == size_to_apply))
		return FALSE

	human_parent.dna.features["body_size"] = size_to_apply
	human_parent.maptext_height = 32 * human_parent.dna.features["body_size"]
	human_parent.dna.update_body_size()
	return TRUE

/datum/component/temporary_size/Destroy(force, silent)
	apply_size(original_size)
	UnregisterSignal(parent, COMSIG_ENTER_AREA)

	return ..()

#undef SIZE_WHITELISTED_AREAS

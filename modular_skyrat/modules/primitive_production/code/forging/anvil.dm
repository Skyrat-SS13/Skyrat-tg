/obj/item/forging_anvil
	name = "smithing anvil"
	desc = "Essentially a big block of metal that you can hammer other metals on top of, crucial for anyone working metal by hand."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_structures.dmi'
	icon_state = "anvil"

	force = 10
	throwforce = 15
	throw_speed = 1
	throw_range = 1

/obj/item/forging_anvil/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=10, force_wielded=10) // You ain't carrying this without two hands
	AddElement(/datum/element/falling_hazard, damage = 60, wound_bonus = 20, hardhat_safety = TRUE, crushes = TRUE)

/obj/item/forging_anvil/update_appearance()
	. = ..()
	cut_overlays()
	if(!length(contents))
		return

	var/image/overlayed_item = image(icon = contents[1].icon, icon_state = contents[1].icon_state)
	overlayed_item.transform = matrix(, 0, 0, 0, 0.8, 0)
	add_overlay(overlayed_item)

/obj/item/forging_anvil/examine(mob/user)
	. = ..()
	. += span_notice("You can place <b>hot metal objects</b> on this using some <b>tongs</b>.")

	if(length(contents))
		. += span_notice("It has [contents[1]] sitting on it.")

/obj/item/forging_anvil/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/forge_item = tool
	var/obj/obj_anvil_search = locate() in contents

	if(forge_item.in_use)
		balloon_alert(user, "already in use")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	var/obj/obj_tong_search = locate() in forge_item.contents
	if(obj_anvil_search && !obj_tong_search)
		obj_anvil_search.forceMove(forge_item)
		update_appearance()
		forge_item.icon_state = "tong_full"
		return TOOL_ACT_TOOLTYPE_SUCCESS

	if(!obj_anvil_search && obj_tong_search)
		obj_tong_search.forceMove(src)
		update_appearance()
		forge_item.icon_state = "tong_empty"
		return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/item/forging_anvil/hammer_act(mob/living/user, obj/item/tool)
	//regardless, we will make a sound
	playsound(src, 'modular_skyrat/modules/primitive_production/sound/hammer_clang.ogg', 50, TRUE, ignore_walls = FALSE)

	//do we have an incomplete item to hammer out? if so, here is our block of code
	var/obj/item/forging/incomplete/locate_incomplete = locate() in contents
	if(locate_incomplete)
		if(COOLDOWN_FINISHED(locate_incomplete, heating_remainder))
			balloon_alert(user, "metal too cool")
			locate_incomplete.times_hit -= 3
			return TOOL_ACT_TOOLTYPE_SUCCESS

		if(COOLDOWN_FINISHED(locate_incomplete, striking_cooldown))
			var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * locate_incomplete.average_wait
			COOLDOWN_START(locate_incomplete, striking_cooldown, skill_modifier)
			locate_incomplete.times_hit++
			balloon_alert(user, "good hit")
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives minimal experience

			if(locate_incomplete.times_hit >= locate_incomplete.average_hits)
				user.balloon_alert(user, "[locate_incomplete] sounds ready")

			return TOOL_ACT_TOOLTYPE_SUCCESS

		locate_incomplete.times_hit -= 3
		balloon_alert(user, "bad hit")

		if(locate_incomplete.times_hit <= -locate_incomplete.average_hits)
			balloon_alert_to_viewers("[locate_incomplete] breaks")
			qdel(locate_incomplete)
			update_appearance()

		return TOOL_ACT_TOOLTYPE_SUCCESS

	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/item/forging_anvil/hammer_act_secondary(mob/living/user, obj/item/tool)
	hammer_act(user, tool)

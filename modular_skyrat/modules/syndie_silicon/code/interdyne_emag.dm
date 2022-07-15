/obj/item/card/emag/interdyne
	name = "interdyne silicon card"
	special_desc = "A modified ID card used to override silicon for use on the DS-2 and Interdyne stations. Do not bite."

	/// Areas where the card should work, used in robot_defense.dm and syndie_silicon's silicon.dm
	var/list/valid_areas = list(/area/ruin/syndicate_lava_base/testlab, /area/ruin/space/has_grav/skyrat/interdynefob/research)
	/// Targets that the card should work on
	var/list/valid_targets = list(/mob/living/silicon/ai, /mob/living/silicon/robot)

/obj/item/card/emag/interdyne/can_emag(atom/target, mob/user)
	if(is_path_in_list(target.type, valid_targets))
		return TRUE
	return FALSE

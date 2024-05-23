// clean soups
/obj/item/reagent_containers/cup/soup_pot
	/// Whether or not the pot is set to clean other reagents from soups
	var/emulsify_reagents

/obj/item/reagent_containers/cup/soup_pot/examine(mob/user)
	. = ..()
	. += "You can enable/disable soup cleaning by alt-right-clicking [src]."

// alt-right click toggles whether soups will get cleaned
/obj/item/reagent_containers/cup/soup_pot/alt_click_secondary(mob/user)
	emulsify_reagents = !emulsify_reagents
	balloon_alert(user, "Soup cleaning [emulsify_reagents ? "enabled" : "disabled"]!")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

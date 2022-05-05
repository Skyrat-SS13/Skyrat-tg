/mob/living/carbon/human/update_fire()
	remove_overlay(FIRE_LAYER)
	remove_overlay(FIRE_SECONDARY_LAYER)
	if(on_fire || HAS_TRAIT(src, TRAIT_PERMANENTLY_ONFIRE))
		var/mutable_appearance/fire_overlay = mutable_appearance('modular_skyrat/modules/better_fire/icons/onfire.dmi', "fire_overlay", -FIRE_LAYER)
		fire_overlay.appearance_flags = RESET_COLOR
		overlays_standing[FIRE_LAYER] = fire_overlay
		apply_overlay(FIRE_LAYER)
		if(fire_stacks > HUMAN_FIRE_STACK_ICON_NUM)
			var/mutable_appearance/fire_underlay = mutable_appearance('modular_skyrat/modules/better_fire/icons/onfire.dmi', "fire_underlay", -FIRE_SECONDARY_LAYER)
			fire_underlay.appearance_flags = RESET_COLOR
			overlays_standing[FIRE_SECONDARY_LAYER] = fire_underlay
			apply_overlay(FIRE_SECONDARY_LAYER)

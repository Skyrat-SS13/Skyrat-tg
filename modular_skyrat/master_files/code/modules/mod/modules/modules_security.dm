/obj/item/mod/module/pepper_shoulders
	overlay_icon_file = 'modular_skyrat/master_files/icons/mob/clothing/modsuit/mod_modules.dmi'
	overlay_state_inactive = "module_pepper"
	overlay_state_use = "module_pepper_used"

/obj/item/mod/module/pepper_shoulders/generate_worn_overlay(mutable_appearance/standing)
	if(mod.skin == "security")
		overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
		overlay_state_use = "[initial(overlay_state_use)]-[mod.skin]"
	else
		overlay_state_inactive = "[initial(overlay_state_inactive)]"
		overlay_state_use = "[initial(overlay_state_use)]"
	return ..()

/obj/item/mod/module/dispenser/mirage
	overlay_icon_file = 'modular_skyrat/master_files/icons/mob/clothing/modsuit/mod_modules.dmi'
	overlay_state_inactive = "module_mirage_grenade"

/obj/item/mod/module/dispenser/mirage/generate_worn_overlay(mutable_appearance/standing)
	if(mod.skin == "security")
		overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	else
		overlay_state_inactive = "[initial(overlay_state_inactive)]"
	return ..()

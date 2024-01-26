/obj/item/mod/module/hydraulic/on_suit_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/hydraulic/on_suit_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

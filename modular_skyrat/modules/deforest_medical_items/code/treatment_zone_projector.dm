// Giant 3x3 tile warning hologram that tells people they should probably stand outside of it

/obj/structure/holosign/treatment_zone_warning
	name = "treatment zone indicator"
	desc = "A massive glowing holosign warning you to keep out of it, there's probably some important stuff happening in there!"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/telegraph_96x96.dmi'
	icon_state = "treatment_zone"
	layer = BELOW_MOB_LAYER
	pixel_x = -32
	pixel_y = -32
	use_vis_overlay = FALSE

// Projector for the above mentioned treatment zone signs

/obj/item/holosign_creator/medical/treatment_zone
	name = "emergency treatment zone projector"
	desc = "A holographic projector that creates a large, clearly marked treatment zone hologram, which warns outsiders that they ought to stay out of it."
	holosign_type = /obj/structure/holosign/treatment_zone_warning
	creation_time = 1 SECONDS
	max_signs = 1

/datum/augment_item/limb
	category = AUGMENT_CATEGORY_LIMBS
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	///Hardcoded styles that can be chosen from and apply to limb, if it's true
	var/uses_robotic_styles = TRUE

/datum/augment_item/limb/apply(mob/living/carbon/human/augmented, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		//Cheaply "faking" the appearance of the prosthetic. Species code sets this back if it doesnt exist anymore
		var/obj/item/bodypart/new_limb = path
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(initial(new_limb.body_zone))
		old_limb.organic_render = FALSE
		if(uses_robotic_styles && prefs.augment_limb_styles[slot])
			old_limb.icon = GLOB.robotic_styles_list[prefs.augment_limb_styles[slot]]
		else
			old_limb.icon = initial(new_limb.icon)
		old_limb.rendered_bp_icon = initial(new_limb.icon)
		old_limb.icon_state = initial(new_limb.icon_state)
		old_limb.should_draw_greyscale = FALSE
	else
		var/obj/item/bodypart/new_limb = new path(augmented)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(new_limb.body_zone)
		if(uses_robotic_styles && prefs.augment_limb_styles[slot])
			var/chosen_style = GLOB.robotic_styles_list[prefs.augment_limb_styles[slot]]
			new_limb.set_icon_static(chosen_style)
			new_limb.current_style = chosen_style
		new_limb.organic_render = FALSE
		new_limb.replace_limb(augmented)
		qdel(old_limb)

//HEADS
/datum/augment_item/limb/head
	slot = AUGMENT_SLOT_HEAD

/datum/augment_item/limb/head/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/head/robot/weak

//CHESTS
/datum/augment_item/limb/chest
	slot = AUGMENT_SLOT_CHEST

/datum/augment_item/limb/chest/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/chest/robot/weak

//LEFT ARMS
/datum/augment_item/limb/l_arm
	slot = AUGMENT_SLOT_L_ARM

/datum/augment_item/limb/l_arm/prosthetic
	name = "Prosthetic"
	path = /obj/item/bodypart/l_arm/robot/surplus
	cost = -1

/datum/augment_item/limb/l_arm/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/l_arm/robot/weak

//RIGHT ARMS
/datum/augment_item/limb/r_arm
	slot = AUGMENT_SLOT_R_ARM

/datum/augment_item/limb/r_arm/prosthetic
	name = "Prosthetic"
	path = /obj/item/bodypart/r_arm/robot/surplus
	cost = -1

/datum/augment_item/limb/r_arm/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/r_arm/robot/weak

//LEFT LEGS
/datum/augment_item/limb/l_leg
	slot = AUGMENT_SLOT_L_LEG

/datum/augment_item/limb/l_leg/prosthetic
	name = "Prosthetic"
	path = /obj/item/bodypart/l_leg/robot/surplus
	cost = -1

/datum/augment_item/limb/l_leg/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/l_leg/robot/weak

//RIGHT LEGS
/datum/augment_item/limb/r_leg
	slot = AUGMENT_SLOT_R_LEG

/datum/augment_item/limb/r_leg/prosthetic
	name = "Prosthetic"
	path = /obj/item/bodypart/r_leg/robot/surplus
	cost = -1

/datum/augment_item/limb/r_leg/cyborg
	name = "Cyborg"
	path = /obj/item/bodypart/r_leg/robot/weak

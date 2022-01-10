/*
	Arm Swing
	A subtype designed for humanoid creatures which have two arms, and use one of them to swing
*/
/datum/extension/swing/arm
	expected_type = /mob/living/carbon/human
	var/left = /obj/effect/effect/swing
	var/right = /obj/effect/effect/swing
	var/limb_used
	var/list/offsets_left = list(S_NORTH = new /vector2(-4, 12), S_SOUTH = new /vector2(8, 8), S_EAST = new /vector2(14, 2), S_WEST = new /vector2(8, 6))
	var/list/offsets_right = list(S_NORTH = new /vector2(12, 12), S_SOUTH = new /vector2(-8, 6), S_EAST = new /vector2(-2, 4), S_WEST = new /vector2(-6, 6))



/datum/extension/swing/arm/New(var/atom/user, var/atom/source, var/atom/target, var/angle = 90, var/range = 3, var/duration = 1 SECOND, var/windup = 0, var/cooldown = 0,  var/effect_type, var/damage = 1, var/damage_flags = 0, var/stages = 8, var/swing_direction = CLOCKWISE)
	if (ismob(user))
		var/mob/M = user
		swing_direction = M.get_swing_dir()

		switch(swing_direction)
			if (CLOCKWISE)
				effect_type = left
			if (ANTICLOCKWISE)
				effect_type = right

	.=..()


/datum/extension/swing/arm/windup_animation()
	.=..()
	switch (swing_direction)
		//Cache the limb used
		if (CLOCKWISE)
			limb_used = BP_L_ARM
		else
			limb_used = BP_R_ARM

	var/mob/living/carbon/human/H = user
	//We will temporarily retract the arm from the sprite
	var/obj/item/organ/external/E = H.get_organ(limb_used)
	if (E)
		E.retracted = TRUE
		H.update_body(TRUE)




/datum/extension/swing/arm/setup_effect()
	.=..()
	//The parent code will move the effect object to the centre of our sprite, now we will offset it farther to the appropriate shoulder joint
	var/vector2/offset
	if (limb_used == BP_L_ARM)
		offset = offsets_left["[user.dir]"]
	else
		offset = offsets_right["[user.dir]"]

	effect.pixel_x += offset.x
	effect.pixel_y += offset.y


/datum/extension/swing/arm/cleanup_effect()
	.=..()
	var/mob/living/carbon/human/H = user

	//Put the arm back now
	var/obj/item/organ/external/E = H.get_organ(limb_used)
	if (E)
		E.retracted = FALSE
		H.update_body(TRUE)
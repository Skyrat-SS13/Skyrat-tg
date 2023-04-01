#define EMP_BRUTE_DAMAGE 0
#define EMP_BURN_DAMAGE_LIGHT 2
#define EMP_BURN_DAMAGE_HEAVY 5

/mob/living/carbon/human/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	var/informed = FALSE
	var/affects_leg = FALSE
	var/stun_time = 0
	for(var/obj/item/bodypart/L in src.bodyparts)
		if(!IS_ORGANIC_LIMB(L))
			if(!informed)
				to_chat(src, span_userdanger("You feel a sharp pain as your robotic limbs overload."))
				informed = TRUE
			switch(severity)
				if(1)
					L.receive_damage(EMP_BRUTE_DAMAGE, EMP_BURN_DAMAGE_HEAVY)
					stun_time += 2 SECONDS
				if(2)
					L.receive_damage(EMP_BRUTE_DAMAGE,EMP_BURN_DAMAGE_LIGHT)
					stun_time += 1 SECONDS
			if(L.body_zone == BODY_ZONE_L_LEG || L.body_zone == BODY_ZONE_R_LEG)
				affects_leg = TRUE


			if(L.body_zone == BODY_ZONE_L_ARM || L.body_zone == BODY_ZONE_R_ARM)
				dropItemToGround(get_item_for_held_index(L.held_index), 1)

	if(stun_time)
		Paralyze(stun_time)
	if(affects_leg)
		switch(severity)
			if(1)
				Knockdown(50)
			if(2)
				Knockdown(25)

#undef EMP_BRUTE_DAMAGE
#undef EMP_BURN_DAMAGE_LIGHT
#undef EMP_BURN_DAMAGE_HEAVY

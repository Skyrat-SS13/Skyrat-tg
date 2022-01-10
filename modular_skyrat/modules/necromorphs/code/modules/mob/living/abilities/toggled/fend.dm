/*
	Fend

	Toggled ability for slashers that provides damage resistance and an active frontal block, but lowers movespeed while active


*/
#define FEND_DAMAGE_REDUCTION	10

/datum/extension/ability/toggled/fend
	toggle_on_time = (0.25 SECONDS)
	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE	=	0.5,
	STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.8)



/datum/extension/ability/toggled/fend/pre_activate()
	.=..()
	var/mob/living/carbon/human/H = holder
	H.play_species_audio(SOUND_PAIN)


/datum/extension/ability/toggled/fend/activated()
	.=..()
	var/mob/living/carbon/human/H = holder
	H.visible_message("[H] shields itself with its blades")
	H.add_aura_by_type(/obj/aura/fend)

/datum/extension/ability/toggled/fend/deactivated()
	.=..()
	var/mob/living/carbon/human/H = holder
	H.visible_message("[H] lowers its guard")
	H.remove_aura_by_type(/obj/aura/fend)

/*
	Fend makes use of an aura for some of its effects. Namely the hit interception and visual FX
*/
/obj/aura/fend
	name = "Fend"
	icon = 'icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "fend"
	var/damage_block = FEND_DAMAGE_REDUCTION
	var/list/blocking_limbs = list(BP_L_ARM, BP_R_ARM)
	layer = ABOVE_HUMAN_LAYER

/obj/aura/fend/bullet_act(var/obj/item/projectile/P, var/def_zone)

	//A -10 modifier is passed to the block chance because bullets are harder to block than melee attacks
	if (check_block(def_zone, P.last_loc, -10))
		if (P.damage <=  damage_block)
			//If the projectile is weak enough to be completely blocked, it will bounce off us
			return PROJECTILE_DEFLECT	//The projectile goes ping
		else
			//We reduce the damage of the projectile, but it will still hit after that
			P.damage -= damage_block


/obj/aura/fend/handle_strike(var/datum/strike/S)
	if (check_block(S.target_zone, S.origin))
		S.blocker = get_blocking_limb()
		//Free counterattack if the incoming attack is weak enough
		if (S.damage <=  damage_block && S.melee)
			var/mob/living/carbon/human/H = user

			//Two free hits, one at a random zone
			H.last_attack = 0
			H.UnarmedAttack(S.user)

			H.set_random_zone()
			H.last_attack = 0
			H.UnarmedAttack(S.user)

			return AURA_FALSE	//The strike wont hit
		else
			//We reduce the damage of the strike, but it will still hit after that
			S.damage -= damage_block

//Checks if fend can block this
/obj/aura/fend/proc/check_block(var/target_zone, var/origin, var/modifier = 0)
	var/block_chance = 100 + modifier
	if (user.lying)
		block_chance -= 30
	else if (!target_in_frontal_arc(user, origin, 45))
		//If target isnt infront of us, blocking is less successful
		if (target_in_frontal_arc(user, origin, 90)) //If its >45 but within 90, we use the weaker flank armor
			block_chance -= 20
		else
			//Target is behind us, we can't block it
			return FALSE


	//Mostly protects upperbody, less effective on lower
	if ((target_zone in BP_LOWER_BODY))
		block_chance -= 20




	//Need limbs to block with
	var/mob/living/carbon/human/H = user
	var/num_limbs = 0
	for (var/otag in blocking_limbs)
		if (H.has_organ(otag))
			num_limbs++


	if (!num_limbs)
		return FALSE
	else
		//Missing some of the required limbs reduces the block chance proportionally
		block_chance *= num_limbs / length(blocking_limbs)



	return prob(block_chance)

/obj/aura/fend/proc/get_blocking_limb()
	var/mob/living/carbon/human/H = user
	for (var/otag in blocking_limbs)
		if (H.has_organ(otag))
			return H.get_organ(otag)
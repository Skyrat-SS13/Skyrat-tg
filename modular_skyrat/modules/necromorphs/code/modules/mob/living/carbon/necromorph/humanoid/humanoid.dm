/mob/living/carbon/necromorph/humanoid
	name = "Necromorph - Humanoid BASE"
	//icon_state = "necromorph"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	icon_state = "twitcher"
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/food/meat/slab/xeno = 5, /obj/item/stack/sheet/animalhide/xeno = 1)
	limb_destroyer = 1
//	hud_type = /datum/hud/necromorph
	melee_damage_lower = 20 //Refers to unarmed damage, necromorphs do unarmed attacks.
	melee_damage_upper = 20
	maxHealth = 125
	health = 125

	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/varient = ""
	var/alt_icon = 'icons/mob/alienleap.dmi' //used to switch between the two necromorph icon files.
	var/single_icon =""
	var/leap_on_click = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 30
	var/sneaking = 0 //For sneaky-sneaky mode and appropriate slowdown
	var/drooling = 0 //For Neruotoxic spit overlays
	deathsound = 'sound/voice/hiss6.ogg'

	bodyparts = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph,
	)


/mob/living/carbon/necromorph/humanoid/Topic(href, href_list)
	//strip panel
	if(href_list["pouches"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		visible_message("<span class='danger'>[usr] tries to empty [src]'s pouches.</span>", \
						"<span class='userdanger'>[usr] tries to empty your pouches.</span>")
		if(do_mob(usr, src, POCKET_STRIP_DELAY * 0.5))
			dropItemToGround(r_store)
			dropItemToGround(l_store)

	..()


/mob/living/carbon/necromorph/humanoid/Initialize()
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW, 0.5, -11)
	AddElement(/datum/element/strippable, GLOB.strippable_alien_humanoid_items)

/mob/living/carbon/necromorph/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, TRUE, TRUE)  //Alien roars when starting to break free
	..(I, cuff_break = INSTANT_CUFFBREAK)

/mob/living/carbon/necromorph/humanoid/resist_grab(moving_resist)
	if(pulledby.grab_state)
		visible_message(span_danger("[src] breaks free of [pulledby]'s grip!"), \
						span_danger("You break free of [pulledby]'s grip!"))
	pulledby.stop_pulling()
	. = 0

/mob/living/carbon/necromorph/humanoid/check_breath(datum/gas_mixture/breath)
	if(breath && breath.total_moles() > 0 && !sneaking)
		playsound(get_turf(src), pick('sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg'), 50, FALSE, -5)
	..()

/mob/living/carbon/necromorph/humanoid/set_name()
	if(numba)
		name = "[name] ([numba])"
		real_name = name
/mob/living/carbon/necromorph/humanoid/get_permeability_protection(list/target_zones)
	return 0.8

//For necromorph evolution/promotion/queen finder procs. Checks for an active necromorph of that type
/proc/get_necromorph_type(necromorphpath)
	for(var/mob/living/carbon/necromorph/humanoid/A in GLOB.alive_mob_list)
		if(!istype(A, necromorphpath))
			continue
		if(!A.key || A.stat == DEAD) //Only living necromorphs with a ckey are valid.
			continue
		return A
	return FALSE


/mob/living/carbon/necromorph/humanoid/check_breath(datum/gas_mixture/breath)
	if(breath && breath.total_moles() > 0 && !sneaking)
		playsound(get_turf(src), pick('sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg'), 50, FALSE, -5)
	..()

/mob/living/carbon/necromorph/humanoid/update_icons()
	cut_overlays()
	for(var/I in overlays_standing)
		add_overlay(I)

	var/asleep = IsSleeping()
	if(stat == DEAD)
		//If we mostly took damage from fire
		if(getFireLoss() > 125)
			icon_state = "[varient]_d_dead"
		else
			icon_state = "[varient]_d_dead"

	else if((stat == UNCONSCIOUS && !asleep) || stat == HARD_CRIT || stat == SOFT_CRIT || IsParalyzed())
		icon_state = "[varient]_d_lying"
	else if(leap_on_click)
		icon_state = "[varient]_s"

	else if(body_position == LYING_DOWN)
		icon_state = "[varient]_d_lying"
	else if(mob_size == MOB_SIZE_LARGE)
		icon_state = "alien[varient]"
		if(drooling)
			add_overlay("alienspit_[varient]")
	else
		icon_state = "[varient]_d"
		if(drooling)
			add_overlay("alienspit")

	if(leaping)
		if(alt_icon == initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
		icon_state = "alien[varient]_leap"
		pixel_x = base_pixel_x - 32
		pixel_y = base_pixel_y - 32
	else
		if(alt_icon != initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
	pixel_x = base_pixel_x + body_position_pixel_x_offset
	pixel_y = base_pixel_y + body_position_pixel_y_offset
	update_inv_hands()
	update_inv_handcuffed()


/mob/living/carbon/necromorph/humanoid/regenerate_icons()
	if(!..())
	// update_icons() //Handled in update_transform(), leaving this here as a reminder
		update_transform()

/mob/living/carbon/necromorph/humanoid/update_transform() //The old method of updating lying/standing was update_icons(). Aliens still expect that.
	. = ..()
	update_icons()

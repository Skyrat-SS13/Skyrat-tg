/obj/item/clothing/gloves/kinetic_gauntlets
	name = "kinetic gauntlets"
	desc = "Nanotrasen's take on the power-fist, originally designed to help the security department but ultimately scrapped due to causing too much collateral damage. \
	Later on, repurposed into a pair of mining tools after a disgruntled shaft miner complained to R&D about mining \"not being metal enough\"."
	icon = 'modular_skyrat/master_files/icons/obj/mining.dmi'
	icon_state = "kgauntlets"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/gloves.dmi'
	worn_icon_state = "kgauntlets_off"

	armor_type = /datum/armor/melee_energy
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 2.075) //copied from kc, idk
	light_on = FALSE
	light_power = 5
	light_range = 4
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	resistance_flags = FIRE_PROOF

	force = 3 //i guess?
	obj_flags = UNIQUE_RENAME
	throwforce = 3 //why doesnt this have an underscore i hate this
	throw_speed = 2


	actions_types = list(/datum/action/item_action/extend_gauntlets)
	attack_verb_continuous = list("slaps", "challenges")
	attack_verb_simple = list("slap", "challenge")
	equip_delay_self = 2 SECONDS //that's a lot of bulky
	hitsound = 'sound/weapons/slap.ogg'
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_BULKY

	var/obj/item/kinetic_gauntlet/left/left_gauntlet = null
	var/obj/item/kinetic_gauntlet/right_gauntlet = null

/obj/item/clothing/gloves/kinetic_gauntlets/Initialize(mapload)
	. = ..()
	left_gauntlet = new(src)
	right_gauntlet = new(src)

	var/datum/component/crusher_comp = AddComponent(/datum/component/kinetic_crusher, 50, 30, 1.5 SECONDS, CALLBACK(src, PROC_REF(attack_check)), CALLBACK(src, PROC_REF(detonate_check)), CALLBACK(src, PROC_REF(after_detonate)))
	crusher_comp.RegisterWithParent(left_gauntlet)
	crusher_comp.RegisterWithParent(right_gauntlet)

/obj/item/clothing/gloves/kinetic_gauntlets/Destroy()
	QDEL_NULL(left_gauntlet)
	QDEL_NULL(right_gauntlet)
	return ..()

/obj/item/clothing/gloves/kinetic_gauntlets/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	left_gauntlet?.forceMove(src)
	right_gauntlet?.forceMove(src)

/obj/item/clothing/gloves/kinetic_gauntlets/ui_action_click(mob/user, datum/action/actiontype)
	toggle_gauntlets()

/obj/item/clothing/gloves/kinetic_gauntlets/proc/on_gauntlet_qdel()
	if(QDELETED(left_gauntlet))
		left_gauntlet = null
	if(QDELETED(right_gauntlet))
		right_gauntlet = null

	if(isnull(left_gauntlet) && isnull(right_gauntlet) && !QDELING(src))
		qdel(src)

/obj/item/clothing/gloves/kinetic_gauntlets/proc/attack_check(mob/living/user, cancel_attack)
	return left_gauntlet?.loc == user || right_gauntlet?.loc == user

/obj/item/clothing/gloves/kinetic_gauntlets/proc/detonate_check(mob/living/user)
	var/both_gauntlets_deployed = left_gauntlet?.loc == user && right_gauntlet?.loc == user
	if(both_gauntlets_deployed)
		return left_gauntlet.next_attack >= world.time || right_gauntlet.next_attack >= world.time

	return FALSE //you WILL glass cannon and you WILL like it.

/obj/item/clothing/gloves/kinetic_gauntlets/proc/after_detonate(mob/living/user, mob/living/target)
	playsound(src, 'sound/weapons/resonator_blast.ogg', 40, TRUE)
	var/old_dir_user = user.dir
	var/old_dir_target = user.dir
	step(user, get_dir(target, user))
	step(target, get_dir(user, target))
	user.dir = old_dir_user
	target.dir = old_dir_target


/obj/item/clothing/gloves/kinetic_gauntlets/proc/toggle_gauntlets()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer))
		return

	if(left_gauntlet.loc == src || right_gauntlet.loc == src)
		deploy_gauntlets()
	else
		retract_gauntlets()

/obj/item/clothing/gloves/kinetic_gauntlets/proc/deploy_gauntlets()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer) || DOING_INTERACTION(wearer, type))
		return

	if(wearer.gloves != src)
		to_chat(wearer, span_warning("You must be wearing these to do this!"))
		return

	var/left_deployed = isnull(left_gauntlet) || left_gauntlet.loc == wearer
	var/right_deployed = isnull(right_gauntlet) || right_gauntlet.loc == wearer
	if(left_deployed && right_deployed)
		return //nothing to do

	var/can_deploy = TRUE
	if(!left_deployed && !wearer.can_put_in_hand(left_gauntlet, 1))
		can_deploy = FALSE
	if(!right_deployed && !wearer.can_put_in_hand(right_gauntlet, 2))
		can_deploy = FALSE

	if(!can_deploy)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You need both free hands to deploy [src]!"))
		return

	// equipping/unequipping shall take time
	wearer.add_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)
	if(!do_after(wearer, 1.5 SECONDS, src, IGNORE_USER_LOC_CHANGE, interaction_key = type))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You fail to deploy [src]!"))
		wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)
		return

	wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)

	if(!left_deployed && !wearer.can_put_in_hand(left_gauntlet, 1))
		can_deploy = FALSE
	if(!right_deployed && !wearer.can_put_in_hand(right_gauntlet, 2))
		can_deploy = FALSE

	if(!can_deploy)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You need both free hands to deploy [src]!"))
		return

	if(!left_deployed)
		wearer.put_in_l_hand(left_gauntlet)

	if(!right_deployed)
		wearer.put_in_r_hand(right_gauntlet)

	ADD_TRAIT(src, TRAIT_NODROP, type)

	playsound(src, 'sound/mecha/mechmove03.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(src, 'sound/mecha/mechmove01.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(wearer, span_notice("You deploy [src]."))

/obj/item/clothing/gloves/kinetic_gauntlets/proc/retract_gauntlets()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer) || DOING_INTERACTION(wearer, type))
		return

	if(wearer.gloves != src)
		to_chat(wearer, span_warning("You must be wearing these to do this!"))
		return

	if(left_gauntlet?.loc == src && right_gauntlet?.loc == src)
		return

	wearer.add_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)
	if(!do_after(wearer, 1.5 SECONDS, src, IGNORE_USER_LOC_CHANGE))
		wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You fail to retract [src]!"))
		return

	wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_gauntlets)

	left_gauntlet?.forceMove(src)
	right_gauntlet?.forceMove(src)

	REMOVE_TRAIT(src, TRAIT_NODROP, type)
	playsound(src, 'sound/mecha/powerloader_turn2.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(src, 'sound/mecha/mechmove01.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(wearer, span_notice("You retract [src]."))


/obj/item/kinetic_gauntlet
	name = "kinetic gauntlets"
	desc = "Okay, these <i>are</i> pretty metal."
	icon = 'modular_skyrat/master_files/icons/obj/mining.dmi'
	icon_state = "kgauntlet_r"
	inhand_icon_state = "kgauntlet"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_righthand.dmi'
	attack_verb_continuous = list("rams", "fists", "pulverizes", "power-punches")
	attack_verb_simple = list("ram", "fist", "pulverize", "power-punch")

	armor_type = /datum/armor/melee_energy
	force = 15 // double hit -> 10 more dmg than crusher
	obj_flags = DROPDEL
	resistance_flags = FIRE_PROOF

	secondary_attack_speed = 0.1 SECONDS

	var/obj/item/clothing/gloves/kinetic_gauntlets/linked_gauntlets = null
	var/next_attack = 0

/obj/item/kinetic_gauntlet/Initialize(mapload)
	. = ..()
	if(!istype(loc, /obj/item/clothing/gloves/kinetic_gauntlets))
		return INITIALIZE_HINT_QDEL //le sigh

	linked_gauntlets = loc
	ADD_TRAIT(src, TRAIT_NODROP, type)

/obj/item/kinetic_gauntlet/Destroy(force)
	if(linked_gauntlets) //fuck c&d
		linked_gauntlets.on_gauntlet_qdel()
		linked_gauntlets = null
	return ..()

/obj/item/kinetic_gauntlet/melee_attack_chain(mob/user, atom/target, params)
	if(next_attack > world.time)
		return
	return ..()

/obj/item/kinetic_gauntlet/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	playsound(src, 'sound/weapons/genhit2.ogg', 40, TRUE)
	next_attack = world.time + 0.8 SECONDS // same as a crusher
	user.changeNext_move(CLICK_CD_HYPER_RAPID) //forgive me
	if(istype(user.get_inactive_held_item(), /obj/item/kinetic_gauntlet))
		user.swap_hand()

/obj/item/kinetic_gauntlet/attack_self(mob/user, modifiers)
	if(linked_gauntlets.left_gauntlet)
		return linked_gauntlets.left_gauntlet.attack_self(user, modifiers)
	return ..()

/obj/item/kinetic_gauntlet/left
	icon_state = "kgauntlet_l"
	actions_types = list(/datum/action/item_action/toggle_light)

/obj/item/kinetic_gauntlet/left/Initialize(mapload)
	. = ..()
	if(linked_gauntlets)
		RegisterSignal(linked_gauntlets, COMSIG_HIT_BY_SABOTEUR, PROC_REF(on_saboteur))

/obj/item/kinetic_gauntlet/left/Destroy(force)
	if(linked_gauntlets)
		UnregisterSignal(linked_gauntlets, COMSIG_HIT_BY_SABOTEUR)
		linked_gauntlets.set_light_on(FALSE)
	return ..()

/obj/item/kinetic_gauntlet/left/update_overlays()
	. = ..()
	if(linked_gauntlets.light_on)
		. += "[icon_state]_lit"

/obj/item/kinetic_gauntlet/left/attack_self(mob/user, modifiers)
	linked_gauntlets.set_light_on(!linked_gauntlets.light_on)
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()

/obj/item/kinetic_gauntlet/left/proc/on_saboteur(datum/source, disrupt_duration)
	linked_gauntlets.set_light_on(FALSE)
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	return COMSIG_SABOTEUR_SUCCESS

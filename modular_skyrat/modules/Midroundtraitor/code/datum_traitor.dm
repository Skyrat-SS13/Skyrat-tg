/datum/antagonist/traitor/infiltrator
	name = "Lone Infiltrator"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator
	preview_outfit = /datum/outfit/lone_infiltrator_preview
	job_rank = ROLE_LONE_INFILTRATOR

/datum/antagonist/traitor/infiltrator/on_gain()
	var/mob/living/carbon/human/H = owner.current
	H.equipOutfit(infil_outfit)
	var/chosen_name = H.dna.species.random_name(H.gender,1,1)
	H.fully_replace_character_name(H.real_name,chosen_name)
	return ..()

/datum/outfit/lone_infiltrator_preview
	name = "Lone Infiltrator (Preview only)"

	back = /obj/item/mod/control/pre_equipped/empty/syndicate
	uniform = /obj/item/clothing/under/syndicate
	l_hand = /obj/item/shield/energy
	r_hand = /obj/item/gun/ballistic/automatic/c20r

/datum/outfit/lone_infiltrator_preview/post_equip(mob/living/carbon/human/H, visualsOnly)
	var/obj/item/mod/module/armor_booster/booster = locate() in H.back
	booster.active = TRUE
	H.update_inv_back()
	var/obj/item/shield/energy/e_shield = locate() in H.contents
	e_shield.icon_state = "[initial(e_shield.icon_state)]_on"

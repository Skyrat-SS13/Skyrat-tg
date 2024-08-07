/datum/antagonist/traitor/lone_infiltrator
	name = "Lone Infiltrator"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator
	preview_outfit = /datum/outfit/lone_infiltrator_preview
	job_rank = ROLE_LONE_INFILTRATOR

/datum/antagonist/traitor/lone_infiltrator/on_gain()
	var/mob/living/carbon/human/current = owner.current
	if(iscarbon(current))
		current.apply_pref_name(/datum/preference/name/syndicate, current.client)
		current.dna.update_dna_identity()
	current.equipOutfit(infil_outfit)
	return ..()

/datum/outfit/lone_infiltrator_preview
	name = "Lone Infiltrator (Preview only)"

	back = /obj/item/mod/control/pre_equipped/empty/syndicate
	uniform = /obj/item/clothing/under/syndicate
	l_hand = /obj/item/shield/energy
	r_hand = /obj/item/gun/ballistic/automatic/c20r

/datum/outfit/lone_infiltrator_preview/post_equip(mob/living/carbon/human/equipped_person, visualsOnly)
	var/obj/item/mod/module/armor_booster/booster = locate() in equipped_person.back
	booster.active = TRUE
	equipped_person.update_worn_back()
	var/obj/item/shield/energy/e_shield = locate() in equipped_person.contents
	e_shield.icon_state = "[initial(e_shield.icon_state)]_on"

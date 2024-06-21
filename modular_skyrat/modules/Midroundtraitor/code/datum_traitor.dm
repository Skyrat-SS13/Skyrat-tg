/datum/antagonist/traitor/lone_infiltrator
	name = "Lone Infiltrator"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator
	preview_outfit = /datum/outfit/lone_infiltrator_preview
	job_rank = ROLE_LONE_INFILTRATOR

/datum/antagonist/traitor/lone_infiltrator/on_gain()
	var/mob/living/carbon/human/current = owner.current
	current.equipOutfit(infil_outfit)
	var/chosen_name = generate_random_name_species_based(current.gender, TRUE, species_type = current.dna.species.type)
	current.fully_replace_character_name(current.real_name, chosen_name)
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

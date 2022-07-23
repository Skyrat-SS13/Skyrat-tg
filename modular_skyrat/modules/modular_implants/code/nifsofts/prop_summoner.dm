/obj/item/disk/nifsoft_uploader/summoner
	loaded_nifsoft = /datum/nifsoft/summoner


/datum/nifsoft/summoner
	name = "Virtual Grimoire"
	program_desc = "Used to conjure various virtual items and beasts"
	cost = 200
	activation_cost = 100 // Around 1/10th the energy of a standard NIF
	cooldown = TRUE

	///The list of items that can be summoned from the NIFSoft.
	var/static/list/summonable_items = list(
		/obj/item/toy/katana/nanite,
	)

/datum/nifsoft/summoner/activate()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	var/mob/living/carbon/human/linked_human = installed_nif.linked_mob

	if(!activation_check(installed_nif))
		return FALSE

	var/list/summon_choices = list()
	for(var/obj/item/summon_item as anything in summonable_items)
		var/image/obj_icon = image(icon = initial(summon_item.icon), icon_state = initial(summon_item.icon_state))

		summon_choices[summon_item] = obj_icon

	var/obj/item/choice = show_radial_menu(linked_human, linked_human, summon_choices, custom_check = CALLBACK(src, .proc/check_menu, linked_human))
	if(!choice)
		return FALSE

	var/obj/item/new_item = new choice
	if(!linked_human.put_in_hands(new_item))
		qdel(new_item)
		return FALSE

	return ..()

/datum/nifsoft/summoner/proc/check_menu(mob/living/carbon/human/user)
	if(!istype(user) || !user.installed_nif)
		return FALSE

	return TRUE

//Summonable Items
///A somehow wekaer version of the toy katana
/obj/item/toy/katana/nanite
	name = "fake replica katana"
	desc = "Just like the real thing, but somehow worse."
	force = 0
	throwforce = 0

/obj/item/advanced_choice_beacon
	name = "advanced choice beacon"
	desc = "A beacon that will send whatever your heart desires, providing Nanotrasen approves it."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-red"
	inhand_icon_state = "radio"

	var/list/possible_choices = list()

	var/pod_style = STYLE_CENTCOM

/obj/item/advanced_choice_beacon/attack_self(mob/user, modifiers)
	if(canUseBeacon(user))
		display_options(user)

/obj/item/advanced_choice_beacon/proc/canUseBeacon(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
		return FALSE


/obj/item/advanced_choice_beacon/proc/display_options(mob/user)
	var/list/radial_build = get_available_options()

	if(!radial_build)
		return

	var/chosen_option = show_radial_menu(user, src, radial_build, radius = 40, tooltips = TRUE)

	if(!chosen_option)
		return

	podspawn(list(
		"target" = get_turf(src),
		"style" = pod_style,
		"spawn" = chosen_option,
	))

	qdel(src)

/obj/item/advanced_choice_beacon/proc/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/our_object = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_object.icon), icon_state = initial(our_object.icon_state))
		option.info = span_boldnotice("[initial(our_object.desc)]")

		options[our_object] = option

	sort_list(options)

	return options

/obj/item/advanced_choice_beacon/exp_corps
	name = "vanguard operatives supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(
		/obj/structure/closet/crate/secure/exp_corps/marksman,
		/obj/structure/closet/crate/secure/exp_corps/pointman,
		/obj/structure/closet/crate/secure/exp_corps/field_medic,
		/obj/structure/closet/crate/secure/exp_corps/combat_tech
	)

/obj/item/advanced_choice_beacon/exp_corps/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/structure/closet/crate/secure/exp_corps/our_crate = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_crate.icon), icon_state = initial(our_crate.icon_state))
		option.info = span_boldnotice("[initial(our_crate.loadout_desc)]")

		options[our_crate] = option

	sort_list(options)

	return options

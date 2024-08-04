/obj/item/advanced_choice_beacon
	name = "advanced choice beacon"
	desc = "A beacon that will send whatever your heart desires, providing Nanotrasen approves it."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "designator_syndicate"
	inhand_icon_state = "nukietalkie"

	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	var/list/possible_choices = list()

	var/pod_style = /datum/pod_style/centcom

/obj/item/advanced_choice_beacon/attack_self(mob/user, modifiers)
	if(can_use_beacon(user))
		display_options(user)

/obj/item/advanced_choice_beacon/proc/can_use_beacon(mob/living/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
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


/obj/item/advanced_choice_beacon/nri
	name = "\improper NRI Defense Collegium supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

/obj/item/advanced_choice_beacon/nri/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/structure/closet/crate/secure/weapon/nri/our_crate = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_crate.icon), icon_state = initial(our_crate.icon_state))
		option.info = span_boldnotice("[initial(our_crate.loadout_desc)]")

		options[our_crate] = option

	sort_list(options)

	return options

/obj/item/advanced_choice_beacon/nri/engineer
	name = "\improper NRI Defense Collegium engineering supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/engineer/defense, /obj/structure/closet/crate/secure/weapon/nri/engineer/offense)

/obj/item/advanced_choice_beacon/nri/heavy
	name = "\improper NRI Defense Collegium heavy armaments supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/heavy/defense,/obj/structure/closet/crate/secure/weapon/nri/heavy/offense)

/obj/item/stack/sheet/mineral/sandbags/fifty
	amount = 50

/obj/item/storage/toolbox/emergency/turret/nri
	name = "NRI stationary defense deployment system"
	desc = "You feel a strange urge to hit this with a wrench."
	icon = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	icon_state = "inventory"
	inhand_icon_state = "held"
	lefthand_file = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	righthand_file = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	w_class = WEIGHT_CLASS_BULKY
	has_latches = FALSE

/obj/item/storage/toolbox/emergency/turret/nri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/obj/item/storage/toolbox/emergency/turret/nri/PopulateContents()
	return null

/obj/item/storage/toolbox/emergency/turret/nri/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WRENCH && user.combat_mode)
		user.visible_message(span_danger("[user] bashes [src] with [I]!"), \
			span_danger("You bash [src] with [I]!"), null, COMBAT_MESSAGE_RANGE)
		playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
		var/obj/machinery/porta_turret/syndicate/pod/toolbox/nri/turret = new(get_turf(loc))
		turret.faction = list(FACTION_NEUTRAL, FACTION_ERT)
		qdel(src)

	..()

/obj/machinery/porta_turret/syndicate/pod/toolbox/nri
	icon = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	icon_state = "living"
	base_icon_state = "living"
	stun_projectile = /obj/projectile/bullet/c27_54cesarzowa/rubber
	lethal_projectile = /obj/projectile/bullet/c27_54cesarzowa
	max_integrity = 150
	req_access = list(ACCESS_CENT_GENERAL)
	faction = list(FACTION_NEUTRAL, FACTION_ERT)
	shot_delay = 0.25

/obj/machinery/porta_turret/syndicate/pod/toolbox/nri/assess_perp(mob/living/carbon/human/perp)
	return 0

/mob/living/basic/viscerator/nri
	faction = list(FACTION_NEUTRAL, FACTION_ERT)

/obj/item/grenade/spawnergrenade/manhacks/nri
	name = "imperial viscerator delivery grenade"
	spawner_type = /mob/living/basic/viscerator/nri
	deliveryamt = 10

/obj/structure/closet/crate/secure/weapon/nri
	name = "military supplies crate"
	desc = "A secure military-grade crate. According to the markings, -as well as mixed Cyrillics-, it was shipped and provided by the NRI Defense Collegium."
	req_access = list(ACCESS_CENT_GENERAL)
	var/loadout_desc = "Whoever picks this is might be busy debugging this copypasted code."

//base, don't use this, but leaving it for admin spawns is probably a good call? (no because it's literally freaking empty lmfao)
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	return null

//defensive engineering loadout
/obj/structure/closet/crate/secure/weapon/nri/engineer/defense
	name = "defensive engineering supplies"
	loadout_desc = "An assortment of engineering supplies finely tuned for quick fortification. \
		Features barricades, building materials, extra large fuel tank and 5.6mm defensive autoturrets."

/obj/structure/closet/crate/secure/weapon/nri/engineer/defense/PopulateContents()
	new /obj/item/storage/barricade(src)
	new /obj/item/storage/barricade(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/stack/sheet/plasteel/fifty(src)
	new /obj/item/stack/sheet/glass/fifty(src)
	new /obj/item/stack/sheet/mineral/sandbags/fifty(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/structure/reagent_dispensers/fueltank/large(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/rcd_ammo/large(src)

//offensive engineering loadout
/obj/structure/closet/crate/secure/weapon/nri/engineer/offense
	name = "offensive engineering supplies"
	loadout_desc = "An assortment of engineering supplies finely tuned for rapid approach defortification and area suppression. \
		Features way less barricades and building materials than its more defensive analogue, but includes NRI-issued viscerator grenades and a combat RCD."

/obj/structure/closet/crate/secure/weapon/nri/engineer/offense/PopulateContents()
	new /obj/item/storage/barricade(src)
	new /obj/item/stack/sheet/mineral/sandbags/fifty(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/structure/reagent_dispensers/fueltank(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/construction/rcd/combat(src)
	new /obj/item/rcd_ammo/large(src)

//defensive heavy loadout
/obj/structure/closet/crate/secure/weapon/nri/heavy/defense
	name = "defensive heavy supplies"
	loadout_desc = "An assortment of heavy soldier supplies finely tuned for stationary fire suppression and explosive fortifications. \
		Features a fifty calibre heavy machinegun with a lot of ammo to spare, as well as a bunch of explosive landmines. \
		And some bonus frag grenades."

/obj/structure/closet/crate/secure/weapon/nri/heavy/defense/PopulateContents()
	new /obj/item/mounted_machine_gun_folded(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)

//offensive heavy loadout
/obj/structure/closet/crate/secure/weapon/nri/heavy/offense
	name = "offensive heavy supplies"
	loadout_desc = "An assortment of heavy soldier supplies finely tuned for rapid approach and munition support. \
		Features Scarborough's standard LMG with a spare ammo box, as well as ammunition for Krinkov and PP-542."

/obj/structure/closet/crate/secure/weapon/nri/heavy/offense/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted(src)
	new /obj/item/storage/toolbox/ammobox/full/l6_saw(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/nri_smg(src)
	new /obj/item/storage/toolbox/ammobox/full/nri_smg(src)
	new /obj/item/storage/toolbox/ammobox/full/aps(src)

/obj/item/advanced_choice_beacon/nri
	name = "\improper NRI Defense Colleague supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(/obj/structure/closet/crate/secure/exp_corps)

/obj/item/advanced_choice_beacon/nri/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/structure/closet/crate/secure/exp_corps/our_crate = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_crate.icon), icon_state = initial(our_crate.icon_state))
		option.info = span_boldnotice("[initial(our_crate.loadout_desc)]")

		options[our_crate] = option

	sort_list(options)

	return options

/obj/item/advanced_choice_beacon/nri/engineer
	name = "\improper NRI Defense Colleague engineering supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/engineer/defense, /obj/structure/closet/crate/secure/weapon/nri/engineer/offense)

/obj/item/advanced_choice_beacon/nri/heavy
	name = "\improper NRI Defense Colleague heavy armaments supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/heavy/defense,/obj/structure/closet/crate/secure/weapon/nri/heavy/offense)

/obj/item/stack/sheet/mineral/sandbags/fifty
	amount = 50

/obj/item/storage/toolbox/emergency/turret/nri
	name = "NRI stationary defense deployment system"
	desc = "You feel a strange urge to hit this with a wrench."

/obj/item/storage/toolbox/emergency/turret/nri/PopulateContents()
	return null

/obj/item/storage/toolbox/emergency/turret/nri/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WRENCH && user.combat_mode)
		user.visible_message(span_danger("[user] bashes [src] with [I]!"), \
			span_danger("You bash [src] with [I]!"), null, COMBAT_MESSAGE_RANGE)
		playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
		var/obj/machinery/porta_turret/syndicate/pod/toolbox/nri/turret = new(get_turf(loc))
		turret.faction = list(FACTION_STATION)
		qdel(src)

	..()

/obj/machinery/porta_turret/syndicate/pod/toolbox/nri
	stun_projectile = /obj/projectile/bullet/advanced/b9mm/rubber
	lethal_projectile = /obj/projectile/bullet/a762x39
	max_integrity = 150
	req_access = list(ACCESS_AWAY_SEC)
	faction = list(FACTION_STATION)
	shot_delay = 0.5

/mob/living/simple_animal/hostile/viscerator/nri
	faction = list(FACTION_STATION)

/obj/item/grenade/spawnergrenade/manhacks/nri
	name = "viscerator delivery grenade"
	spawner_type = /mob/living/simple_animal/hostile/viscerator/nri
	deliveryamt = 10

/obj/structure/closet/crate/secure/weapon/nri
	name = "military supplies crate"
	desc = "A secure military-grade crate. According to the markings, -as well as mixed Cyrillics-, it was shipped and provided by the NRI Defense Colleague."
	req_access = list(ACCESS_CENT_GENERAL)

//base, don't use this, but leaving it for admin spawns is probably a good call? (no because it's literally freaking empty lmfao)
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	return null

//defensive engineering loadout
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

//offensive heavy loadout
/obj/structure/closet/crate/secure/weapon/nri/heavy/offense/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pitbull/pulse/r40(src)
	new /obj/item/ammo_box/magazine/pulse/r40(src)
	new /obj/item/ammo_box/magazine/pulse/r40(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/plastikov9mm(src)
	new /obj/item/ammo_box/magazine/plastikov9mm(src)
	new /obj/item/ammo_box/magazine/plastikov9mm(src)
	new /obj/item/ammo_box/magazine/plastikov9mm(src)
	new /obj/item/grenade/frag(src)

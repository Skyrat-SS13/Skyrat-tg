/obj/machinery/computer/shuttle/trader
	name = "trader shuttle console"
	shuttleId = "tradership"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	possible_destinations = "tradership;tradership_custom;tradership_away;pirateship_away;pirateship_home;whiteship_away;whiteship_home;whiteship_z4;whiteship_lavaland"
	circuit = /obj/item/circuitboard/computer/trader_ship

/obj/machinery/computer/camera_advanced/shuttle_docker/trader
	name = "trader shuttle navigation computer"
	desc = "Used to designate a precise transit location for the trade shuttle."
	shuttleId = "tradership"
	shuttlePortId = "tradership_custom"
	view_range = 8
	x_offset = -6
	y_offset = -10
	see_hidden = FALSE
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	jump_to_ports = list("tradership" = 1, "tradership_away" = 1, "tradership_custom" = 1,"whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "caravantrade1_ambush" = 1, "whiteship_lavaland" = 1)
	whitelist_turfs = list(/turf/open/space, /turf/open/floor/plating, /turf/open/lava, /turf/closed/mineral)
	lock_override = NONE

/obj/item/circuitboard/computer/trader_ship
	build_path = /obj/machinery/computer/shuttle/trader

/obj/docking_port/mobile/tradership
	name = "trade shuttle"
	shuttle_id = "tradership"
	rechargeTime = 2 MINUTES

/obj/docking_port/stationary/picked/tradership
	name = "Deep Space"
	shuttle_id = "tradership_away"
	dheight = 0
	dir = 2
	dwidth = 11
	height = 22
	width = 35
	shuttlekeys = list("tradership")

/obj/structure/closet/crate/tradership_cargo
	/// Determines which items will be spawned, overriding itemspawn_seed
	var/used_preset
	/// Determines which items will be spawned
	var/itemspawn_seed

/obj/structure/closet/crate/tradership_cargo/Initialize(mapload)
	itemspawn_seed = used_preset || rand(1,5)
	return ..()

//Generic inventory
/obj/structure/closet/crate/tradership_cargo/PopulateContents()
	..()

	switch(itemspawn_seed)
		if(1)
			for(var/i in 1 to 10)
				new /obj/item/food/canned/beans(src)
			for(var/i in 1 to 10)
				new /obj/item/reagent_containers/cup/glass/waterbottle(src)
		if(2)
			new /obj/item/stack/sheet/iron/fifty(src)
			new /obj/item/stack/rods/fifty(src)
			new /obj/item/stack/sheet/glass/fifty(src)
			new /obj/item/stack/sheet/mineral/wood/fifty(src)
			new /obj/item/stack/cable_coil(src)
		if(3)
			for(var/i in 1 to 5)
				new /obj/item/tank/internals/emergency_oxygen/engi(src)
			new /obj/item/tank/internals/oxygen(src)
			new /obj/item/tank/internals/nitrogen(src)
			new /obj/item/tank/internals/nitrogen/belt/full(src)
			new /obj/item/tank/internals/plasma(src)
			new /obj/item/tank/internals/plasmaman/belt/full(src)
			for(var/i in 1 to 7)
				new /obj/item/clothing/mask/breath()
			desc = "An internals crate."
			name = "internals crate"
			icon_state = "o2crate"
		if(4)
			new /obj/item/storage/medkit/regular(src)
			new /obj/item/storage/medkit/o2(src)
			new /obj/item/storage/medkit/toxin(src)
			new /obj/item/reagent_containers/hypospray/medipen(src)
			new /obj/item/reagent_containers/hypospray/medipen/ekit(src)
			desc = "A medical crate."
			name = "medical crate"
			icon_state = "medicalcrate"
		if(5)
			new /obj/item/storage/toolbox/artistic(src)
			new /obj/item/storage/toolbox/electrical(src)
			new /obj/item/storage/toolbox/electrical(src)
			new /obj/item/storage/toolbox/mechanical(src)
			new /obj/item/storage/toolbox/mechanical(src)
			name = "engineering crate"
			icon_state = "engi_crate"

// traitor objective items
/obj/structure/closet/crate/tradership_cargo/populate_contents_immediate()
	. = ..()

	switch(itemspawn_seed)
		if(5)
			new /obj/item/clothing/gloves/color/yellow(src)
			new /obj/item/clothing/gloves/color/yellow(src)

/obj/structure/closet/crate/freezer/tradership_cargo_freezer
	var/used_preset

/obj/structure/closet/crate/freezer/tradership_cargo_freezer/PopulateContents()
	. = ..()
	var/random = used_preset || rand(1,4)
	switch(random)
		if(1)
			new /obj/item/reagent_containers/blood(src)
			new /obj/item/reagent_containers/blood(src)
			new /obj/item/reagent_containers/blood/a_minus(src)
			new /obj/item/reagent_containers/blood/b_minus(src)
			new /obj/item/reagent_containers/blood/b_plus(src)
			new /obj/item/reagent_containers/blood/o_minus(src)
			new /obj/item/reagent_containers/blood/o_plus(src)
			new /obj/item/reagent_containers/blood/lizard(src)
			new /obj/item/reagent_containers/blood/ethereal(src)
			for(var/i in 1 to 3)
				new /obj/item/reagent_containers/blood/random(src)
		if(2)
			new /obj/item/bodypart/arm/left/robot(src)
			new /obj/item/bodypart/arm/left/robot(src)
			new /obj/item/bodypart/arm/right/robot(src)
			new /obj/item/bodypart/arm/right/robot(src)
			new /obj/item/bodypart/leg/left/robot(src)
			new /obj/item/bodypart/leg/left/robot(src)
			new /obj/item/bodypart/leg/right/robot(src)
			new /obj/item/bodypart/leg/right/robot(src)
		if(3)
			for(var/i in 1 to 6)
				new /obj/item/storage/box/ingredients/wildcard(src)
		if(4)
			new /obj/item/food/meat/slab/human/mutant/slime(src)
			new /obj/item/food/meat/slab/killertomato(src)
			new /obj/item/food/meat/slab/bear(src)
			new /obj/item/food/meat/slab/xeno(src)
			new /obj/item/food/meat/slab/spider(src)
			new /obj/item/food/meat/rawbacon(src)
			new /obj/item/food/meat/slab/penguin(src)
			new /obj/item/food/spiderleg(src)
			new /obj/item/food/fishmeat/carp(src)
			new /obj/item/food/meat/slab/human(src)

/obj/structure/closet/crate/secure/tradership_cargo_valuable
	req_access = ACCESS_FACTION_CREW
	var/used_preset

/obj/structure/closet/crate/secure/tradership_cargo_valuable/PopulateContents()
	. = ..()
	var/random = used_preset || rand(1,5)
	switch(random)
		if(1) //Random traitor items
			new /obj/item/storage/box/syndie_kit/chameleon(src)
			new /obj/item/storage/backpack/duffelbag/syndie/c4(src)
			new /obj/item/computer_disk/syndicate/camera_app(src)
			new /obj/item/gun/chem(src)
			new /obj/item/card/emag(src)
			new /obj/item/card/emag/doorjack(src)
			new /obj/item/gun/medbeam(src)
			new /obj/item/healthanalyzer/rad_laser(src)
			new /obj/item/pen/sleepy(src)
			new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
		if(2) //Energy weapons + energy knives
			new /obj/item/gun/energy/e_gun(src)
			new /obj/item/gun/energy/e_gun(src)
			new /obj/item/gun/energy/e_gun(src)
			new /obj/item/gun/energy/e_gun/mini(src)
			new /obj/item/gun/energy/recharge/ebow(src)
			new /obj/item/melee/energy/sword(src)
			new /obj/item/melee/energy/sword(src)
		if(3) //Ballistics + knives
			new /obj/item/knife/combat(src)
			new /obj/item/knife/combat(src)
			new /obj/item/switchblade(src)
			new /obj/item/switchblade(src)
			new /obj/item/gun/ballistic/automatic/sol_smg(src)
			new /obj/item/gun/ballistic/automatic/sol_smg(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
				new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
			new /obj/item/gun/ballistic/automatic/akm(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/akm(src)
			new /obj/item/gun/ballistic/automatic/ppsh(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/ppsh(src)
			new /obj/item/gun/ballistic/automatic/stg(src)
			for(var/i in 1 to 2)
				new /obj/item/ammo_box/magazine/stg(src)

		if(4) //MODsuits
			new /obj/item/mod/control/pre_equipped/mining(src)
			new /obj/item/mod/control/pre_equipped/engineering(src)
			new /obj/item/mod/control/pre_equipped/atmospheric(src)
			new /obj/item/mod/control/pre_equipped/research(src)
			new /obj/item/mod/control/pre_equipped/traitor(src)
			new /obj/item/mod/control/pre_equipped/elite(src)
		if(5) //Implants
			new /obj/item/storage/box/cyber_implants(src)
			new /obj/item/organ/internal/cyberimp/arm/combat(src)
			new /obj/item/organ/internal/cyberimp/arm/surgery(src)
			new /obj/item/organ/internal/cyberimp/arm/baton(src)
			new /obj/item/organ/internal/cyberimp/arm/toolset(src)
			new /obj/item/organ/internal/cyberimp/arm/gun/taser(src)

/obj/structure/closet/crate/secure/tradership_cargo_very_valuable
	req_access = ACCESS_FACTION_COMMAND
	icon_state = "weaponcrate"
	var/used_preset

/obj/structure/closet/crate/secure/tradership_cargo_very_valuable/PopulateContents()
	. = ..()
	var/random = used_preset || rand(1,1)
	switch(random)
		if(1) //45 TC, but no uplink. Better find a cantor
			new /obj/item/stack/telecrystal/twenty(src)
			new /obj/item/stack/telecrystal/twenty(src)
			new /obj/item/stack/telecrystal/five(src)

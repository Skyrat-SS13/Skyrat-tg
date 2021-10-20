#define SUPPLY_BOX_WOOD 1
#define SUPPLY_BOX_METAL 2
#define SUPPLY_BOX_MILITARY 3

/// Supply box used for hauling/selling/buying cargo. It can be pried open to spawn related loot aswell
/obj/structure/supplies_box
	name = "supplies box"
	icon = 'modular_skyrat/modules/trading/icons/supplies_box.dmi'
	icon_state = "wodden_supply"
	anchored = FALSE
	density = TRUE
	max_integrity = 100
	/// Type of the material the supply box will drop
	var/material_drop
	/// Amount of the material the supply box will drop
	var/material_drop_amount
	/// The type of the supply box
	var/supply_box_type = SUPPLY_BOX_WOOD
	/// Name of the sticker overlay
	var/sticker_overlay = "empty"
	/// Loot sheet of the supply box
	var/supply_box_loot_sheet

/obj/structure/supplies_box/Initialize()
	. = ..()
	AddElement(/datum/element/climbable, climb_time = 2 SECONDS, climb_stun = 0)
	switch(supply_box_type)
		if(SUPPLY_BOX_WOOD)
			max_integrity = 100
			material_drop = /obj/item/stack/sheet/mineral/wood
			material_drop_amount = 4
			icon_state = "wodden_supply"
		if(SUPPLY_BOX_METAL, SUPPLY_BOX_MILITARY)
			max_integrity = 200
			material_drop = /obj/item/stack/sheet/plasteel
			material_drop_amount = 2
			if(supply_box_type == SUPPLY_BOX_MILITARY)
				icon_state = "mil_supply"
			else
				icon_state = "metal_supply"
	update_appearance()

/obj/structure/supplies_box/update_overlays()
	. = ..()
	. += sticker_overlay

/obj/structure/supplies_box/deconstruct(disassembled = TRUE, mob/user)
	drop_loot()
	return ..()

/obj/structure/supplies_box/attackby(obj/item/attacking_item, mob/user, params)
	if(attacking_item.tool_behaviour == TOOL_WRENCH)
		if(isinspace() && !anchored)
			return
		set_anchored(!anchored)
		attacking_item.play_tool_sound(src, 75)
		user.visible_message(span_notice("[user] [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
						span_notice("You [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
						span_hear("You hear a ratchet."))
		return TRUE
	else if(attacking_item.tool_behaviour == TOOL_CROWBAR)
		to_chat(user, span_notice("You start prying open \the [src]..."))
		if(attacking_item.use_tool(src, user, 2 SECONDS, volume = 75))
			user.visible_message(span_notice("[user] pries open \the [src]."), \
							span_notice("You pry open \the [src]."), \
							span_hear("You hear a crack."))
			drop_loot()
			qdel(src)
		return TRUE
	return ..()

/obj/structure/supplies_box/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("It is <b>bolted</b> to the ground.")
	else
		. += span_notice("You could <b>bolt</b> it to the ground with a <b>wrench</b>.")
	. += span_notice("You could <b>pry</b> it open.")

/obj/structure/supplies_box/ex_act(severity)
	if(severity >= EXPLODE_DEVASTATE)
		drop_loot()
		qdel(src)
	else
		. = ..()

/obj/structure/supplies_box/proc/drop_loot()
	var/turf/my_turf = get_turf(src)
	playsound(my_turf, 'sound/items/poster_ripped.ogg', 50, TRUE)
	if(material_drop)
		new material_drop(my_turf, material_drop_amount)
	var/datum/supplies_box_loot/sheet = new supply_box_loot_sheet()
	sheet.spawn_loot(my_turf)
	qdel(sheet)

/obj/structure/supplies_box/food
	name = "food supplies box"
	desc = "A supplies box containing a variety of preserved foods."
	supply_box_type = SUPPLY_BOX_WOOD
	sticker_overlay = "food"
	supply_box_loot_sheet = /datum/supplies_box_loot/food

/obj/structure/supplies_box/materials
	name = "materials supplies box"
	desc = "A supplies box containing some construction materials."
	supply_box_type = SUPPLY_BOX_WOOD
	sticker_overlay = "mats"
	supply_box_loot_sheet = /datum/supplies_box_loot/materials

/obj/structure/supplies_box/engineering
	name = "engineering supplies box"
	desc = "A supplies box containing useful tools."
	supply_box_type = SUPPLY_BOX_METAL
	sticker_overlay = "engi"
	supply_box_loot_sheet = /datum/supplies_box_loot/engineering

/obj/structure/supplies_box/medical
	name = "medical supplies box"
	desc = "A supplies box containing basic medicines."
	supply_box_type = SUPPLY_BOX_METAL
	sticker_overlay = "med"
	supply_box_loot_sheet = /datum/supplies_box_loot/medical

/obj/structure/supplies_box/security
	name = "security supplies box"
	desc = "A supplies box containing security gear."
	supply_box_type = SUPPLY_BOX_METAL
	sticker_overlay = "sec"
	supply_box_loot_sheet = /datum/supplies_box_loot/security

/obj/structure/supplies_box/military
	name = "military supplies box"
	desc = "A supplies box containing instruments of war."
	supply_box_type = SUPPLY_BOX_MILITARY
	sticker_overlay = "mil"
	supply_box_loot_sheet = /datum/supplies_box_loot/military

#undef SUPPLY_BOX_WOOD
#undef SUPPLY_BOX_METAL
#undef SUPPLY_BOX_MILITARY

///Utilitarian "cold" datum to spawn the loot, for memory optimisation
/datum/supplies_box_loot
	/// A list of all guaranteed spawns from this sheet
	var/list/guaranteed_spawns
	/// A list of weighted spawns from this sheet, they will be picked and taken
	var/list/weighted_spawns
	/// Amount of weighted spawns to roll
	var/weighted_spawns_amount

/datum/supplies_box_loot/proc/spawn_loot(turf/location)
	for(var/spawn_type in guaranteed_spawns)
		new spawn_type(location)
	if(!weighted_spawns_amount)
		return
	for(var/i in 1 to weighted_spawns_amount)
		var/picked_type = pick_weight(weighted_spawns)
		new picked_type(location)
		weighted_spawns -= picked_type
		if(!weighted_spawns.len)
			break

/datum/supplies_box_loot/food
	guaranteed_spawns = list(
		/obj/item/reagent_containers/food/condiment/flour,
		/obj/item/reagent_containers/food/condiment/rice,
		/obj/item/reagent_containers/food/condiment/milk,
		/obj/item/reagent_containers/food/condiment/soymilk,
		/obj/item/reagent_containers/food/condiment/enzyme,
		/obj/item/reagent_containers/food/condiment/sugar,
		/obj/item/food/meat/slab/monkey,
		/obj/item/storage/fancy/egg_box
		)
	weighted_spawns = list(
		/obj/item/storage/box/ingredients/fiesta = 100,
		/obj/item/storage/box/ingredients/italian = 100,
		/obj/item/storage/box/ingredients/vegetarian = 100,
		/obj/item/storage/box/ingredients/american = 100,
		/obj/item/storage/box/ingredients/fruity = 100,
		/obj/item/storage/box/ingredients/sweets = 100,
		/obj/item/storage/box/ingredients/delights = 100,
		/obj/item/storage/box/ingredients/grains = 100,
		/obj/item/storage/box/ingredients/carnivore = 100,
		/obj/item/storage/box/ingredients/exotic = 100
		)
	weighted_spawns_amount = 2

/datum/supplies_box_loot/materials
	guaranteed_spawns = list(
		/obj/item/stack/sheet/iron{amount = 50},
		/obj/item/stack/sheet/glass{amount = 40}
		)
	weighted_spawns = list(
		/obj/item/stack/sheet/mineral/silver{amount = 10} = 15,
		/obj/item/stack/sheet/mineral/diamond{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/uranium{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/plasma{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/titanium{amount = 5} = 10,
		/obj/item/stack/sheet/mineral/gold{amount = 5} = 10,
		/obj/item/stack/ore/bluespace_crystal{amount = 2} = 2
	)
	weighted_spawns_amount = 1

/datum/supplies_box_loot/engineering
	guaranteed_spawns = list(
		/obj/item/storage/toolbox/mechanical,
		/obj/item/storage/toolbox/electrical
		)
	weighted_spawns = list(
		/obj/item/wrench = 10,
		/obj/item/screwdriver = 10,
		/obj/item/weldingtool = 10,
		/obj/item/crowbar = 10,
		/obj/item/wirecutters = 10,
		/obj/item/flashlight = 20,
		/obj/item/weldingtool/largetank = 10,
		/obj/item/analyzer = 10,
		/obj/item/t_scanner = 20,
		/obj/item/multitool = 40,
		/obj/item/assembly/flash/handheld = 20,
		/obj/item/clothing/gloves/color/yellow = 20,
		/obj/item/clothing/gloves/color/fyellow = 20,
		/obj/item/stock_parts/cell/upgraded = 20
		)
	weighted_spawns_amount = 4

/datum/supplies_box_loot/medical
	guaranteed_spawns = list(/obj/item/storage/firstaid/regular)
	weighted_spawns = list(
		/obj/item/stack/medical/bruise_pack = 5,
		/obj/item/stack/medical/ointment= 5,
		/obj/item/reagent_containers/hypospray/medipen = 5,
		/obj/item/stack/medical/gauze/twelve = 5,
		/obj/item/stack/medical/splint/twelve = 5,
		/obj/item/stack/medical/suture = 5,
		/obj/item/stack/medical/mesh = 5,
		/obj/item/storage/pill_bottle/mining = 1,
		/obj/item/storage/pill_bottle/mannitol = 1,
		/obj/item/storage/pill_bottle/iron = 5,
		/obj/item/storage/pill_bottle/probital = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/storage/pill_bottle/mutadone = 1,
		/obj/item/storage/pill_bottle/epinephrine = 5,
		/obj/item/storage/pill_bottle/multiver = 5
	)
	weighted_spawns_amount = 3

/datum/supplies_box_loot/security
	guaranteed_spawns = list(
		/obj/item/melee/baton/security/loaded,
		/obj/item/restraints/handcuffs/cable/zipties
		)
	weighted_spawns = list(
		/obj/item/assembly/flash/handheld = 10,
		/obj/item/reagent_containers/spray/pepper = 10,
		/obj/item/grenade/flashbang = 10,
		/obj/item/storage/fancy/donut_box = 10
		)
	weighted_spawns_amount = 2

/datum/supplies_box_loot/military
	guaranteed_spawns = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/switchblade,
		/obj/item/storage/firstaid/regular
		)
	weighted_spawns = list(
		/obj/item/ammo_box/magazine/m9mm = 10,
		/obj/effect/spawner/random/grenade = 10,
		/obj/effect/spawner/random/tactical_gear = 10
		)
	weighted_spawns_amount = 1

/obj/effect/spawner/supplies_box
	icon = 'modular_skyrat/modules/trading/icons/supplies_box.dmi'
	icon_state = "random"
	name = "spawn random supplies box"
	var/list/boxes_to_choose_from = list(
		/obj/structure/supplies_box/food,
		/obj/structure/supplies_box/materials,
		/obj/structure/supplies_box/engineering,
		/obj/structure/supplies_box/medical,
		/obj/structure/supplies_box/security,
		/obj/structure/supplies_box/military
		)

/obj/effect/spawner/supplies_box/Initialize(mapload)
	..()

	var/picked_type = pick(boxes_to_choose_from)
	new picked_type(loc)

	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/supplies_box/common
	name = "spawn random common supplies box"
	icon_state = "random_common"
	boxes_to_choose_from = list(
		/obj/structure/supplies_box/food,
		/obj/structure/supplies_box/materials,
		/obj/structure/supplies_box/engineering,
		/obj/structure/supplies_box/medical
		)

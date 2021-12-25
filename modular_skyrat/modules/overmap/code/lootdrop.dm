/// One random selection of some materials, heavily weighted for common drops
/obj/effect/spawner/random/material
	spawn_loot_count = 1
	loot = list(
		/obj/item/stack/sheet/iron{amount = 15} = 50,
		/obj/item/stack/sheet/glass{amount = 15} = 15,
		/obj/item/stack/sheet/mineral/silver{amount = 10} = 15,
		/obj/item/stack/sheet/mineral/diamond{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/uranium{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/plasma{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/titanium{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/gold{amount = 5} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)

//Really low amounts/chances of materials
/obj/effect/spawner/random/material_scarce
	spawn_loot_count = 1
	loot = list(
		/obj/item/stack/sheet/iron{amount = 5} = 60,
		/obj/item/stack/sheet/glass{amount = 5} = 20,
		/obj/item/stack/sheet/mineral/silver{amount = 3} = 15,
		/obj/item/stack/sheet/mineral/diamond{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/uranium{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/plasma{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/titanium{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/gold{amount = 2} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 1
	)

/// One random selection of some ore, heavily weighted for common drops
/obj/effect/spawner/random/ore
	spawn_loot_count = 1
	loot = list(
		/obj/item/stack/ore/iron{amount = 15} = 50,
		/obj/item/stack/ore/glass{amount = 15} = 15,
		/obj/item/stack/ore/silver{amount = 10} = 15,
		/obj/item/stack/ore/diamond{amount = 5} = 5,
		/obj/item/stack/ore/uranium{amount = 5} = 5,
		/obj/item/stack/ore/plasma{amount = 5} = 5,
		/obj/item/stack/ore/titanium{amount = 5} = 5,
		/obj/item/stack/ore/gold{amount = 5} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)

/obj/effect/spawner/random/ore_scarce
	spawn_loot_count = 1
	loot = list(
		/obj/item/stack/ore/iron{amount = 5} = 50,
		/obj/item/stack/ore/glass{amount = 5} = 15,
		/obj/item/stack/ore/silver{amount = 3} = 15,
		/obj/item/stack/ore/diamond{amount = 2} = 5,
		/obj/item/stack/ore/uranium{amount = 2} = 5,
		/obj/item/stack/ore/plasma{amount = 2} = 5,
		/obj/item/stack/ore/titanium{amount = 2} = 5,
		/obj/item/stack/ore/gold{amount = 2} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)

/obj/effect/spawner/random/tool
	name = "tool spawner"
	loot = list(
		/obj/item/wrench = 1,
		/obj/item/screwdriver = 1,
		/obj/item/weldingtool = 1,
		/obj/item/crowbar = 1,
		/obj/item/wirecutters = 1,
		/obj/item/flashlight = 1,
		/obj/item/weldingtool/largetank = 1,
		/obj/item/multitool = 1
	)

/obj/effect/spawner/random/scanner
	name = "scanner spawner"
	loot = list(
		/obj/item/mining_scanner = 1,
		/obj/item/t_scanner = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/analyzer = 1,
		/obj/item/radio = 1
	)

/obj/effect/spawner/random/powercell
	name = "powercell spawner"
	loot = list(
		/obj/item/stock_parts/cell = 1,
		/obj/item/stock_parts/cell/crap = 1,
		/obj/item/stock_parts/cell/upgraded = 1,
		/obj/item/stock_parts/cell/upgraded/plus = 1,
		/obj/item/stock_parts/cell/high = 1
	)

/obj/effect/spawner/random/bomb_supply
	name = "bomb supply spawner"
	loot = list(
		/obj/item/assembly/igniter = 1,
		/obj/item/assembly/prox_sensor = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/assembly/timer = 1
	)

/obj/effect/spawner/random/toolbox
	name = "toolbox spawner"
	loot = list(
		/obj/item/storage/toolbox/mechanical = 20,
		/obj/item/storage/toolbox/emergency = 20,
		/obj/item/storage/toolbox/electrical = 20,
		/obj/item/storage/toolbox/syndicate = 1
	)

/obj/effect/spawner/random/tech_supply
	name = "tech supply spawner"
	loot = list(
		/obj/effect/spawner/random/toolbox = 1,
		/obj/effect/spawner/random/bomb_supply = 1,
		/obj/effect/spawner/random/powercell = 1,
		/obj/effect/spawner/random/scanner = 1,
		/obj/effect/spawner/random/tool = 1,
		/obj/item/storage/belt/utility = 1,
		/obj/item/clothing/gloves/color/yellow = 1,
		/obj/item/clothing/gloves/color/fyellow = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/assembly/flash = 1
	)

/obj/effect/spawner/random/tech_supply/five
	name = "5x tech supply spawner"
	spawn_random_offset = TRUE
	spawn_loot_count = 5

/obj/effect/spawner/random/medical/equipment
	name = "medical equipment spawner"
	loot = list(
		/obj/effect/spawner/random/medical/medicine/five = 1,
		/obj/effect/spawner/random/medical/medkit = 1,
		/obj/item/bodybag = 1,
		/obj/machinery/iv_drip = 1,
		/obj/structure/closet/crate/freezer/blood = 1,
		/obj/structure/closet/crate/freezer/surplus_limbs = 1,
		/obj/item/storage/backpack/duffelbag/med/surgery = 1,
		/obj/item/storage/organbox = 1
	)

/obj/effect/spawner/random/medical/medicine
	name = "medicine spawner"
	loot = list(
		/obj/item/stack/medical/bruise_pack = 5,
		/obj/item/stack/medical/ointment= 5,
		/obj/item/reagent_containers/hypospray/medipen = 5,
		/obj/item/stack/medical/gauze/twelve = 5,
		/obj/item/stack/medical/splint/twelve = 5,
		/obj/item/stack/medical/suture = 5,
		/obj/item/stack/medical/mesh = 5,
		/obj/effect/spawner/random/toolbox = 1,
		/obj/item/storage/pill_bottle/mining = 1,
		/obj/item/storage/pill_bottle/mannitol = 1,
		/obj/item/storage/pill_bottle/iron = 5,
		/obj/item/storage/pill_bottle/probital = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/storage/pill_bottle/mutadone = 1,
		/obj/item/storage/pill_bottle/epinephrine = 5,
		/obj/item/storage/pill_bottle/multiver = 5
	)

/obj/effect/spawner/random/medical/medicine/five
	name = "5x medicine spawner"
	spawn_random_offset = TRUE
	spawn_loot_count = 5

/obj/effect/spawner/random/medical/medkit
	name = "medkit spawner"
	loot = list(
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/storage/firstaid/emergency = 1,
		/obj/item/storage/firstaid/fire = 1,
		/obj/item/storage/firstaid/toxin = 1,
		/obj/item/storage/firstaid/o2 = 1,
		/obj/item/storage/firstaid/brute = 1
	)

/obj/effect/spawner/random/modsuit
	name = "modsuit spawner"
	loot = list(
		/obj/item/mod/control/pre_equipped/security = 1,
		/obj/item/mod/control/pre_equipped/mining = 1,
		/obj/item/mod/control/pre_equipped/medical = 1,
		/obj/item/mod/control/pre_equipped/engineering = 1
	)

/obj/effect/spawner/random/contraband/overmap
	name = "contraband spawner"
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol = 1,
		/obj/item/switchblade = 3,
		/obj/item/poster/random_contraband = 1,
		/obj/item/food/grown/cannabis = 1,
		/obj/item/food/grown/cannabis/rainbow = 1,
		/obj/item/food/grown/cannabis/white = 1,
		/obj/item/storage/box/fireworks/dangerous = 1,
		/obj/item/storage/pill_bottle/zoom = 1,
		/obj/item/storage/pill_bottle/happy = 1,
		/obj/item/storage/pill_bottle/lsd = 1,
		/obj/item/storage/pill_bottle/aranesp = 1,
		/obj/item/storage/pill_bottle/stimulant = 1,
		/obj/item/toy/cards/deck/syndicate = 1,
		/obj/item/reagent_containers/food/drinks/bottle/absinthe = 1,
		/obj/item/clothing/under/syndicate/tacticool = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_shadyjims = 1,
		/obj/item/clothing/mask/gas/syndicate = 1,
		/obj/item/clothing/neck/necklace/dope = 1,
		/obj/item/melee/baton/security/cattleprod = 1
	)

/obj/effect/spawner/random/alcohol_bottle
	name = "alcohol bottle spawner"
	loot = list(
		/obj/item/reagent_containers/food/drinks/bottle/gin = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka = 1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/bottle/rum = 1,
		/obj/item/reagent_containers/food/drinks/bottle/maltliquor = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vermouth = 1,
		/obj/item/reagent_containers/food/drinks/bottle/goldschlager = 1,
		/obj/item/reagent_containers/food/drinks/bottle/cognac = 1,
		/obj/item/reagent_containers/food/drinks/bottle/wine = 1,
		/obj/item/reagent_containers/food/drinks/bottle/absinthe = 1,
		/obj/item/reagent_containers/food/drinks/bottle/kahlua = 1
	)

/obj/effect/spawner/random/energy_weapon
	name = "energy weapon spawner"
	loot = list(
		/obj/item/gun/energy/e_gun = 1,
		/obj/item/gun/energy/e_gun/mini = 1,
		/obj/item/gun/energy/laser/hellgun = 1,
		/obj/item/gun/energy/e_gun/nuclear = 1,
		/obj/item/gun/energy/taser = 1
	)

/obj/effect/spawner/random/ballistic_weapon
	name = "ballistic weapon spawner"
	loot = list(
		/obj/item/gun/ballistic/automatic/assault_rifle/akm,
		/obj/item/gun/ballistic/automatic/assault_rifle/m16,
		/obj/item/gun/ballistic/shotgun/sas14 = 1,
	)

/obj/effect/spawner/random/handgun
	name = "handgun spawner"
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/automag = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/gun/energy/e_gun/mini = 1
	)

/obj/effect/spawner/random/melee_weapon
	name = "melee weapon spawner"
	loot = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/switchblade = 1,
		/obj/item/knife/combat/survival = 1
	)

/obj/effect/spawner/random/tactical_gear
	name = "tactical gear spawner"
	loot = list(
		/obj/item/clothing/glasses/night = 1,
		/obj/item/clothing/gloves/tackler/combat/insulated = 1,
		/obj/item/clothing/suit/armor/riot = 1,
		/obj/item/clothing/head/helmet/riot = 1
	)


/obj/effect/spawner/random/grenade
	name = "grenade spawner"
	loot = list(
		/obj/item/grenade/c4/x4 = 1,
		/obj/item/grenade/c4 = 1,
		/obj/item/grenade/frag = 1,
		/obj/item/grenade/flashbang = 1,
		/obj/item/grenade/empgrenade = 1
	)


/obj/effect/spawner/random/ammo
	name = "ammo spawner"
	loot = list(
		/obj/item/ammo_box/magazine/m9mm = 1,
		/obj/item/ammo_box/magazine/m45 = 1,
		/obj/item/ammo_box/magazine/m12g = 1,
		/obj/item/ammo_box/magazine/m12g/slug = 1
	)

/obj/effect/spawner/random/plushie
	name = "plushie spawner"
	loot = list(
		/obj/item/toy/plush/beeplushie = 1,
		/obj/item/toy/plush/moth = 1,
		/obj/item/toy/plush/borbplushie = 1,
		/obj/item/toy/plush/snakeplushie = 1,
		/obj/item/toy/plush/lizard_plushie/green = 1,
		/obj/item/toy/plush/lizard_plushie = 1,
		/obj/item/toy/plush/carpplushie = 1
	)

//Valueable loot dedicated for off-station ruins and facilities
/obj/effect/spawner/random/away_loot
	name = "away loot spawner"
	loot = list(
		/obj/effect/spawner/random/energy_weapon = 1,
		/obj/effect/spawner/random/ballistic_weapon = 1,
		/obj/effect/spawner/random/contraband/overmap = 1,
		/obj/effect/spawner/random/modsuit = 1,
		/obj/effect/spawner/random/medical/medicine/five = 1,
		/obj/effect/spawner/random/tech_supply/five = 1,
		/obj/effect/spawner/random/engineering/material_rare = 1,
		/obj/effect/spawner/random/melee_weapon = 1,
		/obj/effect/spawner/random/tactical_gear = 1,

/obj/effect/spawner/random/grenade = 1
	)

/obj/effect/spawner/random/eyewear
	name = "eyewear spawner"
	loot = list(
		/obj/item/clothing/glasses/meson = 1,
		/obj/item/clothing/glasses/science = 1,
		/obj/item/clothing/glasses/welding = 1,
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/glasses/sunglasses = 1
	)

/obj/effect/spawner/random/clothes
	name = "clothes spawner"
	loot = list(
		/obj/item/clothing/under/color/random = 1,
		/obj/item/clothing/under/color/grey = 1,
		/obj/item/clothing/under/misc/overalls = 1,
		/obj/item/clothing/under/misc/assistantformal = 1,
		/obj/item/clothing/under/suit/black = 1,
		/obj/item/clothing/under/suit/black/skirt = 1,
		/obj/item/clothing/under/suit/white = 1,
		/obj/item/clothing/under/suit/white/skirt = 1,
		/obj/item/clothing/under/suit/beige,
		/obj/item/clothing/under/pants/classicjeans = 1,
		/obj/item/clothing/under/pants/blackjeans = 1,
		/obj/item/clothing/under/pants/khaki = 1,
		/obj/item/clothing/under/pants/camo = 1,
		/obj/item/clothing/under/rank/civilian/bartender = 1,
		/obj/item/clothing/under/rank/civilian/bartender/skirt = 1
	)

/obj/effect/spawner/random/headgear
	name = "headgear spawner"
	loot = list(
		/obj/item/clothing/head/welding = 1,
		/obj/item/clothing/head/ushanka = 1,
		/obj/item/clothing/head/soft/grey = 1,
		/obj/item/clothing/head/soft/black = 1,
		/obj/item/clothing/head/chefhat = 1,
		/obj/item/clothing/head/beret = 1,
		/obj/item/clothing/head/beret/black = 1,
		/obj/item/clothing/head/fedora/curator = 1,
		/obj/item/clothing/head/helmet/old = 1,
		/obj/item/clothing/head/bandana = 1
	)

/obj/effect/spawner/random/gloves
	name = "gloves spawner"
	loot = list(
		/obj/item/clothing/gloves/color/black = 3,
		/obj/item/clothing/gloves/color/fyellow = 3,
		/obj/item/clothing/gloves/color/yellow = 1,
		/obj/item/clothing/gloves/color/grey = 3,
		/obj/item/clothing/gloves/fingerless = 3,
		/obj/item/clothing/gloves/color/light_brown = 3,
		/obj/item/clothing/gloves/color/brown = 3
	)

/obj/effect/spawner/random/gloves
	name = "shoes spawner"
	loot = list(
		/obj/item/clothing/shoes/sneakers/black = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
		/obj/item/clothing/shoes/sneakers/blue = 1,
		/obj/item/clothing/shoes/jackboots = 1
	)

/obj/effect/spawner/random/suit
	name = "suit spawner"
	loot = list(
		/obj/item/clothing/suit/toggle/labcoat = 1,
		/obj/item/clothing/suit/pirate = 1,
		/obj/item/clothing/suit/poncho = 1,
		/obj/item/clothing/suit/jacket/letterman = 1,
		/obj/item/clothing/suit/toggle/chef = 1,
		/obj/item/clothing/suit/hooded/wintercoat = 1,
		/obj/item/clothing/suit/hooded/wintercoat/aformal = 1
	)

/obj/effect/spawner/random/casht
	name = "cash spawner"
	loot = list(
		/obj/item/stack/spacecash/c1 = 4,
		/obj/item/stack/spacecash/c10 = 4,
		/obj/item/stack/spacecash/c20 = 4,
		/obj/item/stack/spacecash/c50 = 3,
		/obj/item/stack/spacecash/c100 = 2,
		/obj/item/stack/spacecash/c200 = 2,
		/obj/item/stack/spacecash/c500 = 1,
		/obj/item/stack/spacecash/c1000 = 1
	)

/obj/effect/spawner/random/casht/five
	name = "5x cash spawner"
	spawn_random_offset = TRUE
	spawn_loot_count = 5

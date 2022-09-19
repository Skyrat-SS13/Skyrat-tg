#define LOOT_MINIMUM_AMOUNT 4
#define LOOT_MAXIMUM_AMOUNT 8

/obj/structure/closet/crate/secure/loot/outbound_cargo
	name = "sealed crate"
	desc = "A weathered, pressure-sealed container."
	req_access = (ACCESS_SYNDICATE)
	light_range = 1
	light_power = 2
	/// Assoc list of lists for loot, no cats here, sorry
	var/static/list/loot_cats = list(
		"nri" = list( // thematic but decently powerful
			/obj/item/gun/ballistic/automatic/pistol/ladon/nri = 1,
			/obj/item/storage/box/nri_flares = 2,
			/obj/item/storage/box/nri_rations = 2,
			/obj/item/storage/box/nri_pens = 1,
			/obj/item/ammo_box/magazine/m9mm_aps = 2,
			/obj/item/gun/ballistic/automatic/plastikov = 1,
			/obj/item/ammo_box/magazine/plastikov9mm = 2,
			/obj/item/clothing/under/costume/nri = 3,
			/obj/item/clothing/head/helmet/rus_helmet = 3,
			/obj/item/clothing/suit/armor/vest/russian = 2,
			/obj/item/storage/belt/military/nri = 3,
		),
		"survivalist" = list( // meh strength
			/obj/item/gun/ballistic/shotgun/doublebarrel = 1,
			/obj/item/storage/box/ammo_box/shotgun_12g = 2,
			/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
			/obj/item/ammo_box/magazine/m45 = 2,
			/obj/item/storage/box/expeditionary_survival = 3,
			/obj/item/storage/box/donkpockets = 2,
			/obj/item/clothing/suit/armor/vest = 2,
			/obj/item/storage/box/hecu_rations = 2,
			/obj/item/storage/box/mothic_rations = 2,
			/obj/item/ammo_box/advanced/s12gauge/buckshot = 2,
		),
		"robotics" = list( // pretty powerful but requires someone else to work on the person
			/obj/item/organ/internal/heart/cybernetic/tier2 = 2,
			/obj/item/organ/internal/heart/cybernetic/tier3 = 1,
			/obj/item/organ/internal/eyes/night_vision/cyber = 1,
			/obj/item/organ/internal/lungs/cybernetic/tier2 = 2,
			/obj/item/organ/internal/lungs/cybernetic/tier3 = 1,
			/obj/item/organ/internal/cyberimp/arm/hacker = 2,
			/obj/item/organ/internal/cyberimp/arm/armblade = 1,
			/obj/item/organ/internal/cyberimp/arm/surgery = 2,
			/obj/item/organ/internal/cyberimp/arm/toolset = 2,
			/obj/item/organ/internal/cyberimp/arm/gun/laser = 1,
			/obj/item/organ/internal/cyberimp/eyes/hud/medical = 2,
			/obj/item/organ/internal/cyberimp/brain/anti_drop = 1,
			/obj/item/organ/internal/cyberimp/brain/anti_stun = 1,
			/obj/item/organ/internal/cyberimp/chest/nutriment = 2,
		),
		"syndicate" = list( // kinda powerful, but it's mostly the "muh illegal" bit
			/obj/item/gun/ballistic/automatic/pistol = 1,
			/obj/item/ammo_box/magazine/m9mm = 2,
			/obj/item/storage/belt/holster/chameleon = 3,
			/obj/item/gun/syringe/syndicate = 1,
			/obj/item/grenade/c4 = 3,
			/obj/item/grenade/c4/x4 = 2,
			/obj/item/card/id/advanced/chameleon = 1,
			/obj/item/jammer = 1,
			/obj/item/storage/toolbox/infiltrator = 1,
			/obj/item/clothing/head/helmet/swat = 3,
			/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 3,
			/obj/item/storage/box/syndie_kit/chameleon/broken = 2, //quality not guaranteed
			/obj/item/mod/control/pre_equipped/traitor = 1,
		),
		"security" = list( // some good stuff with a bunch of junk
			/obj/item/gun/energy/disabler = 1,
			/obj/item/restraints/handcuffs = 2,
			/obj/item/clothing/suit/armor/vest/security = 2,
			/obj/item/storage/backpack/security = 3,
			/obj/item/grenade/flashbang = 2,
			/obj/item/clothing/under/rank/security/officer = 3,
			/obj/item/assembly/flash/handheld = 3,
			/obj/item/melee/baton/security = 3,
			/obj/item/gun/ballistic/automatic/pistol/g17 = 1,
			/obj/item/ammo_box/magazine/multi_sprite/g17 = 1,
			/obj/item/gun/ballistic/automatic/pistol/g18 = 1,
			/obj/item/ammo_box/magazine/multi_sprite/g18 = 1,
			/obj/item/gun/ballistic/shotgun/riot = 1,
			/obj/item/storage/box/ammo_box/shotgun_12g = 2,
			/obj/item/gun/ballistic/automatic/cmg = 1,
			/obj/item/ammo_box/magazine/multi_sprite/cmg/lethal = 1,
			/obj/item/ammo_box/magazine/multi_sprite/cmg/hp = 1,
			/obj/item/gun/energy/ionrifle = 1,
			/obj/item/clothing/gloves/tackler = 2,
		),
	)

/obj/structure/closet/crate/secure/loot/outbound_cargo/Initialize(mapload)
	. = ..()
	var/picked_color = pick(GLOB.marker_beacon_colors)
	set_light(light_range, light_power, GLOB.marker_beacon_colors[picked_color], TRUE)
	AddComponent(/datum/component/gps, "Encrypted Signal")

/obj/structure/closet/crate/secure/loot/outbound_cargo/spawn_loot()
	var/selected_type = pick(loot_cats)
	for(var/i in 1 to rand(LOOT_MINIMUM_AMOUNT, LOOT_MAXIMUM_AMOUNT))
		var/obj/item/picked_item = pick_weight(loot_cats[selected_type])
		new picked_item(src)
	spawned_loot = TRUE

#undef LOOT_MINIMUM_AMOUNT
#undef LOOT_MAXIMUM_AMOUNT

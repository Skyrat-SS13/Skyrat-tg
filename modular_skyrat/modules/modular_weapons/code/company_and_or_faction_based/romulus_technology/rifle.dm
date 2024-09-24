//Sprite for these guns are modified from the carwil/carwo rifle, they're a pallet swap with very small modification
//Main Rifle
/obj/item/gun/ballistic/automatic/rom_carbine
	name = "\improper RomTech Carbine"
	desc = "An unusual variation of the Carwo-Carwil Battle rifle fielded as service rifle in Romulus Federation, preferred by some law enforcement agency for the compact nature. Accepts any standard .40 SolFed rifle magazine."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun48x32.dmi'
	icon_state = "carbine"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_worn.dmi'
	worn_icon_state = "carbine"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_righthand.dmi'
	inhand_icon_state = "carbine"

	bolt_type = BOLT_TYPE_LOCKING

	special_mags = TRUE

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

	burst_size = 1
	fire_delay = 3

	spread = 7
	projectile_wound_bonus = -35

	accepted_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard

	actions_types = list()

/obj/item/gun/ballistic/automatic/rom_carbine/Initialize(mapload)
	. = ..()
	give_autofire()

/obj/item/gun/ballistic/automatic/rom_carbine/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/rom_carbine/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/rom_carbine/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/rom_carbine/examine_more(mob/user)
	. = ..()

	. += "This Design was made by Romulus Technology for \
		usage during the start of the NRI-Sol Border war. \
		Following the embargo and trade restriction \
		making it impossible for Romulus Federation to source weapory, \
		with this design being rapidly pushed out, being made from converted rifle making it easier to acquire, \
		this rifle seems rather unassuming but it has been, itself, the new symbol of peace  \
		Leaving NRI weapon in the past, as it now became the symbol of the oppressive era of Romulus\
		To whom it may concerns, These weapon were mostly used by the new Romulus National Army,\
		 it was a symbol of struggle and freedom \
		Weapons cannot bring people back, but it can save your life."

	return .

//Bolt Action Rifle
/obj/item/gun/ballistic/rifle/carwil
	name = "\improper RomTech Ceremonial Rifle"
	desc = "A boltaction ceremonial rifle, chambered in Sol .40 Rifle While technically outdated in modern arms markets, it still used by recreational hunter \
		as rifle of this kind are much more controllable. Famously used by the royal guard of Romulus Federation."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun48x32.dmi'
	icon_state = "elite"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_worn.dmi'
	worn_icon_state = "carbine"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_righthand.dmi'
	inhand_icon_state = "carbine"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/rifle_heavy.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_rifle.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/weapons/gun/sniper/rack.ogg'
	recoil = 2
	accepted_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	internal_magazine = FALSE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE
	tac_reloads = TRUE
	rack_delay = 1.5 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	special_mags = TRUE

/obj/item/gun/ballistic/rifle/carwil/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/rifle/carwil/empty
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/skyrat/ceremonial_rifle
	name = "Sporting Rifle Case"
	weapon_to_spawn = /obj/item/gun/ballistic/rifle/carwil/empty
	extra_to_spawn = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty

/obj/item/storage/toolbox/guncase/skyrat/ceremonial_rifle/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/c40sol/fragmentation = 1,
		/obj/item/ammo_box/c40sol = 1,
	), src)

//Flechette Rifle
//This Replace The Battle Rifle, handle with care please
//This is based on the old CMG Code from Hatterhat when he made it foldable, Dragonfruit made the sprite sometime ago and I'm using it as it's  easier than remaking new sprite from the ground up

/obj/item/gun/ballistic/automatic/rom_flech
	name = "\improper RomTech CMG-1 Rifle"
	desc = "The Compact Machinegun-1 is an automatic rifle fielded by the Romulus Expeditionary Force, chambered in an experimental flechette cartridge capable of defeating all type of conventional body armour. Has a folding stock"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun40x32.dmi'
	icon_state = "cmg1"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"
//placeeholder, I had to do this in a crunch hour.. sorry! - Kali
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie_evil"
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
	selector_switch_icon = TRUE
	burst_size = 2
	fire_delay = 2
	spread = 5
//	pin = /obj/item/firing_pin/alert_level this does work but it's a conceptual failure
	pin = /obj/item/firing_pin
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'

	accepted_magazine_type = /obj/item/ammo_box/magazine/caflechette
	spawn_magazine_type = /obj/item/ammo_box/magazine/caflechette
	var/folding_sound = 'sound/weapons/batonextend.ogg'
	/// is our stock collapsed?
	var/folded = FALSE
	/// how long does it take to extend/collapse the stock
	var/toggle_time = 1 SECONDS
	/// what's our spread with our extended stock (mild varedit compatibility I Guess)?
	var/unfolded_spread = 2
	/// what's our spread with a folded stock (see above comment)?
	var/folded_spread = 15
	/// Do we have any recoil if it's folded?
	var/folded_recoil = 3
	///Do we lose any recoil when it's not?
	var/unfolded_recoil = 0
	///Shuld this gun be one handed anyway?
	var/one_handed_always = TRUE
/obj/item/gun/ballistic/automatic/rom_flech/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt-click</b> to [folded ? "extend" : "collapse"] the stock.")

/obj/item/gun/ballistic/automatic/rom_flech/click_alt(mob/user)
	if(!user.is_holding(src))
		return
	if(item_flags & IN_STORAGE)
		return
	toggle_stock(user)

/obj/item/gun/ballistic/automatic/rom_flech/proc/toggle_stock(mob/user, var/forced)
	if(!user && forced)
		folded = !folded
		update_fold_stats()
		return
	balloon_alert(user, "[folded ? "extending" : "collapsing"] stock...")
	if(!do_after(user, toggle_time))
		balloon_alert(user, "interrupted!")
		return
	folded = !folded
	update_fold_stats()
	balloon_alert(user, "stock [folded ? "collapsed" : "extended"]")
	playsound(src.loc, folding_sound, 30, 1)

/obj/item/gun/ballistic/automatic/rom_flech/proc/update_fold_stats()
	if(folded)
		spread = folded_spread
		w_class = WEIGHT_CLASS_NORMAL
		recoil = folded_recoil
		weapon_weight = WEAPON_LIGHT
	else
		spread = unfolded_spread
		w_class = WEIGHT_CLASS_BULKY
		recoil = unfolded_recoil
		if(one_handed_always)
			weapon_weight = WEAPON_LIGHT
		else
			weapon_weight = WEAPON_HEAVY
	update_icon()

/obj/item/gun/ballistic/automatic/rom_flech/update_overlays()
	. = ..()
	. += "[icon_state]-stock[folded ? "_in" : "_out"]"

/obj/item/gun/ballistic/automatic/rom_flech/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/rom_flech/empty
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/skyrat/pistol/rom_flech
	name = "CMG-1 Rifle Case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/rom_flech/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/rom_flech/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/caflechette = 2,
		/obj/item/ammo_box/magazine/caflechette/ballpoint = 3,
	), src)

/obj/item/gun/ballistic/automatic/rom_flech/blueshield
	name = "\improper RomTech CMG-2C Rifle"
	desc = "The Compact Machinegun-2 Commando is an automatic rifle used by Romulus Executive Protection Service, modified to be one handed for usage with shield."
	icon_state = "cmg2"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie_evil"
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie_evil"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_LIGHT
	burst_size = 3
	spread = 0

	unfolded_spread = 0
	folded_spread = 7
	folded_recoil = 2
	unfolded_recoil = 0
	one_handed_always = 1

/obj/item/gun/ballistic/automatic/rom_flech/blueshield/empty
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/skyrat/pistol/blueshield_cmg
	name = "CMG-2C Rifle Case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/rom_flech/blueshield/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/blueshield_cmg/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/caflechette = 2,
		/obj/item/ammo_box/magazine/caflechette/ripper = 2,
	), src)

/datum/mod_theme/frontline
	name = "frontline"
	desc = "A Novaya Rossiyskaya Imperiya Defense Collegia protective suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A cheaper and more versatile replacement of the dated VOSKHOD Power Armor, designed by the Novaya Rossiyskaya Imperiya Innovations Collegia in \
	collaboration with Agurkrral researchers. Instead of the polyurea coated durathread-lined plasteel plates it utilises thin plates of Kevlar-backed titanium, making it lighter and more compact \
	while leaving place for other modules; yet due to its lack of energy dissipation systems, making its user more vulnerable against conventional laser weaponry. \
	Built-in projectile trajectory and munition assistance computer informs the operator of better places to aim, as well as the remaining munitions for \
	the currently held weapon and its magazines. This function is quite straining on the power cell, and as such, this suit is rarely seen outside of the fortified positions or humanitarian missions; \
	becoming the sign of what little hospitality and assistance the military can provide. However many people who had an experience with this MOD describe it as \"Very uncomfortable.\", \
	mainly due to its lack of proper environmental regulation systems. But because of its protective capabilities, extreme mass-production and cheap price, it easily became the main armor system of the NRI DC."
	default_skin = "frontline"
	armor_type = /datum/armor/mod_theme_frontline
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"frontline" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
		/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_frontline
	melee = 50
	bullet = 60
	laser = 40
	energy = 50
	bomb = 60
	bio = 100
	fire = 50
	acid = 80
	wound = 25

/obj/item/mod/control/pre_equipped/frontline
	theme = /datum/mod_theme/frontline
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/frontline/ert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)

/datum/mod_theme/policing
	name = "policing"
	desc = "A Novaya Rossiyskaya Imperiya Internal Affairs Collegia general purpose protective suit, designed for coreworld patrols."
	extended_desc = "An Apadyne Technologies outsourced, then modified for frontier use by the responding imperial police precinct, MODsuit model, \
		designed for reassuring panicking civilians than participating in active combat. The suit's thin plastitanium armor plating is durable against environment and projectiles, \
		and comes with a built-in miniature power redistribution system to protect against energy weaponry; albeit ineffectively. \
		Thanks to the modifications of the local police, additional armoring has been added to its legs and arms, at the cost of an increased system load."
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_inactive = 1.5
	slowdown_active = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

///Unrelated-to-Spider-Clan version of the module.
/obj/item/mod/module/status_readout/operational
	name = "MOD operational status readout module"
	desc = "A once-common module, this technology unfortunately went out of fashion in the safer regions of space; \
		however, it remained in use everywhere else. This particular unit hooks into the suit's spine, \
		capable of capturing and displaying all possible biometric data of the wearer; sleep, nutrition, fitness, fingerprints, \
		and even useful information such as their overall health and wellness. The vitals monitor also comes with a speaker, loud enough \
		to alert anyone nearby that someone has, in fact, died. This specific unit has a clock and operational ID readout."
	display_time = TRUE
	death_sound = 'modular_skyrat/modules/novaya_ert/sound/flatline.ogg'

///Blatant copy of the adrenaline boost module.
/obj/item/mod/module/auto_doc
	name = "MOD automatic paramedical module"
	desc = "The reverse-engineered and redesigned medical assistance system, previously used by the now decommissioned VOSKHOD combat armor. \
		The technology it uses is very similar to the one of Spider Clan, yet Innovations and Defense Collegium reject any similarities. \
		Using a built-in storage of chemical compounds and miniature chemical mixer, it's capable of injecting its user with simple painkillers and coagulants, \
		assisting them with their restoration, as long as they don't overdose themselves. However, this system heavily relies on some rarely combat-available chemical compounds to prepare its injections, \
		mainly Cryptobiolin, which appear in the user's bloodstream from time to time, and its trivial damage assesment systems are inadequate for complete restoration purposes."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(/obj/item/mod/module/adrenaline_boost, /obj/item/mod/module/auto_doc)
	cooldown_time = null
	complexity = 4
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// What reagent we need to refill?
	var/reagent_required = /datum/reagent/cryptobiolin
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Health threshold above which the module won't heal.
	var/health_threshold = 80
	/// Cooldown betwen each treatment.
	var/heal_cooldown = 30 SECONDS

	/// Timer for the cooldown.
	COOLDOWN_DECLARE(heal_timer)

/// Creates chemical container for chemicals and fills it with chemicals. Chemception.
/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)
	reagents.add_reagent(reagent_required, reagent_max_amount)

/obj/item/mod/module/auto_doc/on_activation()
	. = ..()
	if(!.)
		return
	RegisterSignal(mod.wearer, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_use))
	drain_power(use_energy_cost)

///	Heals damage (in fact, injects chems) based on the damage received and certain other variables (a single one), i.e. having more than X amount of health, not having enough needed chemicals or so on.
/obj/item/mod/module/auto_doc/on_use()
	if(!COOLDOWN_FINISHED(src, heal_timer))
		return FALSE

	if(!check_power(use_energy_cost))
		balloon_alert(mod.wearer, "not enough charge!")
		SEND_SIGNAL(src, COMSIG_MODULE_DEACTIVATED)
		return FALSE

	if(!(allow_flags & MODULE_ALLOW_PHASEOUT) && istype(mod.wearer.loc, /obj/effect/dummy/phased_mob))
		to_chat(mod.wearer, span_warning("You cannot activate this right now."))
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_MODULE_TRIGGERED) & MOD_ABORT_USE)
		return FALSE

	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "not enough chems!")
		SEND_SIGNAL(src, COMSIG_MODULE_DEACTIVATED)
		return FALSE

	if(mod.wearer.health > health_threshold)
		return

	var/new_bruteloss = mod.wearer.getBruteLoss()
	var/new_fireloss = mod.wearer.getFireLoss()
	var/new_toxloss = mod.wearer.getToxLoss()
	var/new_stamloss = mod.wearer.getStaminaLoss()
	playsound(mod.wearer, 'modular_skyrat/modules/hev_suit/sound/hev/hiss.ogg', 100)

	if(new_bruteloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 5)
		to_chat(mod.wearer, span_warning("Brute treatment administered. Overdose risks present on further use, consult your first-aid analyzer."))

	if(new_fireloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 5)
		to_chat(mod.wearer, span_warning("Burn treatment administered. Overdose risks present on further use, consult your first-aid analyzer."))

	if(new_toxloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 5)
		to_chat(mod.wearer, span_warning("Toxin treatment administered. Overdose risks present on further use, consult your first-aid analyzer."))

	if(new_stamloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/stimulants, 10)
		to_chat(mod.wearer, span_warning("Combat stimulants administered. Overdose risks present on further use, consult your first-aid analyzer."))

	mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 5)
	reagents.remove_reagent(reagent_required, reagent_required_amount)
	drain_power(use_energy_cost*10)

	///Debuff so it's "balanced", as well as a cooldown.
	addtimer(CALLBACK(src, PROC_REF(boost_aftereffects), mod.wearer), 45 SECONDS)
	COOLDOWN_START(src, heal_timer, heal_cooldown)

/// Refills MODsuit module with the needed chemicals. That's all it does.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
/// Oh, and it also doesn't work if it's (the chemical container) closed.
	if(!attacking_item.is_open_container())
		return FALSE
/// And if it's already full (:flushed:)
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "already full!")
		return FALSE
/// And if the reagent's wrong.
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
/// And if you got to that point without screwing up then it awards you with being refilled.
	balloon_alert(mod.wearer, "charge reloaded")
	return TRUE

/obj/item/mod/module/auto_doc/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	UnregisterSignal(mod.wearer, COMSIG_LIVING_HEALTH_UPDATE)

/obj/item/mod/module/auto_doc/on_install()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interact))

/obj/item/mod/module/auto_doc/on_uninstall(deleting)
	UnregisterSignal(mod, COMSIG_ATOM_ATTACKBY)

/obj/item/mod/module/auto_doc/attackby(obj/item/attacking_item, mob/user, params)
	if(charge_boost(attacking_item, user))
		return TRUE
	return ..()

/obj/item/mod/module/auto_doc/proc/on_item_interact(datum/source, mob/user, obj/item/thing, params)
	SIGNAL_HANDLER

	if(charge_boost(thing, user))
		return COMPONENT_NO_AFTERATTACK

	return NONE

/// Drawbacks to make this module less self-sufficient and so it feels "balanced" (there's no balance).
/obj/item/mod/module/auto_doc/proc/boost_aftereffects(mob/affected_mob)
	if(!affected_mob)
		return

	mod.wearer.reagents.add_reagent(/datum/reagent/cryptobiolin, 10)
	mod.wearer.reagents.add_reagent(/datum/reagent/drug/maint/sludge, 5)
	to_chat(affected_mob, span_danger("Your head starts slightly spinning, and your chest hurts."))

/// Not exactly a MODsuit thing but it's needed for the refills huh?
/obj/item/reagent_containers/cup/glass/waterbottle/large/cryptobiolin
	name = "bottle of cryptobiolin"
	desc = "Nothing screams budget cuts like bottled suit fluid."
	list_reagents = list(/datum/reagent/cryptobiolin = 100)

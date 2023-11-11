/obj/item/mod/control/pre_equipped/contractor/ancient_milsim
	applied_cell = /obj/item/stock_parts/cell/hyper
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/status_readout/operational,
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/control/pre_equipped/policing/ancient_milsim
	applied_cell = /obj/item/stock_parts/cell/hyper
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/dispenser/landmine,
		/obj/item/mod/module/active_sonar,
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/dispenser/landmine,
		/obj/item/mod/module/active_sonar,
	)

/obj/item/mod/control/pre_equipped/stealth_operative/ancient_milsim
	applied_cell = /obj/item/stock_parts/cell/hyper
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/visor/night,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/dispenser/smoke,
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/stealth,
		/obj/item/mod/module/dispenser/smoke,
	)

/obj/item/mod/control/pre_equipped/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/cell/hyper
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/status_readout/operational,
	)
	insignia_type = /obj/item/mod/module/insignia/medic
	additional_module = /obj/item/mod/module/defibrillator/combat

/obj/item/mod/module/dispenser/landmine
	name = "MOD landmine dispenser module"
	desc = "This module can create deactivated landmines at the user's liking."
	cooldown_time = 15 SECONDS
	dispense_type = /obj/item/minespawner/ancient_milsim

/obj/item/mod/module/dispenser/smoke
	name = "MOD smoke bomb dispenser module"
	desc = "This module can create activated smoke grenades at the user's liking."
	cooldown_time = 10 SECONDS
	dispense_type = /obj/item/grenade/smokebomb

/obj/item/mod/module/dispenser/smoke/on_use()
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/smokebomb/grenade = .
	grenade.arm_grenade(mod.wearer)

/obj/item/mod/control/pre_equipped/responsory/milsim_mechanic
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/meson,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/meson,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	insignia_type = /obj/item/mod/module/insignia/engineer
	additional_module = /obj/item/mod/module/dispenser/barrinade

/obj/item/mod/control/pre_equipped/responsory/milsim_trapper
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	insignia_type = /obj/item/mod/module/insignia/commander
	additional_module = /obj/item/mod/module/dispenser/landmine

/obj/item/mod/control/pre_equipped/responsory/milsim_marksman
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/night,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/night,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	insignia_type = /obj/item/mod/module/insignia/security
	additional_module = /obj/item/mod/module/dispenser/smoke

/obj/item/mod/control/pre_equipped/responsory/milsim_medic
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
		/obj/item/mod/module/armor_booster/retractplates,
	)
	insignia_type = /obj/item/mod/module/insignia/medic
	additional_module = /obj/item/mod/module/dispenser/legion_core

/obj/item/mod/module/dispenser/barrinade
	name = "MOD barricade grenade dispenser module"
	desc = "This module can create activated security barricade grenades at the user's liking."
	dispense_type = /obj/item/grenade/barrier

/obj/item/mod/module/dispenser/barrinade/on_use()
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/barrier/grenade = .
	grenade.arm_grenade(mod.wearer)

/obj/item/mod/module/dispenser/landmine
	name = "MOD landmine dispenser module"
	desc = "This module can create deactivated landmines at the user's liking."
	cooldown_time = 10 SECONDS
	dispense_type = /obj/item/minespawner/ancient_milsim

/obj/item/mod/module/dispenser/smoke
	name = "MOD smoke bomb dispenser module"
	desc = "This module can create activated smoke grenades at the user's liking."
	dispense_type = /obj/item/grenade/smokebomb

/obj/item/mod/module/dispenser/smoke/on_use()
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/smokebomb/grenade = .
	grenade.arm_grenade(mod.wearer)

/obj/item/mod/module/dispenser/legion_core
	name = "MOD legion core dispenser module"
	desc = "This module can create healing legion cores at the user's liking."
	cooldown_time = 10 SECONDS
	dispense_type = /obj/item/organ/internal/monster_core/regenerative_core/legion

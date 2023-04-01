/obj/item/mod/module/smartgun
	name = "MOD smartgun module"
	desc = "A bulky module that attahces to the back of a MODsuit, this \
			module is comprised of two parts, a holster and the M63A4 \"Smartgun\". \
			The holster works as storage for a gun that would be otherwise uncarryable, \
			and the gun itself fires at a blistering rate of fire, capable of suppressing enemies \
			without hurting teammates thanks to IFF technology."
	icon_state = "smartgun"
	icon = 'modular_skyrat/modules/marines/icons/items/module.dmi'
	overlay_icon_file = 'modular_skyrat/modules/marines/icons/mobs/mod_modules.dmi'
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/gun/ballistic/automatic/smart_machine_gun
	incompatible_modules = list(/obj/item/mod/module/smartgun)
	cooldown_time = 0.5 SECONDS
	overlay_state_inactive = "module_smartgun_off" //appears on back when it's off
	overlay_state_active = "module_smartgun_on"
	/// Power consumed per bullet fired
	var/power_per_bullet = 25

/obj/item/mod/module/smartgun/on_activation()
	. = ..()
	RegisterSignal(device, COMSIG_GUN_FIRED, PROC_REF(consume_energy))

/obj/item/mod/module/smartgun/proc/consume_energy(mob/user, atom/target, params, zone_override)
	SIGNAL_HANDLER

	drain_power(power_per_bullet)

/obj/item/mod/module/smartgun/marines
	removable = FALSE //no stealing!!

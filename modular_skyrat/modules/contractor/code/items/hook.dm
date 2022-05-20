/obj/item/gun/magic/hook/contractor
	name = "SCORPION hook"
	desc = "A hardlight hook used to non-lethally pull targets much closer to the user."
	icon = 'modular_skyrat/modules/contractor/icons/hook.dmi'
	icon_state = "hook_weapon"
	inhand_icon_state = "" //nah
	ammo_type = /obj/item/ammo_casing/magic/hook/contractor
	var/obj/item/mod/module/scorpion_hook/hook_module

/obj/item/gun/magic/hook/contractor/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_STORAGE_ENTERED, .proc/storage_undeploy)

/obj/item/gun/magic/hook/contractor/Destroy()
	if(hook_module?.stored_hook)
		hook_module.stored_hook = null
	if(hook_module)
		hook_module = null
	. = ..()

/obj/item/gun/magic/hook/contractor/dropped(mob/user, silent)
	. = ..()
	if(!hook_module)
		return

	hook_module.undeploy(user)

/obj/item/gun/magic/hook/contractor/proc/storage_undeploy(mob/user)
	if(!hook_module)
		return

	if(!user)
		user = hook_module?.mod?.wearer

	var/obj/item/storage = src.loc
	var/datum/component/storage/storagecomp = storage.GetComponent(/datum/component/storage)
	storagecomp.remove_from_storage(src, get_turf(src))
	hook_module.undeploy(user)

/obj/item/ammo_casing/magic/hook/contractor
	projectile_type = /obj/projectile/hook/contractor

/obj/projectile/hook/contractor
	icon = 'modular_skyrat/modules/contractor/icons/hook_projectile.dmi'
	damage = 0
	stamina = 25
	chain_icon = 'modular_skyrat/modules/contractor/icons/hook_projectile.dmi'

/obj/item/gun/magic/hook/contractor/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(prob(1))
		user.say("+GET OVER HERE!+", forced = "scorpion hook")
	. = ..()

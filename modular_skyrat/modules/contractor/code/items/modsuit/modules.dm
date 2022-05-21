
/obj/item/mod/module/baton_holster
	name = "MOD baton holster module"
	desc = "A module installed into the chest of a MODSuit, this allows you \
		to retrieve an inserted baton from the suit at will. Insert a baton \
		by hitting the module, while it is removed from the suit, with the baton. \
		Remove an inserted baton with a wrench."
	icon_state = "holster"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	complexity = 3
	incompatible_modules = list(/obj/item/mod/module/baton_holster)
	module_type = MODULE_USABLE
	allowed_inactive = TRUE
	/// Ref to the baton
	var/obj/item/melee/baton/telescopic/contractor_baton/stored_batong
	/// If the baton is out or not
	var/deployed = FALSE

/obj/item/mod/module/baton_holster/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/melee/baton/telescopic/contractor_baton) || stored_batong)
		return
	balloon_alert(user, "[attacking_item] inserted")
	attacking_item.forceMove(src)
	stored_batong = attacking_item
	stored_batong.holster = src

/obj/item/mod/module/baton_holster/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!stored_batong)
		return
	balloon_alert(user, "[stored_batong] removed")
	stored_batong.forceMove(get_turf(src))
	stored_batong.holster = null
	stored_batong = null
	tool.play_tool_sound(src)

/obj/item/mod/module/baton_holster/Destroy()
	if(stored_batong)
		stored_batong.forceMove(get_turf(src))
		stored_batong.holster = null
		stored_batong = null
	. = ..()

/obj/item/mod/module/baton_holster/on_use()
	if(!deployed)
		deploy(mod.wearer)
	else
		undeploy(mod.wearer)

/obj/item/mod/module/baton_holster/proc/deploy(mob/living/user)
	if(!(stored_batong in src))
		return
	if(!user.put_in_hands(stored_batong))
		to_chat(user, span_warning("You need a free hand to hold [stored_batong]!"))
		return
	deployed = TRUE
	balloon_alert(user, "[stored_batong] deployed")

/obj/item/mod/module/baton_holster/proc/undeploy(mob/living/user)
	if(QDELETED(stored_batong))
		return
	stored_batong.forceMove(src)
	deployed = FALSE
	balloon_alert(user, "[stored_batong] retracted")

/obj/item/mod/module/baton_holster/preloaded

/obj/item/mod/module/baton_holster/preloaded/Initialize(mapload)
	. = ..()
	stored_batong = new/obj/item/melee/baton/telescopic/contractor_baton/upgraded(src)
	stored_batong.holster = src

/obj/item/mod/module/chameleon/contractor // zero complexity module to match pre-TGification
	complexity = 0

/obj/item/mod/module/armor_booster/contractor // Much flatter distribution because contractor suit gets a shitton of armor already
	armor_values = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20)
	speed_added = -0.5 //Bulky as shit
	desc = "An embedded set of armor plates, allowing the suit's already extremely high protection \
		to be increased further. However, the plating, while deployed, will slow down the user \
		and make the suit unable to vacuum seal so this extra armor provides zero ability for extravehicular activity while deployed."

/obj/item/mod/module/springlock/contractor
	name = "MOD magnetic deployment module"
	desc = "A much more modern version of a springlock system. \
	This is a module that uses magnets to speed up the deployment and retraction time of your MODsuit."
	icon_state = "magnet"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'

/obj/item/mod/module/springlock/on_suit_activation() // This module is actually *not* a death trap
	return

/obj/item/mod/module/springlock/on_suit_deactivation(deleting = FALSE)
	return

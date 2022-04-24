/obj/machinery/porta_turret/black_mesa
	use_power = IDLE_POWER_USE
	req_access = list(ACCESS_CENT_GENERAL)
	faction = list(FACTION_XEN, FACTION_BLACKMESA, FACTION_HECU, FACTION_BLACKOPS)
	mode = TURRET_LETHAL
	uses_stored = FALSE
	max_integrity = 120
	base_icon_state = "syndie"
	lethal_projectile = /obj/projectile/beam/emitter
	lethal_projectile_sound = 'sound/weapons/laser.ogg'

/obj/machinery/porta_turret/black_mesa/assess_perp(mob/living/carbon/human/perp)
	return 10

/obj/machinery/porta_turret/black_mesa/setup(obj/item/gun/turret_gun)
	return

/obj/machinery/porta_turret/black_mesa/heavy
	name = "Heavy Defence Turret"
	max_integrity = 200
	lethal_projectile = /obj/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/machinery/deployable_turret/hmg/mesa
	name = "heavy machine gun turret"
	desc = "A heavy calibre machine gun commonly used by marine forces, famed for it's ability to give people on the recieving end more holes than normal."
	icon_state = "hmg"
	max_integrity = 250
	projectile_type = /obj/projectile/bullet/manned_turret/hmg/mesa
	anchored = TRUE
	number_of_shots = 3
	cooldown_duration = 1 SECONDS
	rate_of_fire = 2
	firesound = 'sound/weapons/gun/hmg/hmg.ogg'
	overheatsound = 'sound/weapons/gun/smg/smgrack.ogg'
	can_be_undeployed = TRUE
	spawned_on_undeploy = /obj/item/deployable_turret_folded/mesa

/obj/item/deployable_turret_folded/mesa
	name = "folded heavy machine gun"
	desc = "A folded and unloaded heavy machine gun, ready to be deployed and used."
	icon = 'icons/obj/turrets.dmi'
	icon_state = "folded_hmg"
	max_integrity = 250
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/deployable_turret_folded/mesa/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, 5 SECONDS, /obj/machinery/deployable_turret/hmg/mesa, delete_on_use = TRUE)

/obj/projectile/bullet/manned_turret/hmg/mesa
	icon_state = "redtrac"
	damage = 35

/obj/item/storage/toolbox/emergency/turret/mesa
	name = "USMC stationary defense deployment system"
	desc = "You feel a strange urge to hit this with a wrench."

/obj/item/storage/toolbox/emergency/turret/mesa/PopulateContents()
	return null

/obj/item/storage/toolbox/emergency/turret/mesa/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WRENCH && user.combat_mode)
		user.visible_message(span_danger("[user] bashes [src] with [I]!"), \
			span_danger("You bash [src] with [I]!"), null, COMBAT_MESSAGE_RANGE)
		playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
		var/obj/machinery/porta_turret/syndicate/pod/toolbox/mesa/turret = new(get_turf(loc))
		turret.faction = list(FACTION_HECU)
		qdel(src)

	..()

/obj/machinery/porta_turret/syndicate/pod/toolbox/mesa
	stun_projectile = /obj/projectile/bullet/advanced/b9mm/rubber
	lethal_projectile = /obj/projectile/bullet/c9mm/ap
	max_integrity = 150
	req_access = list(ACCESS_AWAY_SEC)
	faction = list(FACTION_HECU)
	shot_delay = 0.5


/obj/machinery/porta_turret/black_mesa/friendly
	faction = list(FACTION_STATION)

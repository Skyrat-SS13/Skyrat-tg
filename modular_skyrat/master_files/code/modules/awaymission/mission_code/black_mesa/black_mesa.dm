/area/awaymission/black_mesa
	name = "Black Mesa Inside"

/area/awaymission/black_mesa/outside
	name = "Black Mesa Outside"
	static_lighting = FALSE

/turf/closed/mineral/black_mesa
	turf_type = /turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

//Floors that no longer lead into space (innovative!)
/turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/obj/effect/baseturf_helper/black_mesa
	name = "black mesa sand baseturf editor"
	baseturf = /turf/open/misc/ironsand/black_mesa

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

/obj/item/minespawner/explosive
	name = "deactivated explosive landmine"
	desc = "When activated, will deploy into a highly explosive mine after 3 seconds passes, perfect for lazy marines looking to cover their fortifications with no effort."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "uglymine"

	mine_type = /obj/effect/mine/explosive

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
	max_integrity = 100
	faction = list(FACTION_HECU)
	shot_delay = 0.75

/obj/structure/alien/weeds/xen
	name = "xen weeds"
	desc = "A thick vine-like surface covers the floor."
	color = "#ac3b06"

/obj/item/gun/ballistic/automatic/laser/marksman
	name = "designated marksman rifle"
	desc = "A special laser beam sniper rifle designed by a certain now defunct research facility."
	icon_state = "ctfmarksman"
	inhand_icon_state = "ctfmarksman"
	mag_type = /obj/item/ammo_box/magazine/recharge/marksman
	force = 15
	weapon_weight = WEAPON_HEAVY
	zoomable = 1
	zoom_amt = 5
	fire_delay = 4 SECONDS
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'

/obj/item/ammo_box/magazine/recharge/marksman
	ammo_type = /obj/item/ammo_casing/caseless/laser/marksman
	max_ammo = 5

/obj/item/ammo_casing/caseless/laser/marksman
	projectile_type = /obj/projectile/beam/marksman

/obj/item/ammo_casing/caseless/laser/marksman/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/delete_on_drop)

/obj/projectile/beam/marksman
	name = "laser beam"
	damage = 70
	armour_penetration = 30
	hitscan = TRUE
	icon_state = "gaussstrong"
	tracer_type = /obj/effect/projectile/tracer/solar
	muzzle_type = /obj/effect/projectile/muzzle/solar
	impact_type = /obj/effect/projectile/impact/solar

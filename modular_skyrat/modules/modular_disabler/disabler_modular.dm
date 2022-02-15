#define SHOT_DISABLE "disable"
#define SHOT_SCATTER "scatter"
#define SHOT_HARDLIGHT "hardlight"
#define SHOT_BOUNCE "bounce"
#define SHOT_DISGUST "disgust"
#define SHOT_SKILLSHOT "skillshot"
#define SHOT_TASER "stun"
#define SHOT_UNTIE "untie"
#define SHOT_CONCUSSION "concussion"
#define SHOT_DROWSY "drowsy"

/obj/item/gun/energy/disabler
	cell_type = /obj/item/stock_parts/cell/super

/obj/item/gun/energy/disabler/upgraded
	var/overheat_time = 16
	var/holds_charge = FALSE
	var/unique_frequency = FALSE
	var/overheat = FALSE
	var/mob/holder
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/skyrat/proto) // SKYRAT EDIT: 	ammo_type = list(/obj/item/ammo_casing/energy/disabler)


	var/max_mod_capacity = 100
	var/list/modkits = list()

	var/recharge_timerid
	name = "upgraded disabler"
	Initialize(mapload)
		. = ..()
		var/ammo_to_load = /obj/item/ammo_casing/energy/laser/scatter/disabler/skyrat
		ammo_type += new ammo_to_load(src)
	shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
		. = ..()
		var/obj/item/ammo_casing/energy/shot = ammo_type[select]
		switch(shot.select_name)
			if(SHOT_DISABLE)
				attempt_reload()
			if(SHOT_SCATTER)
				attempt_reload(rand(10,20))
			if(SHOT_HARDLIGHT)
				attempt_reload(rand(30,40))
			if(SHOT_BOUNCE)
				attempt_reload(rand(15,25))
			if(SHOT_DISGUST)
				attempt_reload(rand(15,25))
			if(SHOT_SKILLSHOT)
				attempt_reload(rand(15,25))
			if(SHOT_TASER)
				attempt_reload(rand(15,25))
			if(SHOT_UNTIE)
				attempt_reload(rand(15,25))
			if(SHOT_CONCUSSION)
				attempt_reload(rand(15,25))
			if(SHOT_DROWSY)
				attempt_reload(rand(15,25))

	equipped(mob/user)
		. = ..()
		holder = user
		if(!can_shoot())
			attempt_reload()
	proc/attempt_reload(recharge_time)
		if(!cell)
			return
		if(overheat)
			return
		if(!recharge_time)
			recharge_time = overheat_time
		overheat = TRUE

		var/carried = 0
		if(!unique_frequency)
			for(var/obj/item/gun/energy/disabler/upgraded/K in loc.get_all_contents())
				if(!K.unique_frequency)
					carried++

			carried = max(carried, 1)
		else
			carried = 1

		deltimer(recharge_timerid)
		recharge_timerid = addtimer(CALLBACK(src, .proc/reload), recharge_time * carried, TIMER_STOPPABLE)

	emp_act(severity)
		return

	proc/reload()
		cell.give(cell.maxcharge)
		if(!suppressed)
			playsound(src.loc, 'sound/arcade/heal.ogg', 60, TRUE)
		else
			to_chat(loc, span_warning("[src] silently charges up."))
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		overheat = FALSE
	select_fire(mob/living/user)
		..()

/obj/item/gun/energy/disabler/upgraded/disgust


/obj/item/gun/energy/disabler/upgraded/disgust/Initialize(mapload)
	. = ..()
	var/ammo_to_load = /obj/item/ammo_casing/energy/disabler/skyrat/proto/disgust
	ammo_type += new ammo_to_load(src)
	name += " of disgust"
/obj/item/ammo_casing/energy/disabler/skyrat/proto/disgust
	projectile_type = /obj/projectile/beam/disabler/disgust
	select_name = "disgust"
	e_cost = 10000
/obj/projectile/beam/disabler/disgust
	damage = 0
	icon_state = "omnilaser"
	light_color = LIGHT_COLOR_GREEN

/obj/projectile/beam/disabler/disgust/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/mob/living/carbon/hit = target
	if(iscarbon(hit))
		hit.disgust += 15

/obj/item/ammo_casing/energy/disabler/skyrat/proto
	e_cost = 10000

/obj/item/ammo_casing/energy/disabler/skyrat/proto/bounce
	e_cost = 10000
	select_name = SHOT_BOUNCE
	heavy_metal = TRUE // bouncy?


/obj/projectile/beam/disabler/drowsy
	icon_state = "omnilaser"
	light_color = LIGHT_COLOR_LAVENDER
/obj/item/ammo_casing/energy/disabler/skyrat/proto/drowsy
	projectile_type = /obj/projectile/beam/disabler/drowsy
	select_name = SHOT_DISGUST
	e_cost = 20000

/obj/projectile/beam/disabler/drowsy/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/mob/living/carbon/hit = target
	if(iscarbon(hit))
		hit.adjust_drowsyness(rand(10,20))
//Casing
/obj/item/ammo_casing/energy/laser/hardlight_bullet/disabler
	var/damage = 25
	e_cost = 20000
	select_name  = SHOT_HARDLIGHT
//Modkits
/obj/item/ammo_casing/energy/laser/scatter/disabler/skyrat
	e_cost = 20000
	pellets = 2
	variance = 15
	harmful = FALSE
/obj/item/weaponcrafting/gunkit/disabler_upgrade
	name = "advanced energy gun parts kit"
	desc = "A suitcase containing the necessary gun parts to tranform a standard energy gun into an advanced energy gun."
/datum/crafting_recipe/disabler_upgrade
	name = "Disabler Upgrade"
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/gun/energy/disabler/upgraded
	reqs = list(/obj/item/gun/energy/disabler = 1,
				/obj/item/weaponcrafting/gunkit/disabler_upgrade = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	New()
		..()
		blacklist += subtypesof(/obj/item/gun/energy/disabler)

// This is now a modular change.
/obj/item/ammo_casing/energy/disabler/skyrat/
	e_cost = 1000



/datum/design/disabler_upgrade
	name = "Prototype Disabler Upgrade Modkit"
	desc = "A disabler modkit suitable for security applications. Do not swallow."
	id = "proto_disabler"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = 500, /datum/material/plasma = 500, /datum/material/titanium = 500)
	build_path = /obj/item/weaponcrafting/gunkit/disabler_upgrade
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

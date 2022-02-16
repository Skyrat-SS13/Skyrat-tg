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
#define SHOT_WARCRIME "warcrimes"
/obj/item/gun/energy/disabler
	cell_type = /obj/item/stock_parts/cell/super
/obj/item/device/custom_kit/disabler
	var/ammo_to_add
	var/name_to_append
/obj/item/device/custom_kit/disabler/afterattack(obj/target, mob/user, proximity_flag)
	var/obj/item/gun/energy/disabler/upgraded/target_obj = target
	var/_name_to_append = name_to_append
	if(!proximity_flag) //Gotta be adjacent to your target
		return
	if(isturf(target_obj)) //This shouldn't be needed, but apparently it throws runtimes otherwise.
		return
	if(target_obj.amount >= target_obj.maxamount)
		to_chat(user, span_warning("You can't improve [target_obj] any further!"))
		return
	target_obj.addammotype(ammo_to_add, _name_to_append)
	user.visible_message(span_notice("[user] modifies [target_obj] with [ammo_to_add]!"), span_notice("You modify [target_obj] with [ammo_to_add]."))
	qdel(src)


/obj/item/device/custom_kit/disabler/disgust
	name = "Vomit-Inducing Disabler Upgrade Kit"
	ammo_to_add = /obj/item/ammo_casing/energy/disabler/skyrat/proto/disgust
	name_to_append = SHOT_DISGUST
/obj/item/device/custom_kit/disabler/warcrime
	name = "Warcrime Disabler Upgrade Kit"
	ammo_to_add = /obj/item/ammo_casing/energy/disabler/skyrat/proto/warcrime
	name_to_append = SHOT_WARCRIME

/obj/item/gun/energy/disabler/upgraded/proc/addammotype(ammo_to_add, name_to_append)
	ammo_type += new ammo_to_add(src)
	name += " of [name_to_append]"
/obj/item/gun/energy/disabler/upgraded
	var/overheat_time = 16
	var/holds_charge = FALSE
	var/unique_frequency = FALSE
	var/overheat = FALSE
	var/mob/holder
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/skyrat/proto) // SKYRAT EDIT: 	ammo_type = list(/obj/item/ammo_casing/energy/disabler)


	var/max_mod_capacity = 100
	var/list/modkits = list()
	var/upgrade_name
	var/amount = 0
	var/maxamount = 3
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
			if(SHOT_WARCRIME)
				attempt_reload(rand(35,60))

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
	name += " of [SHOT_DISGUST]"
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

/obj/item/gun/energy/disabler/upgraded/warcrime


/obj/item/gun/energy/disabler/upgraded/warcrime/Initialize(mapload)
	. = ..()
	var/ammo_to_load = /obj/item/ammo_casing/energy/disabler/skyrat/proto/warcrime
	ammo_type += new ammo_to_load(src)
	name += " of [SHOT_WARCRIME]"
/obj/item/ammo_casing/energy/disabler/skyrat/proto/warcrime
	projectile_type = /obj/projectile/beam/disabler/warcrime
	select_name = SHOT_WARCRIME
	e_cost = 20000
/obj/projectile/beam/disabler/warcrime
	damage = 0
	icon_state = "toxin"
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/projectile/beam/disabler/warcrime/on_hit(atom/target, blocked, pierce_hit) // Might be a Traitor(sec) thing.
	. = ..()
	var/mob/living/carbon/human/hit = target
	var/effects = rand(5,15)
	if(ishuman(hit))
		hit.disgust += DISGUST_LEVEL_GROSS
		hit.stuttering += effects
		hit.slurring += effects
		hit.derpspeech += effects
		hit.losebreath += effects
		hit.dizziness += effects
		hit.jitteriness += effects

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

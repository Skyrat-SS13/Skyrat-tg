/*
MICROFUSION GUN UPGRADE ATTACHMENTS

For adding unique abilities to microfusion guns, these can directly interact with the gun!
*/

/obj/item/microfusion_gun_attachment
	name = "microfusion gun attachment"
	desc = "broken"
	icon = 'modular_skyrat/modules/microfusion/icons/guns.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	/// The attatchment overlay icon state.
	var/attachment_overlay_icon_state
	/// Any incompatable upgrade types.
	var/list/incompatable_attachments = list()
	/// The added heat produced by having this module installed.
	var/heat_addition = 0

/obj/item/microfusion_gun_attachment/proc/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_gun.heat_per_shot += heat_addition
	microfusion_gun.update_appearance()
	return

/obj/item/microfusion_gun_attachment/proc/process_upgrade(obj/item/gun/microfusion/microfusion_gun)
	return

/obj/item/microfusion_gun_attachment/proc/remove_upgrade(obj/item/gun/microfusion/microfusion_gun)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_gun.heat_per_shot -= heat_addition
	microfusion_gun.update_appearance()
	return

/*
SCATTER ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/
/obj/item/microfusion_gun_attachment/scatter
	name = "diffuser microfusion lens upgrade"
	desc = "Splits the microfusion laser beam entering the lens!"
	icon_state = "attachment_scatter"
	attachment_overlay_icon_state = "scatter_attachment"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/repeater)
	/// How many pellets are we going to add to the existing amount on the gun?
	var/pellets_to_add = 2
	/// The variation in pellet scatter.
	var/variance_to_add = 10
	/// How much recoil are we adding?
	var/recoil_to_add = 1

/obj/item/microfusion_gun_attachment/scatter/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil += recoil_to_add
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.pellets += pellets_to_add
		var/obj/projectile/our_projectile = ammo_casing.projectile_type
		ammo_casing.damage_override = initial(our_projectile.damage) / ammo_casing.pellets
		ammo_casing.variance += variance_to_add

/obj/item/microfusion_gun_attachment/scatter/remove_upgrade(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil -= recoil_to_add
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.damage_override = 0
		ammo_casing.pellets = initial(ammo_casing.pellets)
		ammo_casing.variance += initial(ammo_casing.variance)

/*
FOCUSING ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/
/obj/item/microfusion_gun_attachment/focus
	name = "focusing microfusion lens upgrade"
	desc = "Focuses the microfusion beam into a more concentrated lane, increasing accuracy!"
	icon_state = "attachment_focus"
	attachment_overlay_icon_state = "focus_attachment"
	/// How much recoil are we adding?
	var/recoil_to_remove = 0.5

/obj/item/microfusion_gun_attachment/focus/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil -= recoil_to_remove

/obj/item/microfusion_gun_attachment/focus/remove_upgrade(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil += recoil_to_remove

/*
REPEATER ATTACHMENT

The gun can fire volleys of shots.
*/
/obj/item/microfusion_gun_attachment/repeater
	name = "repeating phase emitter upgrade"
	desc = "Upgrades the central phase emitter to repeat twice."
	icon_state = "attachment_repeater"
	attachment_overlay_icon_state = "repeater_attachment"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/scatter)
	/// How much recoil are we adding?
	var/burst_to_add = 1
	var/delay_to_add = 1



/obj/item/microfusion_gun_attachment/repeater/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.burst_size += burst_to_add
	microfusion_gun.fire_delay += delay_to_add

/obj/item/microfusion_gun_attachment/repeater/remove_upgrade(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.burst_size -= burst_to_add
	microfusion_gun.fire_delay -= delay_to_add

/*
X-RAY ATTACHMENT

The gun can fire X-RAY shots.
*/
/obj/item/microfusion_gun_attachment/xray
	name = "phase inverter emitter array"
	desc = "Inverts the central phase emitter causing the wave frequency to shift into X-ray. CAUTION: Phase emitter heats up very quickly."
	icon_state = "attachment_repeater"
	attachment_overlay_icon_state = "repeater_attachment"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/scatter)
	heat_addition = 90

/obj/item/microfusion_gun_attachment/xray/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_per_shot += heat_addition
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.projectile_piercing = PASSCLOSEDTURF|PASSGRILLE|PASSGLASS

/obj/item/microfusion_gun_attachment/xray/remove_upgrade(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_per_shot -= heat_addition
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.projectile_piercing = initial(ammo_casing.projectile_piercing)
////////////////////////////////////////////////////////////// PHASE EMITTERS
/*
Basically the heart of the gun, can be upgraded.
*/
/obj/item/microfusion_phase_emitter
	name = "basic microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	icon = 'modular_skyrat/modules/microfusion/icons/guns.dmi'
	icon_state = "phase_emitter"
	base_icon_state = "phase_emitter"
	/// Max heat before it breaks
	var/max_heat = 1000
	/// Current heat level
	var/current_heat = 0
	/// Thermal throttle percentage
	var/throttle_percentage = 80
	/// How much heat it dissipates passively
	var/heat_dissipation_per_tick = 10
	/// What is our dynamic integrity?
	var/integrity = 100
	/// Are we fucked?
	var/damaged = FALSE
	/// Hard ref to the gun.
	var/obj/item/gun/microfusion/parent_gun

/obj/item/microfusion_phase_emitter/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/microfusion_phase_emitter/Destroy()
	parent_gun = null
	return ..()

/obj/item/microfusion_phase_emitter/process(delta_time)
	heat = clamp(heat - heat_dissipation_per_tick * delta_time, 0, INFINITY)
	if(heat > max_heat)
		integrity = integrity - (current_heat - max_heat * delta_time)
	if(integrity <= 0)
		kill()

/obj/item/microfusion_phase_emitter/multitool_act(mob/living/user, obj/item/tool)
	var/new_throttle = clamp(input(user, "Please input a new thermal throttle percentage(0-300):", "Phase Emitter Overclock") as null|num, 1, 300)

	to_chat(user, span_notice("Thermal throttle percent set to: [new_throttle]."))

	if(new_throttle > 100)
		to_chat(user, span_danger("WARNING: You have input a throttle percentage of more than 100, this may cause emitter damage."))

	throttle_percentage = new_throttle

/obj/item/microfusion_phase_emitter/update_icon_state()
	. = ..()

	if(damaged)
		icon_state = "[base_icon_state]_damaged"
	else
		switch(get_heat_percent())
			if(40 to 69)
				icon_state = "[base_icon_state]_hot"
			if(70 to INFINITY)
				icon_state = "[base_icon_state]_critical"
			else
				icon_state = base_icon_state

/obj/item/microfusion_phase_emitter/examine(mob/user)
	. = ..()
	if(damaged)
		. += span_danger("It is damaged beyond repair.")
	else
		. += span_notice("Heat capacity: [get_heat_percent()]%")
		. += span_notice("Integrity: [integrity]%")
		. += span_notice("Thermal throttle: [throttle_percentage]%")

/obj/item/microfusion_phase_emitter/proc/get_heat_percent()
	return round(heat / max_heat * 100)

/obj/item/microfusion_phase_emitter/proc/generate_shot(heat_to_add)
	if(damaged)
		return PHASE_FAILURE_DAMAGED
	if(get_heat_percent() >= throttle_percentage)
		return PHASE_FAILURE_THROTTLE
	heat += heat_to_add
	update_appearance()
	return SHOT_SUCCESS

/obj/item/microfusion_phase_emitter/proc/kill()
	damaged = TRUE
	name = "damaged [name]"
	say("ERROR: Integrity failure!")
	STOP_PROCESSING(SSobj, src)

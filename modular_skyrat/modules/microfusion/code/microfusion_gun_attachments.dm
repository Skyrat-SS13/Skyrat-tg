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

/obj/item/microfusion_gun_attachment/proc/process_attachment(obj/item/gun/microfusion/microfusion_gun)
	return

//Firing the gun right before we let go of it, tis is called.
/obj/item/microfusion_gun_attachment/proc/process_fire(obj/item/gun/microfusion/microfusion_gun, obj/item/ammo_casing/chambered)
	return

/obj/item/microfusion_gun_attachment/proc/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
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
	attachment_overlay_icon_state = "attachment_scatter"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/repeater, /obj/item/microfusion_gun_attachment/xray)
	/// How many pellets are we going to add to the existing amount on the gun?
	var/pellets_to_add = 2
	/// The variation in pellet scatter.
	var/variance_to_add = 10
	/// How much recoil are we adding?
	var/recoil_to_add = 1

/obj/item/microfusion_gun_attachment/scatter/multitool_act(mob/living/user, obj/item/tool)
	variance_to_add = clamp(input(user, "Please input a new lens variance adjustment (5-30):", "Lens Adjustment") as null|num, 5, 30)
	to_chat(user, span_notice("Lens variance percent set to: [variance_to_add]."))

/obj/item/microfusion_gun_attachment/scatter/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil += recoil_to_add
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.pellets += pellets_to_add
		ammo_casing.variance += variance_to_add

/obj/item/microfusion_gun_attachment/scatter/process_fire(obj/item/gun/microfusion/microfusion_gun, obj/item/ammo_casing/chambered)
	. = ..()
	chambered.loaded_projectile?.damage = chambered.loaded_projectile.damage / chambered.pellets

/obj/item/microfusion_gun_attachment/scatter/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil -= recoil_to_add
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.pellets -= ammo_casing.pellets
		ammo_casing.variance -= ammo_casing.variance

/*
FOCUSING ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/
/obj/item/microfusion_gun_attachment/focus
	name = "focusing microfusion lens upgrade"
	desc = "Focuses the microfusion beam into a more concentrated lane, increasing accuracy!"
	icon_state = "attachment_focus"
	attachment_overlay_icon_state = "attachment_focus"
	/// How much recoil are we removing?
	var/recoil_to_remove = 1
	var/spread_to_remove = 5

/obj/item/microfusion_gun_attachment/focus/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.recoil -= recoil_to_remove

/obj/item/microfusion_gun_attachment/focus/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
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
	attachment_overlay_icon_state = "attachment_repeater"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/scatter)
	heat_addition = 40
	var/burst_to_add = 1
	var/delay_to_add = 1

/obj/item/microfusion_gun_attachment/repeater/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.burst_size += burst_to_add
	microfusion_gun.fire_delay += delay_to_add

/obj/item/microfusion_gun_attachment/repeater/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.burst_size -= burst_to_add
	microfusion_gun.fire_delay -= delay_to_add

/*
X-RAY ATTACHMENT

The gun can fire X-RAY shots.
*/
/obj/item/microfusion_gun_attachment/xray
	name = "quantum phase inverter emitter array" //Yes quantum makes things sound cooler.
	desc = "Experimental technology that inverts the central phase emitter causing the wave frequency to shift into X-ray. CAUTION: Phase emitter heats up very quickly."
	icon_state = "attachment_xray"
	attachment_overlay_icon_state = "attachment_xray"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/scatter)
	heat_addition = 90

/obj/item/microfusion_gun_attachment/xray/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_per_shot += heat_addition

/obj/item/microfusion_gun_attachment/xray/process_fire(obj/item/gun/microfusion/microfusion_gun, obj/item/ammo_casing/chambered)
	. = ..()
	chambered.loaded_projectile?.projectile_piercing |= PASSCLOSEDTURF|PASSGRILLE|PASSGLASS

/obj/item/microfusion_gun_attachment/xray/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_per_shot -= heat_addition


/*
RAIL ATTACHMENT

Allows for flashlights bayonets and adds 1 slot to equipment.
*/
/obj/item/microfusion_gun_attachment/rail
	name = "gun rail attachment"
	desc = "A simple set of rails that attaches to weapon hardpoints."
	icon_state = "attachment_rail"
	attachment_overlay_icon_state = "attachment_rail"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/grip)
	var/attachment_slots_to_add = 1

/obj/item/microfusion_gun_attachment/rail/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.can_flashlight = TRUE
	microfusion_gun.can_bayonet = TRUE
	microfusion_gun.max_attachments += attachment_slots_to_add

/obj/item/microfusion_gun_attachment/rail/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.gun_light = initial(microfusion_gun.can_flashlight)
	if(microfusion_gun.gun_light)
		microfusion_gun.gun_light.forceMove(get_turf(microfusion_gun))
		microfusion_gun.clear_gunlight()
	microfusion_gun.can_bayonet = initial(microfusion_gun.can_bayonet)
	if(microfusion_gun.bayonet)
		microfusion_gun.bayonet.forceMove(get_turf(microfusion_gun))
		microfusion_gun.clear_bayonet()
	microfusion_gun.max_attachments -= attachment_slots_to_add

/*
GRIP ATTACHMENT

Does nothing right now.
*/
/obj/item/microfusion_gun_attachment/grip
	name = "grip attachment"
	desc = "A simple grip that increases accuracy."
	icon_state = "attachment_grip"
	attachment_overlay_icon_state = "attachment_grip"
	incompatable_attachments = list(/obj/item/microfusion_gun_attachment/rail)


/*
HEATSINK ATTACHMENT

"Greatly increases the phase emitter cooling rate."
*/
/obj/item/microfusion_gun_attachment/heatsink
	name = "phase emitter heatsink"
	desc = "Greatly increases the phase emitter cooling rate."
	icon_state = "attachment_heatsink"
	attachment_overlay_icon_state = "attachment_heatsink"
	var/cooling_rate_increase = 50

/obj/item/microfusion_gun_attachment/heatsink/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_dissipation_bonus += cooling_rate_increase

/obj/item/microfusion_gun_attachment/heatsink/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_dissipation_bonus -= cooling_rate_increase

/*
UNDERCHARGER ATTACHMENT

Massively decreases the output beam of the phase emitter.
Converts shots to STAMNINA damage.
*/
/obj/item/microfusion_gun_attachment/undercharger
	name = "phase emitter undercharger"
	desc = "Inverts the output beam of the phase emitter."
	icon_state = "attachment_undercharger"
	attachment_overlay_icon_state = "attachment_undercharger"
	var/cooling_rate_increase = 5

/obj/item/microfusion_gun_attachment/undercharger/run_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_dissipation_bonus += cooling_rate_increase

/obj/item/microfusion_gun_attachment/undercharger/process_fire(obj/item/gun/microfusion/microfusion_gun, obj/item/ammo_casing/chambered)
	. = ..()
	chambered.loaded_projectile?.damage_type = STAMINA

/obj/item/microfusion_gun_attachment/undercharger/remove_attachment(obj/item/gun/microfusion/microfusion_gun)
	. = ..()
	microfusion_gun.heat_dissipation_bonus -= cooling_rate_increase

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
	if(heat == 0)
		return
	var/calculated_heat_dissipation_per_tick = heat_dissipation_per_tick
	if(parent_gun)
		calculated_heat_dissipation_per_tick += parent_gun.heat_dissipation_bonus
	else
		calculated_heat_dissipation_per_tick += 10 //We get some passive cooling from being out of the gun.
	heat = clamp(heat - calculated_heat_dissipation_per_tick * delta_time, 0, INFINITY)
	if(heat > max_heat)
		integrity = integrity - (current_heat - max_heat) * delta_time
	if(integrity <= 0)
		kill()
	update_appearance()
	parent_gun.update_appearance()

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
		. += span_notice("It has a thermal rating of: [max_heat] C")
		. += span_notice("It dissipates heat at: [heat_dissipation_per_tick] C")
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

/obj/item/microfusion_phase_emitter/enhanced
	name = "enhanced microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 1500
	throttle_percentage = 85
	heat_dissipation_per_tick = 20

/obj/item/microfusion_phase_emitter/advanced
	name = "advanced microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 2000
	throttle_percentage = 85
	heat_dissipation_per_tick = 30

/obj/item/microfusion_phase_emitter/bluespace
	name = "advanced microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 2500
	throttle_percentage = 90
	heat_dissipation_per_tick = 40

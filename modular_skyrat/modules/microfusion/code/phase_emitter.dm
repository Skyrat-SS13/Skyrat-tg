////////////////////////////////////////////////////////////// PHASE EMITTERS
/*
Basically the heart of the gun, can be upgraded.
*/
/obj/item/microfusion_phase_emitter
	name = "basic microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	icon = 'modular_skyrat/modules/microfusion/icons/microfusion_gun_attachments.dmi'
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
	/// Are we "hacked" thus allowing overclocking?
	var/hacked = FALSE
	/// The fire delay this emitter adds to the gun.
	var/fire_delay = 0
	/// The sound playback speed, used for overheating sound effects on fire.
	var/sound_freq = 0

/obj/item/microfusion_phase_emitter/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/microfusion_phase_emitter/Destroy()
	parent_gun = null
	return ..()

/obj/item/microfusion_phase_emitter/process(delta_time)
	if(current_heat == 0)
		return
	var/calculated_heat_dissipation_per_tick = heat_dissipation_per_tick
	if(isspaceturf(get_turf(src)))
		calculated_heat_dissipation_per_tick += PHASE_HEAT_DISSIPATION_BONUS_SPACE // Passive cooling in space boost!
	if(parent_gun)
		calculated_heat_dissipation_per_tick += parent_gun.heat_dissipation_bonus
	else
		calculated_heat_dissipation_per_tick += PHASE_HEAT_DISSIPATION_BONUS_AIR //We get some passive cooling from being out of the gun.
	current_heat = clamp(current_heat - calculated_heat_dissipation_per_tick * delta_time, 0, INFINITY)
	if(current_heat > max_heat)
		integrity = integrity - current_heat / 1000 * delta_time

	process_fire_delay_and_sound()

	if(integrity <= 0)
		kill()
	update_appearance()
	parent_gun?.update_appearance()

/obj/item/microfusion_phase_emitter/multitool_act(mob/living/user, obj/item/tool)
	if(hacked)
		to_chat(user, span_warning("[src] is already unlocked!"))
		return
	to_chat(user, span_notice("You begin to override the thermal overclock safety..."))
	if(do_after(user, 5 SECONDS, src))
		hacked = TRUE
		to_chat(user, span_notice("You override the thermal overclock safety."))

/obj/item/microfusion_phase_emitter/proc/set_overclock(mob/living/user)
	if(!hacked)
		return
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

/obj/item/microfusion_phase_emitter/proc/process_fire_delay_and_sound()
	var/fire_delay_to_add = 0
	var/sound_speed_to_add = 1
	if(integrity < 100)
		fire_delay_to_add = fire_delay_to_add + (100 - integrity) / 10

	if(current_heat > max_heat)
		fire_delay_to_add = fire_delay_to_add + (current_heat - max_heat) / 100 //Holy shit this emitter is tanking
		sound_speed_to_add = sound_speed_to_add + (current_heat - max_heat) / 200

	sound_freq = clamp(sound_speed_to_add, 1, 3)

	fire_delay = round(fire_delay_to_add, 0.1)

/obj/item/microfusion_phase_emitter/proc/get_heat_icon_state()
	switch(get_heat_percent())
		if(40 to 69)
			return "hot"
		if(70 to INFINITY)
			return "critical"
		else
			return "normal"

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
	return round(current_heat / max_heat * 100)

/obj/item/microfusion_phase_emitter/proc/check_emitter()
	if(damaged)
		return PHASE_FAILURE_DAMAGED
	if(get_heat_percent() >= throttle_percentage)
		return PHASE_FAILURE_THROTTLE
	return SHOT_SUCCESS

/obj/item/microfusion_phase_emitter/proc/add_heat(heat_to_add)
	current_heat += heat_to_add
	update_appearance()

/obj/item/microfusion_phase_emitter/proc/kill()
	damaged = TRUE
	name = "damaged [name]"
	playsound(src, 'modular_skyrat/modules/microfusion/sound/overheat.ogg', 70)
	say("ERROR: Integrity failure!")
	STOP_PROCESSING(SSobj, src)

/obj/item/microfusion_phase_emitter/enhanced
	name = "enhanced microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 1500
	throttle_percentage = 85
	heat_dissipation_per_tick = 20
	integrity = 120
	color = "#ffffcc"

/obj/item/microfusion_phase_emitter/advanced
	name = "advanced microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 2000
	throttle_percentage = 85
	heat_dissipation_per_tick = 40
	integrity = 150
	color = "#99ffcc"

/obj/item/microfusion_phase_emitter/bluespace
	name = "bluespace microfusion phase emitter"
	desc = "The core of a microfusion projection weapon, produces the laser."
	max_heat = 2500
	throttle_percentage = 90
	heat_dissipation_per_tick = 60
	integrity = 200
	color = "#66ccff"

/obj/machinery/base_alarm
	name = "base alarm"
	desc = "Pull this to alert the guards!"
	icon = 'modular_skyrat/modules/assaultops/icons/alarm.dmi'
	icon_state = "alarm"
	max_integrity = 250
	integrity_failure = 0.4
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 100, RAD = 100, FIRE = 90, ACID = 30)
	use_power = NO_POWER_USE
	resistance_flags = FIRE_PROOF

	light_power = 0
	light_range = 4
	light_color = COLOR_VIVID_RED

	//Trick to get the glowing overlay visible from a distance
	luminosity = 1

	var/alarm_playing = FALSE
	var/triggered = FALSE
	var/list/obj/machinery/base_alarm/alarms = list()
	var/area/myarea = null

/obj/machinery/base_alarm/Initialize()
	. = ..()
	update_icon()
	myarea = get_area(src)
	for(var/obj/machinery/base_alarm/alarm in myarea)
		alarms.Add(alarm)

/obj/machinery/base_alarm/attack_hand(mob/user)
	add_fingerprint(user)
	to_chat(user, "<span class='userdanger'>You trigger the [src]!</span>")
	playsound(src, 'sound/machines/pda_button1.ogg', 100)
	trigger_alarm()

/obj/machinery/base_alarm/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/base_alarm/attack_robot(mob/user)
	return attack_hand(user)

/obj/machinery/base_alarm/proc/trigger_alarm()
	if(triggered)
		reset()
	else
		alarm()

/obj/machinery/base_alarm/proc/alarm()
	for(var/i in alarms)
		var/obj/machinery/base_alarm/A = i
		A.icon_state = "alarm_on"
		A.set_light(l_power = 2)
		A.triggered = TRUE
		if(!A.alarm_playing)
			A.alarm_playing = TRUE
			playsound(A, 'modular_skyrat/modules/assaultops/sound/GoldeneyeAlarm.ogg', 30)
			addtimer(CALLBACK(A, .proc/alarm_sound), 65)

/obj/machinery/base_alarm/proc/alarm_sound()
	if(!triggered)
		alarm_playing = FALSE
	else
		playsound(src, 'modular_skyrat/modules/assaultops/sound/GoldeneyeAlarm.ogg', 30)
		addtimer(CALLBACK(src, .proc/alarm_sound), 65)

/obj/machinery/base_alarm/proc/reset(mob/user)
	for(var/i in alarms)
		var/obj/machinery/base_alarm/A = i
		A.icon_state = "alarm"
		A.set_light(l_power = 0)
		A.triggered = FALSE


/*
	The heavy pulse rifle has infinite ammo, and is cooldown based instead
*/
#define HP_START_PROCESS	if (!processing)\
{	START_PROCESSING(SSobj, src); processing = TRUE}

#define HP_STOP_PROCESS	if (!processing)\
{	STOP_PROCESSING(SSobj, src); processing = FALSE}

#define UPDATE_DELAY	fire_delay = base_delay / (1+(heat * heat_delay_multiplier))

#define HP_BASE_DELAY 1.25

/obj/item/weapon/gun/projectile/automatic/pulse_heavy
	name = "Heavy Pulse Rifle"
	desc = "A colossal weapon capable of firing infinitely, but requiring a significant cooldown period. It is optimised for continuous fire, and will overheat more quickly if used in bursts."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "heavypulserifle"
	item_state = "heavypulserifle"
	wielded_item_state = "heavypulserifle-wielded"
	w_class = ITEM_SIZE_HUGE
	handle_casings = CLEAR_CASINGS
	magazine_type = null
	allowed_magazines = null
	load_method = MAGAZINE
	caliber = "pulse"
	slot_flags = SLOT_BACK
	ammo_type = /obj/item/ammo_casing/pulse
	mag_insert_sound = 'sound/weapons/guns/interaction/pulse_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/pulse_magout.ogg'
	one_hand_penalty = 10	//Don't try to fire this with one hand
	accuracy = 15
	damage_factor = 1.15

	projectile_type  = /obj/item/projectile/bullet/pulse

	aiming_modes = list(/datum/extension/aim_mode/rifle)

	screen_shake = 1

	firemodes = list(
		list(mode_name="full auto",  mode_type = /datum/firemode/automatic/pulserifle, fire_delay=HP_BASE_DELAY, dispersion = list(2)),
		)

	empty_sound = 'sound/weapons/guns/misc/overheat.ogg'


	var/base_delay = HP_BASE_DELAY

	//How hot it is
	heat = 0

	//Enters overheating state when heat gets this high
	var/max_heat = 1

	//When true, cannot fire
	var/overheating = FALSE

	//While we're overheating, we cooldown this much faster
	var/overheat_cooldown_mult = 1.25

	//When overheating, we exit the overheat state if heat drops below this value
	var/overheat_min = 0.5

	//Loses this much heat per second. Approx 250 seconds to cooldown completely
	var/cooldown_per_second	=	0.004

	//Heat gained per bullet fired
	var/heat_per_shot = 0.005

	//Heat gained each time the trigger is pulled
	var/heat_per_burst = 0.07

	//Firing delay is divided by 1 + (heat * this), making the gun speed up as it gets closer to max heat
	var/heat_delay_multiplier = 2


	var/processing = FALSE

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/Initialize()
	.=..()
	base_delay = current_firemode.settings["fire_delay"]

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/proc/overheat()
	overheating = TRUE
	playsound(src, 'sound/weapons/guns/misc/overheat.ogg', VOLUME_LOUD, FALSE)
	set_audio_cooldown("gunclick", 3 SECONDS)

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/proc/gain_heat(var/quantity)
	heat = clamp(heat + quantity, 0, max_heat)
	HP_START_PROCESS

	//The Heavy Pulse Rifle speeds up its firing speed based on heat level, 3* speed at max heat
	UPDATE_DELAY

	if (heat < max_heat)
		return TRUE
	else
		overheat()
		return FALSE

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/proc/lose_heat(var/quantity)
	heat = clamp(heat - quantity, 0, max_heat)

	//The Heavy Pulse Rifle speeds up its firing speed based on heat level, 3* speed at max heat
	UPDATE_DELAY

	if (overheating && heat < overheat_min)
		overheating = FALSE
		playsound(src, 'sound/weapons/guns/misc/heat_vent.ogg', VOLUME_LOUD, FALSE)
		update_firemode()
		//Ready to fire again

	if (!heat)
		HP_STOP_PROCESS

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/Process()
	var/heatloss = cooldown_per_second
	if (overheating)
		heatloss *= overheat_cooldown_mult
	lose_heat(heatloss)

/obj/item/weapon/gun/projectile/automatic/pulse_heavy/consume_next_projectile()
	if (gain_heat(heat_per_shot))
		return new projectile_type(src)	//If we're using a special projectile type, spawn it
	else return null


/obj/item/weapon/gun/projectile/automatic/pulse_heavy/can_fire(atom/target, mob/living/user, clickparams, var/silent = FALSE)
	if (overheating)
		return FALSE

	.=..()


/obj/item/weapon/gun/projectile/automatic/pulse_heavy/has_ammo()
	return (overheating == FALSE)


/obj/item/weapon/gun/projectile/automatic/pulse_heavy/get_remaining_ammo()
	return (max_heat - (heat + heat_per_burst)) / heat_per_shot


//The heavy pulse rifle gains some heat whenever the user pulls the trigger, in addition to per shot
/obj/item/weapon/gun/projectile/automatic/pulse_heavy/started_firing()
	gain_heat(heat_per_burst)


/obj/item/weapon/gun/projectile/automatic/pulse_heavy/show_remaining_ammo(var/mob/living/user)
	if (overheating)
		to_chat(user, SPAN_DANGER("The heat meter reads [round(heat*100,1)]%"))
		to_chat(user, SPAN_DANGER("It is overheating and will require several minutes to cool down."))
	else
		to_chat(user, "The heat meter reads [round(heat*100,1)]%")
		if(user.skill_check(SKILL_WEAPONS, SKILL_ADEPT))
			to_chat(user, "It can fire approximately [get_remaining_ammo()] round\s.")
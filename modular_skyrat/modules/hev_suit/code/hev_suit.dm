#define COLOR_HEV_GREEN "#00ff00"
#define COLOR_HEV_RED "#ff0000"
#define COLOR_HEV_BLUE "#00aeff"
#define COLOR_HEV_ORANGE "#f88f04"

#define HEV_ARMOR_POWERON_BONUS 60

#define HEV_DAMAGE_POWER_USE_THRESHOLD 10

#define HEV_ARMOR_POWEROFF list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 40, RAD = 40, FIRE = 40, ACID = 40, WOUND = 10)

#define HEV_ARMOR_POWERON list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 90, BIO = 100, RAD = 100, FIRE = 100, ACID = 100, WOUND = 70)

#define HEV_POWERUSE_AIRTANK 2
#define HEV_POWERUSE_HIT 50
#define HEV_POWERUSE_INJECTION 100
#define HEV_POWERUSE_HEAL 150

#define HEV_INJECTION_COOLDOWN 5 SECONDS

#define HEV_HEAL_COOLDOWN 5 SECONDS
#define HEV_HEAL_AMOUNT 10

#define HEV_VOICE_COOLDOWN 1 SECONDS

/obj/item/clothing/head/helmet/space/hardsuit/hev_suit
	name = "hazardous environment suit helmet"
	desc = "The Mark IV HEV suit helmet."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-hev"
	inhand_icon_state = "sec_helm"
	hardsuit_type = "hev"
	armor = HEV_ARMOR_POWEROFF
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags = STOPSPRESSUREDAMAGE
	slowdown = 0

/obj/item/clothing/suit/space/hardsuit/hev_suit
	name = "hazardous environment suit"
	desc = "The Mark IV HEV suit protects the user from a number of hazardous environments and has in build ballistic protection."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-hev"
	inhand_icon_state = "eng_hardsuit"
	hardsuit_type = "hev"
	armor = HEV_ARMOR_POWEROFF //This is gordons suit, of course it's strong.
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/hev_suit
	jetpack = /obj/item/tank/jetpack/suit
	cell = /obj/item/stock_parts/cell/hyper
	slowdown = 0 //I am not gimping doctor freeman
	hardsuit_tail_colors = list("2B5", "444", "2FB")
	actions_types = list(/datum/action/item_action/hev_activate, /datum/action/item_action/hev_deactivate, /datum/action/item_action/toggle_spacesuit, /datum/action/item_action/toggle_helmet)
	var/activated = FALSE
	var/activating = FALSE
	var/mob/living/carbon/current_user
	var/obj/item/clothing/head/helmet/space/hardsuit/hev_suit/current_helmet
	var/obj/item/tank/internals/current_internals_tank
	var/obj/item/radio/internal_radio
	var/user_old_bruteloss
	var/user_old_fireloss
	var/user_old_toxloss
	var/user_old_cloneloss
	var/user_old_oxyloss
	var/radio_channel = RADIO_CHANNEL_COMMON
	var/timer_id = null
	var/voice_current_cooldown
	var/healing_current_cooldown
	var/blood_loss_alarm
	var/toxins_alarm

/obj/item/clothing/suit/space/hardsuit/hev_suit/Initialize()
	. = ..()
	internal_radio = new(src)
	internal_radio.subspace_transmission = TRUE
	internal_radio.canhear_range = 0 // anything greater will have the bot broadcast the channel as if it were saying it out loud.
	internal_radio.recalculateChannels()

/obj/item/clothing/suit/space/hardsuit/hev_suit/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell, cell_override = /obj/item/stock_parts/cell/hyper)

/obj/item/clothing/suit/space/hardsuit/hev_suit/equipped(mob/user, slot)
	. = ..()
	current_user = user

/obj/item/clothing/suit/space/hardsuit/hev_suit/dropped()
	. = ..()
	deactivate()

/obj/item/clothing/suit/space/hardsuit/hev_suit/Destroy()
	if(internal_radio)
		qdel(internal_radio)
	deactivate()
	return ..()

/datum/action/item_action/hev_activate
	name = "Activate HEV Suit"

/datum/action/item_action/hev_deactivate
	name = "Deactivate HEV Suit"

/datum/action/item_action/hev_activate/Trigger()
	var/obj/item/clothing/suit/space/hardsuit/hev_suit/my_suit = target
	my_suit.activate()

/datum/action/item_action/hev_deactivate/Trigger()
	var/obj/item/clothing/suit/space/hardsuit/hev_suit/my_suit = target
	my_suit.deactivate()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/send_message(message, color = COLOR_HEV_ORANGE)
	if(!current_user)
		return
	to_chat(current_user, "HEV MARK IV: <span style='color: [color];'>[message]</span>")

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/send_hev_sound(sound/sound_in, volume = 50)
	var/sound/voice = sound(sound_in, wait = 1, channel = CHANNEL_HEV)
	playsound(src, voice, volume)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/activate()
	if(!current_user)
		return FALSE

	if(activating || activated)
		send_message("ERROR - SYSTEM [activating ? "ALREADY ACTIVATING" : "ALREADY ACTIVATED"]", COLOR_HEV_RED)
		return FALSE

	var/power_test = item_use_power(10, TRUE)
	if(!(power_test & COMPONENT_POWER_SUCCESS))
		var/failure_reason
		switch(power_test)
			if(COMPONENT_NO_CELL)
				failure_reason = "NO CELL INSERTED"
			if(COMPONENT_NO_CHARGE)
				failure_reason = "NO CELL CHARGE"
			else
				failure_reason = "GENERIC FAILURE"
		send_message("ERROR - POWER SYSTEMS FAILURE - [failure_reason]", COLOR_HEV_RED)
		return FALSE

	if(!current_user.head && !istype(current_user.head, /obj/item/clothing/head/helmet/space/hardsuit/hev_suit))
		send_message("ERROR - SUIT HELMET NOT ENGAGED", COLOR_HEV_RED)
		return FALSE

	current_helmet = current_user.head

	ADD_TRAIT(current_helmet, TRAIT_NODROP, "hev_trait")

	send_message("ACTIVATING SYSTEMS")
	activating = TRUE
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/01_hev_logon.ogg', 50)

	send_message("ESTABLISHING HELMET LINK...")
	send_message("ESTABLISHED", COLOR_HEV_GREEN)

	send_message("CALIBRATING FIT ADJUSTMENTS...")
	send_message("CALIBRATED", COLOR_HEV_GREEN)

	send_message("CALIBRATING REACTIVE ARMOR SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/powerarmor), 10 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/use_hev_power(amount)
	var/power_test = item_use_power(amount)
	if(!(power_test & COMPONENT_POWER_SUCCESS))
		var/failure_reason
		switch(power_test)
			if(COMPONENT_NO_CELL)
				failure_reason = "NO CELL INSERTED"
			if(COMPONENT_NO_CHARGE)
				failure_reason = "NO CELL CHARGE"
			else
				failure_reason = "GENERIC FAILURE"
		send_message("ERROR - POWER SYSTEMS FAILURE - [failure_reason]", COLOR_HEV_RED)
		deactivate()
		return FALSE
	return TRUE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/powerarmor()
	armor = HEV_ARMOR_POWERON
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/02_powerarmor_on.ogg', 50)
	user_old_bruteloss = current_user.getBruteLoss()
	user_old_fireloss = current_user.getFireLoss()
	user_old_toxloss = current_user.getToxLoss()
	user_old_cloneloss = current_user.getCloneLoss()
	user_old_oxyloss = current_user.getOxyLoss()
	RegisterSignal(current_user, COMSIG_MOB_UPDATE_HEALTH, .proc/process_hit)
	send_message("CALIBRATED", COLOR_HEV_GREEN)
	send_message("CALIBRATING ATMOSPHERIC CONTAMINANT SENSORS...")
	timer_id = addtimer(CALLBACK(src, .proc/atmospherics), 4 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_hit()
	SIGNAL_HANDLER
	var/new_bruteloss = current_user.getBruteLoss()
	var/new_fireloss = current_user.getFireLoss()
	var/new_toxloss = current_user.getToxLoss()
	var/new_cloneloss = current_user.getCloneLoss()
	var/new_oxyloss = current_user.getOxyLoss()
	var/use_power_this_hit = FALSE
	if(current_user.getBruteLoss() > (new_bruteloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getFireLoss() > (new_fireloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getToxLoss() > (new_toxloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getCloneLoss() > (new_cloneloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(use_power_this_hit)
		use_hev_power(HEV_POWERUSE_HIT)
	user_old_bruteloss = new_bruteloss
	user_old_fireloss = new_fireloss
	user_old_toxloss = new_toxloss
	user_old_cloneloss = new_cloneloss
	user_old_oxyloss = new_oxyloss
	state_health()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/state_health()
	var/current_health = current_user.health
	var/max_health = current_user.maxHealth
	if(current_health <= max_health*0.2)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/near_death.ogg')
	else if(current_health <= max_health*0.4)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/health_critical.ogg')
	else if(current_health <= max_health*0.6)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/health_dropping2.ogg')
	else if(current_health <= max_health*0.8)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/seek_medic.ogg')

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/atmospherics()
	if(!current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE) && !istype(current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE), /obj/item/tank/internals))
		send_message("FAILURE, NO TANK DETECTED", COLOR_HEV_RED)
		timer_id = addtimer(CALLBACK(src, .proc/vitalsigns), 4 SECONDS, TIMER_STOPPABLE)
		return
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/03_atmospherics_on.ogg', 50)
	current_internals_tank = current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE)
	ADD_TRAIT(current_internals_tank, TRAIT_NODROP, "hev_trait")
	to_chat(current_user, "<span class='notice'>You hear a click as [current_internals_tank] is secured to your suit.</span>")
	RegisterSignal(current_internals_tank, COMSIG_TANK_REMOVE_AIR, /obj/item/clothing/suit/space/hardsuit/hev_suit/proc/handle_tank)
	RegisterSignal(current_user, COMSIG_ATOM_FIRE_ACT, /obj/item/clothing/suit/space/hardsuit/hev_suit/proc/deal_with_that_fire)
	send_message("CALIBRATED", COLOR_HEV_GREEN)
	send_message("CALIBRATING VITALSIGN MONITORING SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/vitalsigns), 4 SECONDS, TIMER_STOPPABLE)


/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/handle_tank(datum/source, amount)
	SIGNAL_HANDLER
	if(!current_internals_tank)
		return
	if(use_hev_power(HEV_POWERUSE_AIRTANK))
		current_internals_tank.populate_gas()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/deal_with_that_fire(exposed_temperature, exposed_volume)
	SIGNAL_HANDLER
	playsound(src, 'sound/effects/extinguish.ogg', 75, TRUE, -3)
	new /obj/effect/particle_effect/water(get_turf(src))
	current_user.extinguish_mob()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/vitalsigns()
	RegisterSignal(current_user, COMSIG_MOB_STATCHANGE, .proc/stat_changed)
	send_message("CALIBRATED", COLOR_HEV_GREEN)
	timer_id = addtimer(CALLBACK(src, .proc/medical_systems), 3 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/stat_changed(datum/source, new_stat)
	SIGNAL_HANDLER
	if(current_user.stat == DEAD)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/flatline.ogg')
		internal_radio.talk_into(src, "WARNING! USER [uppertext(current_user.name)] VITALSIGNS HAVE FLATLINED, CURRENT POSITION: [x], [y], [z]!", radio_channel)
		deactivate()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/medical_systems()
	send_message("CALIBRATING AUTOMATIC MEDICAL SYSTEMS...")
	RegisterSignal(current_user, COMSIG_ATOM_RAD_ACT, .proc/process_radiation)
	RegisterSignal(current_user, COMSIG_CARBON_GAIN_WOUND, .proc/process_wound)
	START_PROCESSING(SSobj, src)
	send_message("CALIBRATED", COLOR_HEV_GREEN)
	timer_id = addtimer(CALLBACK(src, .proc/finished), 3 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/process(delta_time)
	if(current_user.blood_volume < BLOOD_VOLUME_OKAY && !blood_loss_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/blood_loss.ogg')
		blood_loss_alarm = TRUE
	else if(blood_loss_alarm)
		blood_loss_alarm = FALSE

	if(current_user.getToxLoss() > 30 && !toxins_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/blood_toxins.ogg')
		toxins_alarm = TRUE
	else if(toxins_alarm)
		toxins_alarm = FALSE

	if(world.time <= healing_current_cooldown)
		return

	var/new_bruteloss = current_user.getBruteLoss()
	var/new_fireloss = current_user.getFireLoss()
	var/new_toxloss = current_user.getToxLoss()
	var/new_cloneloss = current_user.getCloneLoss()
	var/new_oxyloss = current_user.getOxyLoss()

	if(new_oxyloss >= HEV_HEAL_AMOUNT)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustBruteLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_HEAL_COOLDOWN
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

	if(new_bruteloss >= HEV_HEAL_AMOUNT)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustBruteLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_HEAL_COOLDOWN
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

	if(new_fireloss >= HEV_HEAL_AMOUNT)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustFireLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_HEAL_COOLDOWN
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

	if(new_toxloss >= HEV_HEAL_AMOUNT)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustBruteLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_HEAL_COOLDOWN
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

	if(new_cloneloss >= HEV_HEAL_AMOUNT)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustBruteLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_HEAL_COOLDOWN
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_wound(carbon, wound, bodypart)
	SIGNAL_HANDLER
	if(istype(wound, /datum/wound/blunt) || istype(wound, /datum/wound/blunt/moderate))
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/minor_fracture.ogg')
		return
	if(istype(wound, /datum/wound/blunt/severe) || istype(wound, /datum/wound/blunt/severe))
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/major_fracture.ogg')
		return
	if(istype(wound, /datum/wound/slash) || istype(wound, /datum/wound/slash/moderate) || istype(wound, /datum/wound/pierce) || istype(wound, /datum/wound/pierce/moderate))
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/minor_lacerations.ogg')
		return
	if(istype(wound, /datum/wound/slash/severe) || istype(wound, /datum/wound/slash/critical) || istype(wound, /datum/wound/pierce/severe) || istype(wound, /datum/wound/pierce/critical))
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/major_lacerations.ogg')
		return

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_radiation()
	SIGNAL_HANDLER
	send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/radiation_detected.ogg')
	state_health()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/finished()
	send_message("ALL SYSTEMS ONLINE, WELCOME [current_user.name]", COLOR_HEV_GREEN)
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/09_safe_day.ogg', 50)
	activated = TRUE
	activating = FALSE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/deactivate()
	if(timer_id)
		deltimer(timer_id)
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(current_user, COMSIG_MOB_UPDATE_HEALTH)
	UnregisterSignal(current_user, COMSIG_MOB_STATCHANGE)
	UnregisterSignal(current_internals_tank, COMSIG_TANK_REMOVE_AIR)
	armor = HEV_ARMOR_POWEROFF
	current_helmet = null
	if(current_internals_tank)
		REMOVE_TRAIT(current_internals_tank, TRAIT_NODROP, "hev_trait")
		current_internals_tank = null
	if(current_user)
		send_message("SYSTEMS DEACTIVATED", COLOR_HEV_RED)
		current_user = null
	activated = FALSE
	activating = FALSE

#undef COLOR_HEV_GREEN
#undef COLOR_HEV_RED
#undef COLOR_HEV_BLUE
#undef COLOR_HEV_ORANGE
#undef HEV_ARMOR_POWERON_BONUS
#undef HEV_DAMAGE_POWER_USE_THRESHOLD
#undef HEV_ARMOR_POWEROFF
#undef HEV_ARMOR_POWERON
#undef HEV_POWERUSE_AIRTANK
#undef HEV_POWERUSE_HIT
#undef HEV_POWERUSE_INJECTION
#undef HEV_POWERUSE_HEAL
#undef HEV_INJECTION_COOLDOWN
#undef HEV_HEAL_COOLDOWN
#undef HEV_HEAL_AMOUNT
#undef HEV_VOICE_COOLDOWN

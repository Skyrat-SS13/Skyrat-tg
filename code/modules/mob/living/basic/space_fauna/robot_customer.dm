///Robot customers
/mob/living/basic/robot_customer
	name = "tourist bot"
	maxHealth = 150
	health = 150
	desc = "I wonder what they'll order..."
	gender = NEUTER

	icon = 'icons/mob/simple/tourists.dmi'
	icon_state = "amerifat"
	icon_living = "amerifat"

	max_grab = GRAB_AGGRESSIVE
	basic_mob_flags = DEL_ON_DEATH
	mob_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	sentience_type = SENTIENCE_ARTIFICIAL

	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = TCMB
	maximum_survivable_temperature = T0C + 1000

	ai_controller = /datum/ai_controller/robot_customer

	/// The clothes that we draw on this tourist.
	var/clothes_set = "amerifat_clothes"
	/// Reference to the hud that we show when the player hovers over us.
	var/datum/atom_hud/hud_to_show_on_hover

/mob/living/basic/robot_customer/Initialize(
	mapload,
	datum/customer_data/customer_data = /datum/customer_data/american,
	datum/venue/attending_venue = SSrestaurant.all_venues[/datum/venue/restaurant],
)
	var/datum/customer_data/customer_info = SSrestaurant.all_customers[customer_data]
	ai_controller = customer_info.ai_controller_used

	. = ..()

	add_traits(list(TRAIT_NOMOBSWAP, TRAIT_NO_TELEPORT, TRAIT_STRONG_GRABBER), INNATE_TRAIT) // never suffer a bitch to fuck with you
	AddElement(/datum/element/footstep, FOOTSTEP_OBJ_ROBOT, 1, -6, sound_vary = TRUE)

	ai_controller.set_blackboard_key(BB_CUSTOMER_CUSTOMERINFO, customer_info)
	ai_controller.set_blackboard_key(BB_CUSTOMER_ATTENDING_VENUE, attending_venue)
	ai_controller.set_blackboard_key(BB_CUSTOMER_PATIENCE, customer_info.total_patience)

	icon = customer_info.base_icon
	icon_state = customer_info.base_icon_state
	name = "[pick(customer_info.name_prefixes)]-bot"
	color = rgb(rand(80,255), rand(80,255), rand(80,255))
	clothes_set = pick(customer_info.clothing_sets)
	update_appearance(UPDATE_ICON)

///Clean up on the mobs seat etc when its deleted (Either by murder or because it left)
/mob/living/basic/robot_customer/Destroy()
	var/datum/venue/attending_venue = ai_controller.blackboard[BB_CUSTOMER_ATTENDING_VENUE]
	var/obj/structure/holosign/robot_seat/our_seat = ai_controller.blackboard[BB_CUSTOMER_MY_SEAT]
	attending_venue.current_visitors -= src
	if(attending_venue.linked_seats[our_seat])
		attending_venue.linked_seats[our_seat] = null
	QDEL_NULL(hud_to_show_on_hover)
	return ..()

///Robots need robot gibs...!
/mob/living/basic/robot_customer/spawn_gibs()
	new /obj/effect/gibspawner/robot(drop_location(), src)

/mob/living/basic/robot_customer/MouseEntered(location, control, params)
	. = ..()
	hud_to_show_on_hover?.show_to(usr)

/mob/living/basic/robot_customer/MouseExited(location, control, params)
	. = ..()
	hud_to_show_on_hover?.hide_from(usr)

/mob/living/basic/robot_customer/update_overlays()
	. = ..()

	var/datum/customer_data/customer_info = ai_controller.blackboard[BB_CUSTOMER_CUSTOMERINFO]

	var/new_underlays = customer_info.get_underlays(src)
	if (new_underlays)
		underlays.Cut()
		underlays += new_underlays

	var/mutable_appearance/features = mutable_appearance(icon, "[icon_state]_features")
	features.appearance_flags = RESET_COLOR
	. += features

	var/mutable_appearance/clothes = mutable_appearance(icon, clothes_set)
	clothes.appearance_flags = RESET_COLOR
	. += clothes

	var/bonus_overlays = customer_info.get_overlays(src)
	if(bonus_overlays)
		. += bonus_overlays

/mob/living/basic/robot_customer/send_speech(message, message_range, obj/source, bubble_type, list/spans, datum/language/message_language, list/message_mods, forced, tts_message, list/tts_filter)
	. = ..()
	var/datum/customer_data/customer_info = ai_controller.blackboard[BB_CUSTOMER_CUSTOMERINFO]
	playsound(src, customer_info.speech_sound, 30, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, falloff_distance = 5)

/mob/living/basic/robot_customer/examine(mob/user)
	. = ..()
	if(isnull(ai_controller.blackboard[BB_CUSTOMER_CURRENT_ORDER]))
		return

	var/datum/venue/attending_venue = ai_controller.blackboard[BB_CUSTOMER_ATTENDING_VENUE]
	var/wanted_item = ai_controller.blackboard[BB_CUSTOMER_CURRENT_ORDER]
	var/order = "nothing"

	if(istype(wanted_item, /datum/custom_order))
		var/datum/custom_order/custom_order = wanted_item
		order = custom_order.get_order_line(attending_venue)
	else
		order = attending_venue.order_food_line(wanted_item)

	. += span_notice("Their order was: \"[order].\"")

/*
#define CANDLE_LUMINOSITY 2
#define PAIN_DEFAULT 9

/obj/item/bdsm_candle
	name = "soy candle"
	desc = "A candle with low melting temperature."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "candle"
	inhand_icon_state = "candle"
	w_class = WEIGHT_CLASS_TINY
	light_color = LIGHT_COLOR_FIRE
	heat = 600
	/// Current color of the candle, can be changed and affects sprite
	var/current_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// If the candle is on
	var/lit = FALSE
	/// If the candle should spawn lit
	var/start_lit = FALSE
	/// Static list used for displaying colors in the radial selection menu
	var/static/list/candle_designs
	/// Static list of possible colors for the candle
	var/static/list/candlelights = list(
                                "pink" = LIGHT_COLOR_FIRE,
                                "teal" = COLOR_CYAN)

//to change color of candle
//create radial menu
/obj/item/bdsm_candle/proc/populate_candle_designs()
    candle_designs = list(
        "pink" = image (icon = src.icon, icon_state = "candle_pink_lit"),
        "teal" = image(icon = src.icon, icon_state = "candle_teal_lit"))

/obj/item/bdsm_candle/proc/update_brightness()
    set_light_on(lit)
    update_light()

/obj/item/bdsm_candle/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/bdsm_candle/Initialize()
	. = ..()
	update_icon()
	update_icon_state()
	if(start_lit)
		light()
	if(!length(candle_designs))
		populate_candle_designs()

/obj/item/bdsm_candle/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[lit ? "lit" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]_[lit ? "lit" : "off"]"

/obj/item/bdsm_candle/attackby(obj/item/object, mob/user, params)
	var/msg = object.ignition_effect(src, user)
	update_brightness()
	if(msg)
		light(msg)
	else
		return ..()

/obj/item/bdsm_candle/fire_act(exposed_temperature, exposed_volume)
	if(!lit)
		light()
		update_brightness()
	return ..()

/obj/item/bdsm_candle/get_temperature()
	return lit * heat

/obj/item/bdsm_candle/proc/light(show_message)
	if(lit)
		return
	lit = TRUE
	if(show_message)
		usr.visible_message(show_message)
	set_light(CANDLE_LUMINOSITY)
	START_PROCESSING(SSobj, src)
	update_icon()
	update_brightness()

/obj/item/bdsm_candle/proc/put_out_candle()
	if(!lit)
		return
	lit = FALSE
	update_icon()
	set_light(0)
	return TRUE

/obj/item/bdsm_candle/extinguish()
	put_out_candle()
	return ..()

/obj/item/bdsm_candle/process(delta_time)
	if(!lit)
		return PROCESS_KILL
	open_flame()
	update_brightness()

/obj/item/bdsm_candle/AltClick(mob/user)
	. = ..()
	if(!lit)
		if(color_changed)
			return
		var/choice = show_radial_menu(user, src, candle_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		light_color = candlelights[choice]
		update_icon()
		update_brightness()
		color_changed = TRUE
	else
		if(!put_out_candle())
			return
		user.visible_message(span_notice("[user] snuffs [src]."))

/*
*	WAX DROPPING
*/

/obj/item/bdsm_candle/attack(mob/living/carbon/human/attacked, mob/living/carbon/human/user)
	. = ..()
	if(!istype(attacked))
		return

	var/message = ""
	var/targeted_somewhere
	if(!lit)
		to_chat(user, span_danger("[src] needs to be lit to produce wax!"))
		return
	if(!attacked.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("It looks like [attacked] don't want you to do that."))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna wax
		if(BODY_ZONE_PRECISE_GROIN)
			targeted_somewhere = TRUE
			var/obj/item/organ/genital/penis = attacked.getorganslot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina = attacked.getorganslot(ORGAN_SLOT_VAGINA)
			if((vagina && penis) && (attacked.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW))
				message = (user == attacked) ? pick("drips some wax on [attacked.p_their()] genitals, moaning in pleasure",
											"drips some wax on [attacked.p_them()]self, moaning in pleasure as it reaches [attacked.p_their()] genitals") : pick(
											"drips wax right on [attacked]'s genitalia. It slightly itches",
											"drips hot wax from the [src] onto [attacked]'s genitalia, causing [attacked.p_them()] to shiver",
											"tilts [src], dripping wax right onto [attacked]'s genitals, causing [attacked.p_them()] to moan",
											"drips some wax onto [attacked]'s genitals, making [attacked.p_them()] moan in pleasure")
				attacked.adjustPain(PAIN_DEFAULT)

			else if(penis && (attacked.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW))
				message = (user == attacked) ? pick("drips some wax on [attacked.p_their()] penis, causing [attacked.p_them()] to moan in pleasure",
											"drips some wax on themselves, letting it reach his penis. he moans in pleasure.") : pick(
											"drips wax right on [attacked]'s penis. It slightly itches.",
											"drips hot wax from the [src] on the [attacked]'s penis, he slightly shivers.",
											"tilts the candle. Drops of wax, dripping right from [src] right on the [attacked]'s penis, made him moan.")
				attacked.adjustPain(PAIN_DEFAULT)

			else if(vagina && (attacked.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW))
				message = (user == attacked) ? pick("drips some wax on themselves, letting it reach his vagina. He moans in pleasure.", "drips some wax on the [attacked]'s pussy, he moans in pleasure") : pick("drips some wax on the [attacked]'s vagina, he moans in pleasure", "tilts the candle. Wax slowly goes down, reaching the [attacked]'s vagina.", "tilts the candle. Drops of wax, dripping right from [src] right on the [attacked]'s pussy, made him moan.")
				attacked.adjustPain(PAIN_DEFAULT)

			else if(attacked.is_bottomless())
				message = (user == attacked) ? pick("drips some wax on themselves, letting it reach his belly. He moans in pleasure.", "drips some wax on the [attacked]'s tummy, he moans in pleasure") : pick("drips some wax on the [attacked]'s belly, he moans in pleasure", "tilts the candle. Wax slowly goes down, reaching the [attacked]'s tummy.", "tilts the candle. Drops of wax, dripping right from [src] right on the [attacked]'s groin, made him moan.")
				attacked.adjustPain(PAIN_DEFAULT)

			else
				to_chat(user, span_danger("Looks like [attacked]'s groin is covered!"))
				return

		if(BODY_ZONE_CHEST)
			targeted_somewhere = TRUE
			var/obj/item/organ/genital/breasts = attacked.getorganslot(ORGAN_SLOT_BREASTS)
			if(attacked.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW)
				message = (user == attacked) ? pick("drips some wax on [attacked.p_their()] [breasts ? "breasts" : "nipples"], releasing all [attacked.p_their()] lustness", "drips some wax right on [attacked.p_their()] [breasts ? "tits" : "chest"], making [attacked.p_their()] feel faint.") : pick("pours the wax that is slowly dripping from [src] onto [attacked]'s [breasts ? "breasts" : "nipples"], [attacked.p_they()] shows pure enjoyment.", "tilts the candle. Right in the moment when wax drips on [attacked]'s [breasts ? "breasts" : "nipples"], [attacked.p_they()] shivers", "tilts the candle. Just when hot drops of wax fell on [attacked]'s [breasts ? "breasts" : "nipples"], [attacked.p_they()] quietly moans in pleasure")
				attacked.adjustPain(PAIN_DEFAULT * 0.66)

			else
				to_chat(user, span_danger("Looks like [attacked]'s chest is covered!"))
				return

	if(!targeted_somewhere)
		return
	if(attacked.stat != DEAD)
		attacked.do_jitter_animation()
		if(prob(50))
			attacked.emote(pick("twitch_s" , "gasp", "shiver"))
	user.visible_message(span_purple("[user] [message]!"))
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/vax1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/vax2.ogg'), 70, TRUE, ignore_walls = FALSE)

#undef CANDLE_LUMINOSITY
#undef PAIN_DEFAULT
*/

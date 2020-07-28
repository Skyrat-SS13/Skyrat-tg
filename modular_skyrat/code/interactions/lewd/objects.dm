//Dildo changes.
/obj/item/dildo
	/*name = "dildo"
	desc = "Hmmm, deal throw."
	icon = 'honk/icons/obj/items/dildo.dmi'
	icon_state = "dildo_map"
	item_state = "dildo"
	throwforce = 0
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slammed", "bashed", "whipped")*/

	var/hole = CUM_TARGET_VAGINA

	/*var/random_color = TRUE
	var/static/list/dildo_colors = list(
		"purple" = "#800080",
		"darkviolet" = "#9400D3",
		"red" = "#FF0000",
		"dimgray" = "#696969",
		"black" = "#000000", //dont kill me for this - lennuel
		"white" = "#ffffff", //racial equality
		"green" = "#008000",
		"pink" = "#FFC0CB",
		"lightpink" = "#ffc0cb",
		"blue" = "#7282e5"
	)

/obj/item/dildo/Initialize()
	. = ..()
	if(random_color) //random colors!
		icon_state = "dildo"
		var/our_color = pick(dildo_colors)
		add_atom_colour(dildo_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_icon()

/obj/item/dildo/update_icon()
	if(!random_color) //icon override
		return
	cut_overlays()
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "dildo_base")
	base_overlay.appearance_flags = RESET_COLOR
	add_overlay(base_overlay) */

/obj/item/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	if(istype(M, /mob/living/carbon/human) && user.zone_selected == BODY_ZONE_PRECISE_GROIN && M.is_bottomless())
		if(M.client && M.client.prefs)
			if(M.client.prefs.toggles & VERB_CONSENT)
				if(hole == CUM_TARGET_VAGINA && M.has_vagina())
					message = (user == M) ? pick("fucks their own pussy with \the [src]","shoves the [src] into their pussy", "jams the [src] into their pussy") : pick("fucks [M] right in the pussy with \the [src]", "jams \the [src] right into [M]'s pussy")
				else if(hole == CUM_TARGET_ANUS && M.has_anus())
					message = (user == M) ? pick("fucks their own ass with \the [src]","shoves the [src] into their ass", "jams the [src] into their ass") : pick("fucks [M]'s asshole with \the [src]", "jams \the [src] into [M]'s ass")
	if(message)
		user.visible_message("<font color=purple>[user] [message].</font>")
		M.handle_post_sex(5, null, user)
		playsound(loc, pick('modular_skyrat/sound/interactions/bang4.ogg',
							'modular_skyrat/sound/interactions/bang5.ogg',
							'modular_skyrat/sound/interactions/bang6.ogg'), 70, 1, -1)
	else if(user.a_intent == INTENT_HARM)
		return ..()

/obj/item/dildo/attack_self(mob/living/carbon/human/user as mob)
	if(hole == CUM_TARGET_VAGINA)
		hole = CUM_TARGET_ANUS
	else
		hole = CUM_TARGET_VAGINA
	to_chat(user, "<span class='warning'>Hmmm. Maybe we should put it in \a [hole]?</span>")

//reagent here
/*datum/reagent/consumable/cum // could probably be made /blood/consumable/cum to just inherit the DNA procs sometime
	name = "cum"
	id = "cum"
	description = "Where you found this is your own business."
	color = "#AAAAAA77"
	taste_description = "something with a tang"
	data = list("donor"=null,"viruses"=null,"donor_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null)
	taste_mult = 2
	reagent_state = LIQUID
	nutriment_factor = 0.5 * REAGENTS_METABOLISM
	glass_icon_state = "glass_white"
	glass_name = "glass of cream"
	glass_desc = "Smells suspicious."
	shot_glass_icon_state = "shotglasscream"

/datum/reagent/consumable/cum/reaction_turf(turf/T, reac_volume)
	if(!istype(T))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/cum/S = locate() in T
	if(!S)
		S = new(T)
	S.reagents.add_reagent("cum", reac_volume)
	if(data["blood_DNA"])
		S.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"])) //yes. STD

//cleanable here

/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "It's pie cream from a cream pie. Or not..."
	gender = PLURAL
	layer = ABOVE_NORMAL_TURF_LAYER
	density = 0
	icon = 'honk/icons/effects/cum.dmi'
	icon_state = "cum1"
	random_icon_states = list("cum1", "cum3", "cum4", "cum5", "cum6", "cum7", "cum8", "cum9", "cum10", "cum11", "cum12")
	mergeable_decal = TRUE
	blood_state = null
	bloodiness = null
	//var/blood_DNA = list()

/obj/effect/decal/cleanable/cum/Initialize()
	. = ..()
	dir = pick(1,2,4,8)
	reagents.add_reagent("cum", rand(8,13))
	add_blood_DNA(list("Unknown DNA" = "O+"))*/

//begin redds code
/obj/item/dildo/cyborg
	name = "F.I.S.T.R. Machine"
	desc = "Fully Integrated Sexual Tension Relief Machine"

/obj/item/dildo/cyborg/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	if(istype(M, /mob/living/carbon/human) && M.is_bottomless())
		if(M.client && M.client.prefs)
			if(M.client.prefs.toggles & VERB_CONSENT)
				if(hole == CUM_TARGET_VAGINA && M.has_vagina())
					message = (user == M) ? pick("fucks their own pussy with \the [src]","shoves the [src] into their pussy", "jams the [src] into their pussy") : pick("fucks [M] right in the pussy with \the [src]", "jams \the [src] right into [M]'s pussy")
				else if(hole == CUM_TARGET_ANUS && M.has_anus())
					message = (user == M) ? pick("fucks their own ass with \the [src]","shoves the [src] into their ass", "jams the [src] into their ass") : pick("fucks [M]'s asshole with \the [src]", "jams \the [src] into [M]'s ass")
	if(message)
		user.visible_message("<font color=purple>[user] [message].</font>")
		M.handle_post_sex(5, null, user)
		playsound(loc, pick('modular_skyrat/sound/interactions/bang4.ogg',
							'modular_skyrat/sound/interactions/bang5.ogg',
							'modular_skyrat/sound/interactions/bang6.ogg'), 70, 1, -1)
	else if(user.a_intent == INTENT_HARM)
		return ..()
//end redds code

/obj/item/pneumatic_cannon/dildo
	color = "#FFC0CB"
	name = "pneumatic cannon"
	desc = "A pneumatic cannon with a picture of a bus printed on the side that resembles an A-shape."
	automatic = TRUE
	selfcharge = TRUE
	gasPerThrow = 0
	checktank = FALSE
	fire_mode = PCANNON_FIFO
	throw_amount = 1
	maxWeightClass = 60
	var/static/list/dildo_typecache = typecacheof(/obj/item/dildo)
	charge_type = /obj/item/dildo

/obj/item/pneumatic_cannon/dildo/Initialize()
	. = ..()
	allowed_typecache = dildo_typecache

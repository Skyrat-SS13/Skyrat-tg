/datum/buildmode_mode/offercontrol
	key = "offercontrol"

/datum/buildmode_mode/offercontrol/show_help(client/c)
	to_chat(c, "<span class='notice'>***********************************************************\n\
		Left Mouse Button on mob/living = Offer control to ghosts.\n\
		***********************************************************</span>")

/datum/buildmode_mode/offercontrol/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)

	if(!ismob(object))
		return

	var/mob/living/mob_to_offer = object

	offer_control(mob_to_offer)

GLOBAL_VAR_INIT(typing_indicator_overlay, mutable_appearance('modular_skyrat/modules/indicators/icons/typing_indicator.dmi', "default0", FLY_LAYER))

/mob
	/// A list of all typing indicator sources. When this list is empty, there's no typing indicator displayed.
	var/list/typing_indicator


/// Sets the typing indicator. Do not call TRUE without a source. If source is left empty, all sources will be cleared. If source is not empty, only the specified source will be set.
/mob/proc/set_typing_indicator(var/state, var/source)
	var/has_indicator = LAZYLEN(typing_indicator)
	if(source)
		if(state)
			LAZYADD(typing_indicator, source)
		else
			LAZYREMOVE(typing_indicator, source)
	else
		if(!state)
			LAZYNULL(typing_indicator)
		else
			stack_trace("set_typing_indicator: source is null, yet state is TRUE")

	if(LAZYLEN(typing_indicator))
		if(!has_indicator)
			add_overlay(GLOB.typing_indicator_overlay)
	else
		cut_overlay(GLOB.typing_indicator_overlay)

/proc/animate_speechbubble(image/I, list/show_to, duration)
	var/matrix/M = matrix()
	M.Scale(0,0)
	I.transform = M
	I.alpha = 0
	for(var/client/C in show_to)
		C.images += I
	animate(I, transform = 0, alpha = 255, time = 5, easing = ELASTIC_EASING)
	sleep(duration-5)
	animate(I, alpha = 0, time = 5, easing = EASE_IN)
	sleep(20)
	for(var/client/C in show_to)
		C.images -= I

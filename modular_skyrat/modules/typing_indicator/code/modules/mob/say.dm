/mob/verb/say_special()
	set name = "say_special"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	set_typing_indicator(TRUE)
	hud_typing = TRUE
	var/message = input("", "say (text)") as text
	hud_typing = FALSE
	set_typing_indicator(FALSE)
	if(message)
		say(message)

/mob/verb/me_special()
	set name = "me_special"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	set_typing_indicator(TRUE)
	hud_typing = TRUE
	var/message = input("", "emote (text)") as message
	trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))
	usr.emote("me",1,message,TRUE)
	hud_typing = FALSE
	set_typing_indicator(FALSE)

/proc/animate_speechbubble(image/I, list/show_to, duration)
	var/matrix/M = matrix()
	M.Scale(0,0)
	I.transform = M
	I.alpha = 0
	for(var/client/C in show_to)
		C.images += I
	animate(I, transform = 0, alpha = 255, time = 5, easing = ELASTIC_EASING)
	spawn(duration-5)
	animate(I, alpha = 0, time = 5, easing = EASE_IN)
	spawn(20)
	for(var/client/C in show_to)
		C.images -= I

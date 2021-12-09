/mob/living/verb/container_emote()
	set name = "Emote Using Vehicle/Container"
	set category = "IC"

	if (isturf(src.loc))
		to_chat(src, span_danger("You are not within anything!"))
		return




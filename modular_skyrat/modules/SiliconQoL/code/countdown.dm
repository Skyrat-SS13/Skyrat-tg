/obj/effect/countdown/transformer_rp
	name = "transformer countdown"
	color = "#4C5866"

/obj/effect/countdown/transformer_rp/get_value()
	var/obj/machinery/transformer_rp/T = attached_to
	if(!istype(T))
		return
	if(T.cooldown && (T.stored_cyborgs > 0))
		return "[round(max(0, (T.cooldown_timer - world.time) / 10))]"
	if(T.stored_cyborgs < 1)
		return "[round(max(0, (T.stored_timer - world.time) / 10))]"

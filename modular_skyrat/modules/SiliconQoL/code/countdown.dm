/obj/effect/countdown/transformer_rp
	name = "transformer countdown"
	color = "#4C5866"

/obj/effect/countdown/transformer_rp/get_value()
	var/obj/machinery/transformer_rp/transformer = attached_to
	if(!istype(transformer))
		return
	if(!transformer.is_operational)
		return
	if(transformer.cooldown && (transformer.stored_cyborgs > 0))
		return "[round(max(0, transformer.cooldown_timer / 10))]"
	if(transformer.stored_cyborgs < 1)
		return "[round(max(0, transformer.stored_timer / 10))]"

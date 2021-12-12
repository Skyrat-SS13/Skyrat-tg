// Proc to use a trim token on an ID
/obj/item/card/id/proc/apply_token(obj/item/trim_token/token, mob/user)
	if(token.has_required_trim)
		if(!(src.trim in token.valid_trims))
			to_chat(user, span_warning("The trim of your ID is not valid for this trim token."))
			return
	if(token.uses == 0)
		to_chat(user, span_warning("The [token.name] disintegrates as you press it against your ID, it probably only barely had enough charge left to keep its shape!"))
		qdel(token)
		return

	// Just to make sure to give feedback if it requires a better card to grant the trim.
	if(SSid_access.apply_trim_to_card(src, token.token_trim, copy_access = token.force_access))
		playsound(src, token.usesound, 40)
		to_chat(user, span_notice("The [token.name] fuses with your ID, replacing its trim with a [token.assignment] trim!"))
		// If it's INFINITE (-1), it won't be affected by this.
		if(token.uses > 0)
			token.uses -= 1
		if(token.uses == 0)
			qdel(token)
			return
		to_chat(user, span_notice("The [token.name] reforms into a solid token before your eyes, after having successfully replaced your ID's trim. Nice."))
		return
	else
		to_chat(user, span_warning("Your ID is not rare enough to support this trim upgrade!"))

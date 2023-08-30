/obj/item/stack/medical/gauze
	var/intergrity = 2 //todo: move documentation from bodypart_aid

/obj/item/stack/medical/gauze/proc/get_hit()
	integrity--
	if(integrity <= 0)
		if(bodypart.owner)
			to_chat(bodypart.owner, span_warning("The [name] on your [bodypart.name] tears and falls off!"))
		qdel(src)

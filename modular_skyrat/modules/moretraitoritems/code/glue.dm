/obj/item/syndie_glue
	name = "bottle of super glue"
	desc = "A black market brand of high strength adhesive, rarely sold to the public. Do not ingest."
	icon = 'modular_skyrat/master_files/icons/obj/tools.dmi'
	icon_state	= "glue"
	w_class = WEIGHT_CLASS_SMALL
	var/uses = 1


/obj/item/syndie_glue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !target)
		return
	else
		if(!uses)
			to_chat(user, span_warning("The bottle of glue is empty!"))
			return
		if(istype(target, /obj/item))
			var/obj/item/I = target
			if(HAS_TRAIT_FROM(I, TRAIT_NODROP, TRAIT_GLUED_ITEM))
				to_chat(user, span_warning("[I] is already sticky!"))
				return
			uses -= 1
			ADD_TRAIT(I, TRAIT_NODROP, TRAIT_GLUED_ITEM)
			I.desc += " It looks sticky."
			to_chat(user, span_notice("You smear the [I] with glue, making it incredibly sticky!"))
			if(uses == 0)
				icon_state = "glue_used"
				name = "empty bottle of super glue"
			return

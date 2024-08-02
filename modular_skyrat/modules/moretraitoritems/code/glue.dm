/obj/item/syndie_glue
	name = "bottle of super glue"
	desc = "A black market brand of high strength adhesive, rarely sold to the public. Do not ingest."
	icon = 'modular_skyrat/master_files/icons/obj/tools.dmi'
	icon_state	= "glue"
	w_class = WEIGHT_CLASS_SMALL
	var/uses = 1


/obj/item/syndie_glue/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!uses)
		to_chat(user, span_warning("The bottle of glue is empty!"))
		return NONE
	if(!isitem(interacting_with))
		return NONE
	if(HAS_TRAIT_FROM(interacting_with, TRAIT_NODROP, TRAIT_GLUED_ITEM))
		to_chat(user, span_warning("[interacting_with] is already sticky!"))
		return ITEM_INTERACT_BLOCKING

	uses -= 1
	ADD_TRAIT(interacting_with, TRAIT_NODROP, TRAIT_GLUED_ITEM)
	interacting_with.desc += " It looks sticky."
	to_chat(user, span_notice("You smear the [interacting_with] with glue, making it incredibly sticky!"))
	if(uses == 0)
		icon_state = "glue_used"
		name = "empty bottle of super glue"
	return ITEM_INTERACT_SUCCESS

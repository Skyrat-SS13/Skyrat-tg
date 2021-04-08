/obj/item/dancer_pole
	name = "pole parts"
	desc = "Parts of a pole, ready for assembly."
	icon = 'modular_skyrat/modules/nsfw/misc/dancerpole.dmi'
	icon_state = "pole_parts"
	flags_1 = CONDUCT_1
	custom_materials = list(/datum/material/iron=2000)
	anchored = FALSE
	can_buckle = FALSE	//this is changed whenever its anchored
	buckle_requires_restraints = TRUE
	buckle_lying = NO_BUCKLE_LYING

/obj/item/dancer_pole/examine(mob/user)
	. = ..()
	if(src.anchored == TRUE)
		. += "<span class='notice'>You can disassemble this with a wrench!</span>"
	else
		. += "<span class='notice'>You can assemble this with a wrench!</span>"
		. += "<span class='notice'>You can disassemble this with a welder!</span>"

/obj/item/dancer_pole/attackby(obj/item/used_tool, mob/user, params)
	. = ..()
	if(src.anchored == TRUE)
		if(LAZYLEN(buckled_mobs) != 0)
			to_chat(user, "<span class='notice'>You can't reach the bolts with someone buckled to this! Untie them first!</span>")
			return
		if (used_tool.tool_behaviour == TOOL_WRENCH)
			to_chat(user, "<span class='notice'>You start to disassemble [src]...</span>")
			if(used_tool.use_tool(src, user, 30, volume=80))
				to_chat(user, "<span class='notice'>You disassemble and re-pack the pole parts.</span>")
				src.name = "pole parts"
				src.desc = "Parts of a pole, ready for assembly."
				src.icon_state = "pole_parts"
				can_buckle = FALSE
				anchored = FALSE
			return
		else if(used_tool.tool_behaviour == TOOL_WELDER)
			to_chat(user, "<span class='warning'>You need to disassemble [src] before you can weld it into its components!</span>")
			return
		return
	else		
		if (used_tool.tool_behaviour == TOOL_WRENCH)
			to_chat(user, "<span class='notice'>You start to assemble the [src]...</span>")
			if(used_tool.use_tool(src, user, 30, volume=80))
				to_chat(user, "<span class='notice'>You assemble and anchor the dancer pole.</span>")
				src.name = "dancer pole"
				src.desc = "Hey, at least it makes them money."
				src.icon_state = "dancerpole"
				var/obj/item/held_item = user.get_inactive_held_item()
				if(held_item == src)
					user.dropItemToGround(src)
				can_buckle = TRUE
				anchored = TRUE
			return
		else if(used_tool.tool_behaviour == TOOL_WELDER)
			to_chat(user, "<span class='notice'>You start welding [src] back into its components...</span>")
			if(do_after(user, 25, target = user, progress=TRUE))
				new /obj/item/stack/sheet/iron(user.loc,2)
				new /obj/item/stack/rods(user.loc,8)
				qdel(src)
	return

/datum/crafting_recipe/dancer_pole
	name = "Dancer Pole Parts"
	result = /obj/item/dancer_pole
	reqs = list(/obj/item/stack/rods = 8,
				/obj/item/stack/sheet/iron = 2)
	tool_behaviors =  list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 20
	category= CAT_MISC

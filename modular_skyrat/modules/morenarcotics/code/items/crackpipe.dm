/obj/item/clothing/mask/cigarette/pipe/crackpipe
	name = "crack pipe"
	desc = "A slick glass pipe made for smoking one thing: crack."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	worn_icon = 'modular_skyrat/modules/morenarcotics/icons/mask.dmi'
	icon_state = "glass_pipeoff" //it seems like theres some unused crack pipe sprite in masks.dmi, sweet!
	icon_on = "glass_pipeon"
	icon_off = "glass_pipeoff"
	smoke_all = TRUE

/obj/item/clothing/mask/cigarette/pipe/crackpipe/attackby(obj/item/thing, mob/user, params)
	// prevent plants from being put in crack pipes
	if(istype(thing, /obj/item/food/grown))
		return

	if(!istype(thing, /obj/item/smokable))
		return ..()

	var/obj/item/smokable/to_smoke = thing
	if(packeditem)
		to_chat(user, span_warning("It is already packed!"))
		return

	to_chat(user, span_notice("You stuff [to_smoke] into [src]."))
	smoketime = 2 MINUTES
	packeditem = to_smoke.name
	update_name()
	if(to_smoke.reagents)
		to_smoke.reagents.trans_to(src, to_smoke.reagents.total_volume, transfered_by = user)
	qdel(to_smoke)

/datum/crafting_recipe/crackpipe
	name = "Crack pipe"
	result = /obj/item/clothing/mask/cigarette/pipe/crackpipe
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/shard = 1,
				/obj/item/stack/rods = 10)
	parts = list(/obj/item/shard = 1)
	time = 20
	category = CAT_CHEMISTRY

/**
 * The Seegson drive. Basically a warp drive. This enables you to traverse deep space.
 *
 * It is a built in function of all spacepods, however, you require fuel cells to use it.
 */


// Fuel cell and components
/obj/item/fuel_casing
	name = "fuel cell casing"
	desc = "A casing for a Seegson Drive fuel cell. Combine this with a sheet of uranium to obtain a fuel cell."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "fuel_casing"

/obj/item/fuel_casing/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/uranium))
		var/obj/item/stack/sheet/mineral/uranium/uranium_stack = attacking_item
		if(!uranium_stack.use(1))
			to_chat(user, span_warning("You don't have enough uranium to make a fuel cell."))
			return
		to_chat(user, span_notice("You start inserting the uranium into the fuel casing."))
		if(do_after(user, 3 SECONDS, src))
			new /obj/item/fuel_cell(get_turf(src))
			to_chat(user, span_notice("You fabricate the fuel cell!"))
			qdel(src)

/obj/item/fuel_cell
	name = "fuel cell"
	desc = "A fuel cell for the Seegson Drive. Insert this into your pod to power the inbuilt Seegson drive."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "fuel_cell"

/obj/item/grown
	var/thread_type = null

/obj/item/grown/proc/set_up_looming()
	if(!thread_type)
		return

	AddComponent(/datum/component/loomable, thread_type)

/obj/item/grown/cotton
	thread_type = /obj/item/stack/dwarf_certified/thread/cotton

/obj/item/grown/reeds
	name = "river reeds"
	desc = "The stalks of reeds commonly found growing near sources of water."
	icon_state = "grassclump"
	w_class = WEIGHT_CLASS_SMALL
	thread_type = /obj/item/stack/dwarf_certified/thread/reed

/obj/item/grown/flax
	name = "flax"
	desc = "A flower from a flax plant, known for its use in making seed oil and plant thread."
	icon_state = "harebell"
	w_class = WEIGHT_CLASS_SMALL
	thread_type = /obj/item/stack/dwarf_certified/thread/flax

// This isn't really a plant but it falls here for stuff fabrics need

/obj/structure/spider/stickyweb/Destroy()
	new /obj/item/stack/dwarf_certified/thread/silk(drop_location())
	. = ..()

/obj/structure/spider/stickyweb/examine(mob/user)
	. = ..()

	. += span_notice("You could probably get some spider silk thread if you broke [src].")

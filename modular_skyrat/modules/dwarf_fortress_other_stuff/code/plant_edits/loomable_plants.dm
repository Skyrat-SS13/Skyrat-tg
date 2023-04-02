/obj/item/grown
	var/thread_type = null

/obj/item/grown/proc/set_up_looming()
	if(!thread_type)
		return

	AddComponent(/datum/component/loomable, thread_type)

/obj/item/grown/cotton
	thread_type = /obj/item/stack/dwarf_certified/thread/cloth

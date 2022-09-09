// To make the synth parts their own category
/obj/machinery/mecha_part_fabricator/Initialize(mapload)
	. = ..()
	part_sets += list("Synthetic Parts") // This is fine to do, part_sets never gets checked using initial()

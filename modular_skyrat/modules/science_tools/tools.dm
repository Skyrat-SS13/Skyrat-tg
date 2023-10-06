/obj/item/crowbar/power/science
	icon_state = "jaws_sci"
	force_opens = FALSE

/obj/item/crowbar/power/science/Initialize(mapload)
	. = ..()

	// on init so we dont have to keep updating the desc on upstream updates
	desc += " This one lacks most of the expected hydraulic power, making it incapable of prying open powered doors."

/obj/item/screwdriver/power/science
	icon_state = "drill_sci"

/obj/item/screwdriver/power/science/Initialize(mapload)
	. = ..()

	desc += " This one sports a nifty science paintjob, but is otherwise normal."

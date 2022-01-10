/obj/structure/marker/special/resource
	name = "resource marker"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blob_resource"
	color = COLOR_MARKER_RED
	desc = "A thin spire of slightly swaying tendrils."
	max_integrity = MARKER_RESOURCE_MAX_HP
	point_return = MARKER_REFUND_RESOURCE_COST
	resistance_flags = LAVA_PROOF
	var/resource_delay = 0

/obj/structure/marker/special/resource/scannerreport()
	return "Gradually supplies the marker with resources, increasing the rate of expansion."

/obj/structure/marker/special/resource/creation_action()
	if(overmind)
		overmind.resource_markers += src

/obj/structure/marker/special/resource/Destroy()
	if(overmind)
		overmind.resource_markers -= src
	return ..()

/obj/structure/marker/special/resource/Be_Pulsed()
	. = ..()
	if(resource_delay > world.time)
		return
	flick("marker_resource_glow", src)
	if(overmind)
		overmind.add_points(MARKER_RESOURCE_GATHER_AMOUNT)
		resource_delay = world.time + MARKER_RESOURCE_GATHER_DELAY + overmind.resource_markers.len * MARKER_RESOURCE_GATHER_ADDED_DELAY //4 seconds plus a quarter second for each resource marker the overmind has
	else
		resource_delay = world.time + MARKER_RESOURCE_GATHER_DELAY

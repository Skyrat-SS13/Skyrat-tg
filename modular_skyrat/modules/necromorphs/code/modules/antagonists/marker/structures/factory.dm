/obj/structure/marker/special/factory
	name = "factory marker"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blob_factory"
	desc = "A thick spire of tendrils."
	max_integrity = MARKER_FACTORY_MAX_HP
	health_regen = MARKER_FACTORY_HP_REGEN
	point_return = MARKER_REFUND_FACTORY_COST
	resistance_flags = LAVA_PROOF
	max_spores = MARKER_FACTORY_MAX_SLASHERS

/obj/structure/marker/special/factory/scannerreport()
	if(brute)
		return "It is currently sustaining a markerberbrute, making it fragile and unable to produce marker slashers."
	return "Will produce a marker slasher every few seconds."

/obj/structure/marker/special/factory/creation_action()
	if(overmind)
		overmind.factory_markers += src

/obj/structure/marker/special/factory/Destroy()
	for(var/mob/living/simple_animal/hostile/necromorph/slasher in slashers)
		if(slasher.factory == src)
			slasher.factory = null
	if(brute)
		brute.factory = null
		to_chat(brute, span_userdanger("Your factory was destroyed! You feel yourself dying!"))
		brute.throw_alert("nofactory", /atom/movable/screen/alert/nofactory)
	slashers = null
	if(overmind)
		overmind.factory_markers -= src
	return ..()

/obj/structure/marker/special/factory/Be_Pulsed()
	. = ..()
	produce_spores()
